import {
  ADDRESS_PROVIDER,
  detectNetwork,
  extractTokenData,
  ICreditConfigurator,
  ICreditConfigurator__factory,
  ICreditFacade,
  ICreditFacade__factory,
  ICreditManagerV2,
  ICreditManagerV2__factory,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { BigNumber, ethers } from "ethers";

import {
  maxETHPice,
  maxGasPerEnabledToken,
  maxGasPrice,
  minTokenPriceUSD,
  PERCENTAGE_FACTOR,
} from "../../base/constants";
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
      provider
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
      this.#provider
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
      this.#provider
    );

    this.#isInit = true;
  }

  async setMaxEnabledTokens(maxEnabledTokens: number, force = false) {
    await this.#initialize();
    const validationResult = await this.setMaxEnabledTokensValidate(
      maxEnabledTokens
    );

    if (validationResult.errors.length && !force) throw validationResult;

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setMaxEnabledTokens(uint8)",
      args: [maxEnabledTokens],
      validationResult: validationResult,
    });
  }

  async setMaxEnabledTokensValidate(maxEnabledTokens: number) {
    await this.#initialize();
    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    const minBorrowedAmount = (await this.#creditFacade!.limits())
      .minBorrowedAmount;
    console.log("minBorrowedAmount", minBorrowedAmount.toString());

    const [liquidationFee, liquidationDiscount] = await this.#fees();

    const liquidationPremiumETH = await this.#liquidationPremiumETH(
      minBorrowedAmount,
      liquidationFee,
      liquidationDiscount
    );
    const liquidationCostETH = await this.#liquidationCostETH(maxEnabledTokens);

    // liquidation premium in ETH whould be more than liquidation cost in ETH
    if (liquidationCostETH.gt(liquidationPremiumETH)) {
      validationResult.warnings.push(
        "setMaxEnabledTokens: Liquation cost is bigger than liquidation premium"
      );
    } else {
      validationResult.warnings.push(
        "setMaxEnabledTokens: Liquation cost is less than liquidation premium for eth 2000$"
      );
    }

    return validationResult;
  }

  async setLimits(
    minBorrowedAmount: BigNumber,
    maxBorrowedAmount: BigNumber,
    force = false
  ) {
    await this.#initialize();

    const validationResult = await this.setLimitsValidate(
      minBorrowedAmount,
      maxBorrowedAmount
    );

    if (validationResult.errors.length && !force) throw validationResult;

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setLimits(uint128,uint128)",
      args: [minBorrowedAmount, maxBorrowedAmount],
      validationResult,
    });
  }

  async setLimitsValidate(
    minBorrowedAmount: BigNumber,
    maxBorrowedAmount: BigNumber
  ) {
    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    if (minBorrowedAmount.gt(maxBorrowedAmount)) {
      validationResult.errors.push(
        "setLimits: minBorrowedAmount is bigger than maxBorrowedAmount"
      );
      return validationResult;
    }

    const [blockLimit] = await this.#creditFacade!.params();

    if (maxBorrowedAmount.gt(blockLimit)) {
      validationResult.errors.push(
        "setLimits: maxBorrowedAmount is bigger than blockLimit"
      );
      return validationResult;
    }

    const maxEnabledTokens =
      await this.#creditManager!.maxAllowedEnabledTokenLength();

    console.log("maxEnabledTokens", maxEnabledTokens.toString());

    const liquidationCostETH = await this.#liquidationCostETH(maxEnabledTokens);

    const [liquidationFee, liquidationDiscount] = await this.#fees();

    const liquidationPremiumETH = await this.#liquidationPremiumETH(
      minBorrowedAmount,
      liquidationFee,
      liquidationDiscount
    );

    if (liquidationCostETH.gt(liquidationPremiumETH)) {
      validationResult.warnings.push(
        "setMaxEnabledTokens: Liquation cost is bigger than liquidation premium"
      );
    } else {
      validationResult.warnings.push(
        "setMaxEnabledTokens: Liquation cost is less than liquidation premium for eth 2000$"
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
    force = false
  ) {
    await this.#initialize();
    const validationResult = await this.setFeesValidate(
      feeInterest,
      feeLiquidation,
      liquidationPremium,
      feeLiquidationExpired,
      liquidationPremiumExpired
    );
    if (validationResult.errors.length && !force) throw validationResult;

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
    liquidationPremiumExpired: number
  ) {
    await this.#initialize();
    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    if (feeInterest > PERCENTAGE_FACTOR) {
      validationResult.errors.push("setFees: feeInterest > 100%");
    }

    if (liquidationPremium + feeInterest > PERCENTAGE_FACTOR) {
      validationResult.errors.push(
        "setFees: liquidationPremium + feeInterest > 100%"
      );
    }

    if (liquidationPremiumExpired + feeLiquidationExpired > PERCENTAGE_FACTOR) {
      validationResult.errors.push(
        "setFees: liquidationPremiumExpired + feeLiquidationExpired > 100%"
      );
    }

    // todo: add other checks from contract code?

    const maxEnabledTokens =
      await this.#creditManager!.maxAllowedEnabledTokenLength();

    const liquidationCostETH = await this.#liquidationCostETH(maxEnabledTokens);

    const minBorrowedAmount = (await this.#creditFacade!.limits())
      .minBorrowedAmount;

    const liquidationDiscount = PERCENTAGE_FACTOR - liquidationPremium;

    const liquidationPremiumETH = await this.#liquidationPremiumETH(
      minBorrowedAmount,
      feeLiquidation,
      liquidationDiscount
    );

    if (liquidationCostETH.gt(liquidationPremiumETH)) {
      validationResult.warnings.push(
        "setMaxEnabledTokens: Liquation cost is bigger than liquidation premium"
      );
    } else {
      validationResult.warnings.push(
        "setMaxEnabledTokens: Liquation cost is less than liquidation premium for eth 2000$"
      );
    }

    return validationResult;
  }

  async allowToken(address: string, force = false) {
    await this.#initialize();
    const validationResult = await this.allowTokenValidate(address);

    if (validationResult.errors.length && !force) throw validationResult;

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "allowToken(address)",
      args: [address],
      validationResult,
    });
  }

  async allowTokenValidate(address: string) {
    await this.#initialize();
    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    // check if address is supported token
    const mask = await this.#creditManager!.tokenMasksMap(address);
    if (mask.eq(BigNumber.from("0")))
      validationResult.errors.push("allowToken: Token is not collateral");

    if (mask.eq(BigNumber.from("1")))
      validationResult.errors.push("allowToken: Token is underlyng");

    return validationResult;
  }

  // utils
  #liquidationCostETH(maxEnabledTokens: number) {
    const liquidationCostETH = maxGasPrice
      .mul(maxGasPerEnabledToken)
      .mul(maxEnabledTokens);
    console.log("liquidationCostETH", liquidationCostETH.toString());
    return liquidationCostETH;
  }

  async #liquidationPremiumETH(
    minBorrowedAmount: BigNumber,
    liquidationFee: number,
    liquidationDiscount: number
  ) {
    console.log("liquidationFee", liquidationFee.toString());
    console.log("liquidationDiscount", liquidationDiscount.toString());

    const ltUnderlying = liquidationDiscount - liquidationFee;

    console.log("ltUnderlying", ltUnderlying.toString());

    const minAmountOnAccount = minBorrowedAmount
      .mul(10000)
      .div(BigNumber.from(ltUnderlying));

    console.log("minAmountOnAccount", minAmountOnAccount.toString());

    const liquidationPremium = minAmountOnAccount
      .mul(10000 - liquidationDiscount)
      .div(10000);

    const liquidationPremiumInUSD = liquidationPremium
      .mul(minTokenPriceUSD(this.#underlying!.token!))
      .mul(BigNumber.from(10).pow(18))
      .div(BigNumber.from(10).pow(this.#underlying!.decimals!));

    const liquidationPremiumInETH = liquidationPremiumInUSD.div(maxETHPice);
    console.log("liquidationPremiumInETH", liquidationPremiumInETH.toString());

    return liquidationPremiumInETH;
  }

  async #fees() {
    const fees = await this.#creditManager!.fees();
    const liquidationFee = fees.feeLiquidation;
    const liquidationDiscount = fees.liquidationDiscount;

    return [liquidationFee, liquidationDiscount];
  }
}
