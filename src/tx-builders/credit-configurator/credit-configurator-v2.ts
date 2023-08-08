import {
  ADDRESS_PROVIDER,
  detectNetwork,
  extractTokenData,
  formatBN,
  ICreditConfigurator,
  ICreditConfigurator__factory,
  ICreditFacade,
  ICreditFacade__factory,
  ICreditManagerV2,
  ICreditManagerV2__factory,
  NetworkType,
  supportedChains,
  SupportedToken,
  tokenDataByNetwork,
} from "@gearbox-protocol/sdk";
import { BigNumber, ethers } from "ethers";

import { PERCENTAGE_FACTOR } from "../../base/constants";
import { calculateLiquidationCoverage } from "../../base/premium-coverage";
import { TxBuilder } from "../../base/TxBuilder";
import { UnderlyingToken, ValidationResult } from "../../base/types";

export class CreditConfiguratorV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  #network: NetworkType | undefined;
  #isInit = false;

  #creditConfigurator: ICreditConfigurator;
  #creditManager: ICreditManagerV2 | undefined;
  #creditFacade: ICreditFacade | undefined;
  #underlying: UnderlyingToken | undefined;

  constructor(args: { address: string; provider: ethers.providers.Provider }) {
    const { address, provider } = args;
    super();
    this.#creditConfigurator = ICreditConfigurator__factory.connect(
      address,
      provider,
    );
    this.#provider = provider;
  }

  async #initialize() {
    if (this.#isInit) return;

    const network = await detectNetwork(this.#provider);
    if (!supportedChains.includes(network))
      throw new Error("Provider's network is not supported");
    this.#network = network;

    // Check if contract is configurator
    // It has valid addressProvider property
    const addressProvider = await this.#creditConfigurator.addressProvider();
    if (addressProvider !== ADDRESS_PROVIDER[this.#network])
      throw new Error("This address is not Credit Configurator");

    const cmAddress = await this.#creditConfigurator.creditManager();
    this.#creditManager = ICreditManagerV2__factory.connect(
      cmAddress,
      this.#provider,
    );

    const underlyingAddress = await this.#creditConfigurator.underlying();
    const [underlyingSymbol, decimals] = extractTokenData(underlyingAddress);
    this.#underlying = {
      token: underlyingSymbol,
      decimals,
    };

    const cfAddress = await this.#creditConfigurator.creditFacade();
    this.#creditFacade = ICreditFacade__factory.connect(
      cfAddress,
      this.#provider,
    );

    this.#isInit = true;
  }

  async setMaxEnabledTokens(maxEnabledTokens: number, force = false) {
    await this.#initialize();

    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: setMaxEnabledTokens to ${maxEnabledTokens}`,
    );
    const validationResult = await this.setMaxEnabledTokensValidate(
      maxEnabledTokens,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setMaxEnabledTokens(uint8)",
      args: [maxEnabledTokens],
      validationResult: validationResult,
    });
  }

  async setMaxEnabledTokensValidate(maxEnabledTokens: number) {
    await this.#initialize();
    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: Validating setMaxEnabledTokens to ${maxEnabledTokens}`,
    );
    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    const minBorrowedAmount = (await this.#creditFacade!.limits())
      .minBorrowedAmount;

    const { liquidationFee, liquidationDiscount } = await this.#fees();

    const { isCovered, liquidationCostETH, liquidationPremiumInETH } =
      calculateLiquidationCoverage({
        minBorrowedAmount,
        liquidationFee,
        liquidationDiscount,
        maxEnabledTokens,
        underlyingToken: this.#underlying!,
      });

    if (!isCovered) {
      validationResult.warnings.push(
        `Liquation cost ${formatBN(
          liquidationCostETH,
          18,
        )} ETH is bigger than liquidation premium ${formatBN(
          liquidationPremiumInETH,
          18,
        )} ETH for $3000/450 gwei for $2000/680 gwei`,
      );
    } else {
      validationResult.warnings.push(
        `Liquation cost ${formatBN(
          liquidationCostETH,
          18,
        )} ETH covered by premium ${formatBN(
          liquidationPremiumInETH,
          18,
        )} ETH for $3000/450 gwei or $2000/680 gwei`,
      );
    }

    return validationResult;
  }

  async setLimits(
    minBorrowedAmount: BigNumber,
    maxBorrowedAmount: BigNumber,
    force = false,
  ) {
    await this.#initialize();
    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: setLimits to minBorrowedAmount: ${minBorrowedAmount.toString()}, maxBorrowedAmount: ${maxBorrowedAmount.toString()}`,
    );

    const validationResult = await this.setLimitsValidate(
      minBorrowedAmount,
      maxBorrowedAmount,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setLimits(uint128,uint128)",
      args: [minBorrowedAmount, maxBorrowedAmount],
      validationResult,
    });
  }

  async setLimitsValidate(
    minBorrowedAmount: BigNumber,
    maxBorrowedAmount: BigNumber,
  ) {
    await this.#initialize();
    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: Validating setLimits to minBorrowedAmount: ${minBorrowedAmount.toString()}, maxBorrowedAmount: ${maxBorrowedAmount.toString()}`,
    );

    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    if (minBorrowedAmount.gt(maxBorrowedAmount)) {
      validationResult.errors.push(
        "minBorrowedAmount is bigger than maxBorrowedAmount",
      );
      return validationResult;
    }

    const [blockLimit] = await this.#creditFacade!.params();

    if (maxBorrowedAmount.gt(blockLimit)) {
      validationResult.errors.push(
        `maxBorrowedAmount ${maxBorrowedAmount.toString()} is bigger than blockLimit ${blockLimit.toString()}`,
      );
      return validationResult;
    }

    const maxEnabledTokens =
      await this.#creditManager!.maxAllowedEnabledTokenLength();
    console.log("current maxEnabledTokens", maxEnabledTokens);

    const { liquidationFee, liquidationDiscount } = await this.#fees();

    const { isCovered, liquidationCostETH, liquidationPremiumInETH } =
      calculateLiquidationCoverage({
        minBorrowedAmount,
        liquidationFee,
        liquidationDiscount,
        maxEnabledTokens,
        underlyingToken: this.#underlying!,
      });

    if (!isCovered) {
      validationResult.warnings.push(
        `Liquation cost ${formatBN(
          liquidationCostETH,
          18,
        )} ETH is bigger than liquidation premium ${formatBN(
          liquidationPremiumInETH,
          18,
        )} ETH for $3000/450 gwei for $2000/680 gwei`,
      );
    } else {
      validationResult.warnings.push(
        `Liquation cost ${formatBN(
          liquidationCostETH,
          18,
        )} ETH covered by premium ${formatBN(
          liquidationPremiumInETH,
          18,
        )} ETH for $3000/450 gwei or $2000/680 gwei`,
      );
    }

    return validationResult;
  }

  async setFees(
    feeInterest: number,
    feeLiquidation: number,
    liquidationPremium: number,
    feeLiquidationExpired: number,
    liquidationPremiumExpired: number,
    force = false,
  ) {
    await this.#initialize();
    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: Setting fees to feeInterest: ${feeInterest} feeLiquidation: ${feeLiquidation} liquidationPremium: ${liquidationPremium} feeLiquidationExpired: ${feeLiquidationExpired} liquidationPremiumExpired: ${liquidationPremiumExpired}`,
    );

    const validationResult = await this.setFeesValidate(
      feeInterest,
      feeLiquidation,
      liquidationPremium,
      feeLiquidationExpired,
      liquidationPremiumExpired,
    );
    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setFees(uint16,uint16,uint16,uint16,uint16)",
      args: [
        feeInterest,
        feeLiquidation,
        liquidationPremium,
        feeLiquidationExpired,
        liquidationPremiumExpired,
      ],
      validationResult,
    });
  }

  async setFeesValidate(
    feeInterest: number,
    feeLiquidation: number,
    liquidationPremium: number,
    feeLiquidationExpired: number,
    liquidationPremiumExpired: number,
  ) {
    await this.#initialize();
    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: Validating fees to feeInterest: ${feeInterest} feeLiquidation: ${feeLiquidation} liquidationPremium: ${liquidationPremium} feeLiquidationExpired: ${feeLiquidationExpired} liquidationPremiumExpired: ${liquidationPremiumExpired}`,
    );

    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    if (feeInterest > PERCENTAGE_FACTOR) {
      validationResult.errors.push("feeInterest > 100%");
    }

    if (liquidationPremium + feeInterest > PERCENTAGE_FACTOR) {
      validationResult.errors.push("liquidationPremium + feeInterest > 100%");
    }

    if (liquidationPremiumExpired + feeLiquidationExpired > PERCENTAGE_FACTOR) {
      validationResult.errors.push(
        "liquidationPremiumExpired + feeLiquidationExpired > 100%",
      );
    }

    // todo: add other checks from contract code?

    const maxEnabledTokens =
      await this.#creditManager!.maxAllowedEnabledTokenLength();

    const minBorrowedAmount = (await this.#creditFacade!.limits())
      .minBorrowedAmount;

    const liquidationDiscount = PERCENTAGE_FACTOR - liquidationPremium;

    const { isCovered, liquidationCostETH, liquidationPremiumInETH } =
      calculateLiquidationCoverage({
        minBorrowedAmount,
        liquidationFee: feeLiquidation,
        liquidationDiscount,
        maxEnabledTokens,
        underlyingToken: this.#underlying!,
      });

    if (!isCovered) {
      validationResult.warnings.push(
        `Liquation cost ${formatBN(
          liquidationCostETH,
          18,
        )} ETH is bigger than liquidation premium ${formatBN(
          liquidationPremiumInETH,
          18,
        )} ETH for $3000/450 gwei for $2000/680 gwei`,
      );
    } else {
      validationResult.warnings.push(
        `Liquation cost ${formatBN(
          liquidationCostETH,
          18,
        )} ETH covered by premium ${formatBN(
          liquidationPremiumInETH,
          18,
        )} ETH for $3000/450 gwei or $2000/680 gwei`,
      );
    }

    return validationResult;
  }

  async allowToken(token: SupportedToken, force = false) {
    await this.#initialize();
    this.logger.info(
      `CC: ${this.#underlying!.token}: allowTokenValidate ${token}`,
    );

    const validationResult = await this.allowTokenValidate(token);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    const tokenAddress = tokenDataByNetwork[this.#network!][token];

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "allowToken(address)",
      args: [tokenAddress],
      validationResult,
    });
  }

  async allowTokenValidate(token: SupportedToken) {
    await this.#initialize();
    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: Validating token ${token} for allowTokenValidate`,
    );

    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    const tokenAddress = tokenDataByNetwork[this.#network!][token];

    // check if address is supported token
    const mask = await this.#creditManager!.tokenMasksMap(tokenAddress);
    if (mask.eq(BigNumber.from("0")))
      validationResult.errors.push(`Token ${tokenAddress} is not collateral`);

    if (mask.eq(BigNumber.from("1")))
      validationResult.errors.push("allowToken: Token is underlyng");

    return validationResult;
  }

  async setLiquidationThreshold(
    token: SupportedToken,
    liquidationThreshold: number,
  ) {
    await this.#initialize();

    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: Setting liquidation threshold to ${liquidationThreshold} for token ${token}`,
    );

    const validationResult = await this.setLiquidationThresholdValidate(
      token,
      liquidationThreshold,
    );

    if (validationResult.errors.length) throw validationResult;

    const tokenAddress = tokenDataByNetwork[this.#network!][token];

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setLiquidationThreshold(address,uint16)",
      args: [tokenAddress, liquidationThreshold],
      validationResult,
    });
  }

  async setLiquidationThresholdValidate(
    token: SupportedToken,
    liquidationThreshold: number,
  ) {
    await this.#initialize();
    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: Validating liquidation threshold to ${liquidationThreshold} for token ${token}`,
    );

    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    const tokenAddress = tokenDataByNetwork[this.#network!][token];

    if (liquidationThreshold < 0) {
      validationResult.errors.push("liquidationThreshold < 0");
    }

    // Checks that the token is not underlying
    const underlying = await this.#creditManager!.underlying();
    if (tokenAddress === underlying) {
      validationResult.errors.push(
        "setLiquidationThreshold: Token is underlying",
      );
    }

    if (liquidationThreshold > PERCENTAGE_FACTOR) {
      validationResult.errors.push(
        "setLiquidationThreshold: liquidationThreshold > 100%",
      );
    }

    return validationResult;
  }

  async #fees() {
    const fees = await this.#creditManager!.fees();
    const liquidationFee = fees.feeLiquidation;
    const liquidationDiscount = fees.liquidationDiscount;

    return { liquidationFee, liquidationDiscount };
  }
}
