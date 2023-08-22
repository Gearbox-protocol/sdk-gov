import {
  AddressProvider,
  AddressProvider__factory,
  CreditConfigurator,
  CreditConfigurator__factory,
  CreditFacade,
  CreditFacade__factory,
  CreditManager,
  CreditManager__factory,
  PriceOracle__factory,
} from "@gearbox-protocol/core-v2";
import {
  ADDRESS_0X0,
  ADDRESS_PROVIDER,
  contractsByNetwork,
  detectNetwork,
  extractTokenData,
  formatBN,
  ICreditFacade__factory,
  IERC20__factory,
  NetworkType,
  NOT_DEPLOYED,
  supportedChains,
  SupportedContract,
  SupportedToken,
  tokenDataByNetwork,
  WAD,
} from "@gearbox-protocol/sdk";
import { BigNumber, ethers } from "ethers";

import { PERCENTAGE_FACTOR, UNIVERSAL_CONTRACT } from "../../base/constants";
import { isContractIdentical } from "../../base/is-contract-identical";
import { calculateLiquidationCoverage } from "../../base/premium-coverage";
import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult, UnderlyingToken } from "../../base/types";
import { IsContract } from "../../base/utils";

export class CreditConfiguratorV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  #network: NetworkType | undefined;
  #isInit = false;

  #creditConfigurator: CreditConfigurator;
  #creditManager: CreditManager | undefined;
  #creditFacade: CreditFacade | undefined;
  #addressProvider: AddressProvider | undefined;
  #underlying: UnderlyingToken | undefined;

  constructor(args: { address: string; provider: ethers.providers.Provider }) {
    const { address, provider } = args;
    super();
    this.#provider = provider;
    this.#creditConfigurator = CreditConfigurator__factory.connect(
      address,
      provider,
    );
  }

  async #initialize() {
    if (this.#isInit) return;

    const network = await detectNetwork(this.#provider);
    if (!supportedChains.includes(network))
      throw new Error("Provider's network is not supported");
    this.#network = network;

    // Check if contract is configurator, it has valid addressProvider property
    const addressProvider = await this.#creditConfigurator.addressProvider();
    if (addressProvider !== ADDRESS_PROVIDER[this.#network])
      throw new Error("This address is not Credit Configurator");

    const cmAddress = await this.#creditConfigurator.creditManager();
    this.#creditManager = CreditManager__factory.connect(
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
    this.#creditFacade = CreditFacade__factory.connect(
      cfAddress,
      this.#provider,
    );

    this.#addressProvider = AddressProvider__factory.connect(
      ADDRESS_PROVIDER[this.#network],
      this.#provider,
    );

    this.#isInit = true;
  }

  //
  // CONFIGURATION: TOKEN MANAGEMENT
  //

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-add-collateral-token.ts
  async addCollateralToken(
    token: SupportedToken,
    liquidationThreshold: number,
    force = false,
  ) {
    await this.#initialize();

    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: addCollateralToken ${token} with liquidationThreshold ${liquidationThreshold}`,
    );

    // according to the sc code, check two internal functions: addCollateralToken and _setLiquidationThreshold
    const validationResult = await this.addCollateralTokenValidate(
      token,
      liquidationThreshold,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    const tokenAddress = tokenDataByNetwork[this.#network!][token];

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "addCollateralToken(address,uint16)",
      args: [tokenAddress, liquidationThreshold],
      validationResult: validationResult,
    });
  }

  async addCollateralTokenValidate(
    token: SupportedToken,
    liquidationThreshold: number,
  ) {
    await this.#initialize();
    this.logger.info(
      `CC: ${this.#underlying!.token}: Validating addCollateralToken ${token} `,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const tokenAddress = tokenDataByNetwork[this.#network!][token];
    // check if token is deployed for current network
    if (tokenAddress === NOT_DEPLOYED) {
      validationResult.errors.push(`Token ${token} is not deployed`);
    }

    // Checks that the contract has balanceOf method
    const erc20 = IERC20__factory.connect(tokenAddress, this.#provider);
    try {
      await erc20.balanceOf(this.#creditConfigurator.address);
    } catch (e) {
      validationResult.errors.push(
        `Token ${token} does not have balanceOf method`,
      );
    }

    // Checks that the token has a correct priceFeed in priceOracle
    const priceOracleAddress = await this.#creditManager!.priceOracle();
    const priceOracle = PriceOracle__factory.connect(
      priceOracleAddress,
      this.#provider,
    );
    try {
      await priceOracle.convertToUSD(WAD, tokenAddress);
    } catch (e) {
      validationResult.errors.push(
        `Token ${token} does not have correct priceFeed in priceOracle`,
      );
    }

    // check liquidation threshold
    const [_, ltUnderlying] = await this.#creditManager!.collateralTokens(0);
    if (liquidationThreshold > ltUnderlying) {
      validationResult.errors.push(
        `liquidationThreshold ${liquidationThreshold} > ltUnderlying ${ltUnderlying}`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-liquidation-threshold.ts
  async setLiquidationThreshold(
    token: SupportedToken,
    liquidationThreshold: number,
    force = false,
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

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

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

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const tokenAddress = tokenDataByNetwork[this.#network!][token];

    // check if token is deployed for current network
    if (tokenAddress === NOT_DEPLOYED) {
      validationResult.errors.push(`Token ${token} is not deployed`);
    }

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

    //  The LT should be less than underlying
    const [_, ltUnderlying] = await this.#creditManager!.collateralTokens(0);
    if (liquidationThreshold > ltUnderlying) {
      validationResult.errors.push(
        `liquidationThreshold ${liquidationThreshold} > ltUnderlying ${ltUnderlying}`,
      );
    }

    // current lt is not the same
    try {
      const currentLT =
        await this.#creditManager!.liquidationThresholds(tokenAddress);
      if (currentLT === liquidationThreshold) {
        validationResult.warnings.push(
          `liquidationThreshold ${liquidationThreshold} is the same as current LT ${currentLT}`,
        );
      }
    } catch (e: any) {
      validationResult.errors.push(`${e.errorName || "Look at console"}`);
      if (!e.errorName) {
        console.log(e);
      }
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-allow-token.ts
  async allowToken(token: SupportedToken, force = false) {
    await this.#initialize();
    this.logger.info(
      `CC: ${this.#underlying!.token}: allowTokenValidate ${token}`,
    );

    const validationResult = await this.allowTokenValidate(token);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

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

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const tokenAddress = tokenDataByNetwork[this.#network!][token];

    // check if address is supported token
    const tokenMask = await this.#creditManager!.tokenMasksMap(tokenAddress);
    if (tokenMask.eq(BigNumber.from("0")))
      validationResult.errors.push(`Token ${token} is not collateral`);

    if (tokenMask.eq(BigNumber.from("1")))
      validationResult.errors.push(`Token ${token} is underlyng`);

    // warning if token has already been allowed
    const forbiddenTokenMask = await this.#creditManager!.forbiddenTokenMask();
    if (forbiddenTokenMask.and(tokenMask).eq(0)) {
      validationResult.warnings.push(`Token ${token} is already allowed`);
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-forbid-token.ts
  async forbidToken(token: SupportedToken, force = false) {
    await this.#initialize();

    const validationResult = await this.forbidTokenValidate(token);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    const tokenAddress = tokenDataByNetwork[this.#network!][token];

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "forbidToken(address)",
      args: [tokenAddress],
      validationResult,
    });
  }

  async forbidTokenValidate(token: SupportedToken) {
    await this.#initialize();
    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: Validating token ${token} for forbidTokenValidate`,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const tokenAddress = tokenDataByNetwork[this.#network!][token];

    const tokenMask = await this.#creditManager!.tokenMasksMap(tokenAddress);
    if (tokenMask.eq(BigNumber.from("0")))
      validationResult.errors.push(`Token ${token} is not collateral`);

    if (tokenMask.eq(BigNumber.from("1")))
      validationResult.errors.push(`Token ${token} is underlyng`);

    const forbiddenTokenMask = await this.#creditManager!.forbiddenTokenMask();
    if (!forbiddenTokenMask.and(tokenMask).eq(0)) {
      validationResult.warnings.push(`Token ${token} is already forbidden`);
    }

    return validationResult;
  }

  //
  // CONFIGURATION: CONTRACTS & ADAPTERS MANAGEMENT
  //

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-allow-contract.ts
  async allowContract(
    targetContract: SupportedContract,
    adapter: Address,
    force = false,
  ) {
    await this.#initialize();

    const validationResult = await this.allowContractValidate(
      targetContract,
      adapter,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "allowContract(address,address)",
      args: [targetContract, adapter],
      validationResult,
    });
  }

  async allowContractValidate(
    targetContract: SupportedContract,
    adapter: Address,
  ) {
    await this.#initialize();

    const targetContractAddress =
      contractsByNetwork[this.#network!][targetContract];

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // zero-address exception
    if (targetContractAddress === ADDRESS_0X0)
      validationResult.errors.push(`Target contract is zero address`);

    // sanity checks that the address is a contract compatible with the current Credit Manager
    const isContract = await IsContract(targetContractAddress, this.#provider!);
    if (!isContract && targetContractAddress !== UNIVERSAL_CONTRACT) {
      validationResult.errors.push(
        `Target contract ${targetContract} is not a contract`,
      );
    }

    if (!this.#isContractCompatible(adapter)) {
      validationResult.errors.push(
        `Target contract ${targetContract} is not compatible with adapter ${adapter}`,
      );
    }

    // Additional check that adapter or targetContract is not creditManager or creditFacade.
    if (targetContract === this.#creditManager!.address) {
      validationResult.errors.push(
        `Target contract ${targetContract} is creditManager`,
      );
    }

    if (targetContract === this.#creditFacade!.address) {
      validationResult.errors.push(
        `Target contract ${targetContract} is creditFacade`,
      );
    }

    if (adapter === this.#creditManager!.address) {
      validationResult.errors.push(
        `Adapter contract ${adapter} is creditManager`,
      );
    }

    if (adapter === this.#creditFacade!.address) {
      validationResult.errors.push(
        `Adapter contract ${adapter} is creditFacade`,
      );
    }

    // Checks that adapter is not used for another target
    const adapterToContract =
      await this.#creditManager!.adapterToContract(adapter);

    if (adapterToContract !== ADDRESS_0X0) {
      validationResult.errors.push(
        `Adapter ${adapter} is already used for contract ${adapterToContract}`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-forbid-contract.ts
  async forbidContract(targetContract: string, force = false) {
    await this.#initialize();

    const validationResult = await this.forbidContractValidate(targetContract);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "forbidContract(address)",
      args: [targetContract],
      validationResult,
    });
  }

  async forbidContractValidate(targetContract: string) {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // Checks that targetContract has a connected adapter
    const contractToAdapter =
      await this.#creditManager!.contractToAdapter(targetContract);

    if (contractToAdapter === ADDRESS_0X0) {
      validationResult.errors.push(
        `Contract ${targetContract} has no connected adapter`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-forbid-adapter.ts
  async forbidAdapter(adapter: SupportedContract, force = false) {
    await this.#initialize();

    const validationResult = await this.forbidAdapterValidate(adapter);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "forbidAdapter(address)",
      args: [adapter],
      validationResult,
    });
  }

  async forbidAdapterValidate(adapter: SupportedContract) {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const adapterAddress = contractsByNetwork[this.#network!][adapter];
    /// If the adapter already has no linked target contract, then there is nothing to change
    const adapterToContract =
      await this.#creditManager!.adapterToContract(adapterAddress);

    if (adapterToContract === ADDRESS_0X0) {
      validationResult.errors.push(
        `Adapter ${adapter} has no linked target contract`,
      );
    }

    return validationResult;
  }

  //
  // CREDIT MANAGER MGMT
  //

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-limits.ts
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
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

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

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    if (minBorrowedAmount.gt(maxBorrowedAmount)) {
      validationResult.errors.push(
        "minBorrowedAmount is bigger than maxBorrowedAmount",
      );
    }

    const [blockLimit] = await this.#creditFacade!.params();

    if (maxBorrowedAmount.gt(blockLimit)) {
      validationResult.errors.push(
        `maxBorrowedAmount ${maxBorrowedAmount.toString()} is bigger than blockLimit ${blockLimit.toString()}`,
      );
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

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-fees.ts
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
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

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

    const validationResult: TxValidationResult = {
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

    // check liquidation_premium/liquidation_cost coverage for current fees

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

  //
  // CONTRACT UPGRADES
  //

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-upgrade-price-oracle.ts
  async upgradePriceOracle(force = false) {
    await this.#initialize();

    const validationResult = await this.upgradePriceOracleValidate();

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "upgradePriceOracle()",
      args: [],
      validationResult: validationResult,
    });
  }

  async upgradePriceOracleValidate() {
    await this.#initialize();
    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // warning if no need to update price oracle
    const priceOracle = await this.#addressProvider!.getPriceOracle();
    const currentPriceOracle = await this.#creditManager!.priceOracle();

    if (priceOracle === currentPriceOracle) {
      validationResult.warnings.push(
        `Price oracle ${priceOracle} is already set`,
      );
    }

    const identityCheckResult = await isContractIdentical(priceOracle);
    if (!identityCheckResult.identical) {
      validationResult.errors.push(
        `Address ${priceOracle} is not identical to github repo, error: ${identityCheckResult.error}`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-upgrade-credit-facade.ts
  async upgradeCreditFacade(
    creditFacade: string,
    migrateParams: boolean,
    force = false,
  ) {
    await this.#initialize();

    const validationResult = await this.upgradeCreditFacadeValidate(
      creditFacade,
      migrateParams,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "upgradeCreditFacade(address,bool)",
      args: [creditFacade, migrateParams],
      validationResult: validationResult,
    });
  }

  async upgradeCreditFacadeValidate(
    creditFacade: string,
    _migrateParams: boolean,
  ) {
    await this.#initialize();
    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // Checks that the Credit Facade is actually changed, to avoid any redundant actions and events
    if (creditFacade === this.#creditFacade!.address) {
      validationResult.warnings.push(
        `Credit Facade ${creditFacade} is already set`,
      );
    }

    // Sanity checks that the address is a contract and has correct Credit Manager
    if (creditFacade !== ADDRESS_0X0) {
      validationResult.errors.push(`Address ${creditFacade} is zero address`);
    }

    const isContract = await IsContract(creditFacade, this.#provider!);
    if (!isContract) {
      validationResult.errors.push(`Address ${creditFacade} is not a contract`);
    }

    const identityCheckResult = await isContractIdentical(creditFacade);
    if (!identityCheckResult.identical) {
      validationResult.errors.push(
        `Address ${creditFacade} is not identical to github repo, error: ${identityCheckResult.error}`,
      );
    }

    const isContractCompatible = await this.#isContractCompatible(creditFacade);

    if (!isContractCompatible) {
      validationResult.errors.push(
        `Address ${creditFacade} is not compatible with Credit Facade`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-upgrade-credit-configurator.ts
  async upgradeCreditConfigurator(creditConfigurator: string, force = false) {
    await this.#initialize();

    const validationResult =
      await this.upgradeCreditConfiguratorValidate(creditConfigurator);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "upgradeCreditConfigurator(address)",
      args: [creditConfigurator],
      validationResult: validationResult,
    });
  }

  async upgradeCreditConfiguratorValidate(creditConfigurator: string) {
    await this.#initialize();
    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // check if address is not zero
    if (creditConfigurator === ADDRESS_0X0) {
      validationResult.errors.push(`Address ${creditConfigurator} is zero`);
    }

    // check if address is not current address
    if (creditConfigurator === this.#creditConfigurator!.address) {
      validationResult.warnings.push(
        `Address ${creditConfigurator} is actual credit configurator`,
      );
    }

    const identityCheckResult = await isContractIdentical(creditConfigurator);
    if (!identityCheckResult.identical) {
      validationResult.errors.push(
        `Address ${creditConfigurator} is not identical to github repo, error: ${identityCheckResult.error}`,
      );
    }

    const isContractCompatible =
      await this.#isContractCompatible(creditConfigurator);
    if (!isContractCompatible) {
      validationResult.errors.push(
        `Address ${creditConfigurator} is not compatible with Credit Configurator`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-forbid-borrowing.ts
  async setIncreaseDebtForbidden(mode: boolean, force = false) {
    await this.#initialize();

    const validationResult = await this.setIncreaseDebtForbiddenValidate(mode);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setIncreaseDebtForbidden(bool)",
      args: [mode],
      validationResult: validationResult,
    });
  }

  async setIncreaseDebtForbiddenValidate(mode: boolean) {
    await this.#initialize();
    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // add warning msg.sender should be pausable or unpausable admin
    if (mode) {
      validationResult.warnings.push(`msg.sender must be pausable admin`);
    } else {
      validationResult.warnings.push(`msg.sender must be unpausable admin`);
    }

    const [, isIncreaseDebtForbidden, ,] = await this.#creditFacade!.params();
    if (mode === isIncreaseDebtForbidden) {
      validationResult.warnings.push(
        `Increase debt forbidden mode is already set to ${mode}`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-limit-per-block.ts
  async setLimitPerBlock(newLimit: BigNumber, force = false) {
    await this.#initialize();

    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: setLimitPerBlock to ${newLimit} wei per block`,
    );
    const validationResult = await this.setLimitPerBlockValidate(newLimit);

    if (validationResult.errors.length && !force) throw validationResult;

    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setLimitPerBlock(uint128)",
      args: [newLimit],
      validationResult: validationResult,
    });
  }

  async setLimitPerBlockValidate(newLimit: BigNumber) {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const [maxBorrowedAmountPerBlock, , ,] = await this.#creditFacade!.params();
    const [, maxBorrowedAmount] = await this.#creditFacade!.limits();

    if (newLimit.lt(maxBorrowedAmount)) {
      validationResult.errors.push(
        `New limit per block ${newLimit} is less than current max borrowed amount ${maxBorrowedAmount}`,
      );
    }

    if (maxBorrowedAmountPerBlock.eq(newLimit)) {
      validationResult.warnings.push(
        `New limit per block ${newLimit} is equal to current limit per block`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-expiration-date.ts
  async setExpirationDate(newExpirationDate: number, force = false) {
    await this.#initialize();

    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: setExpirationDate to ${newExpirationDate}`,
    );
    const validationResult =
      await this.setExpirationDateValidate(newExpirationDate);

    if (validationResult.errors.length && !force) throw validationResult;

    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setExpirationDate(uint40)",
      args: [newExpirationDate],
      validationResult: validationResult,
    });
  }

  async setExpirationDateValidate(newExpirationDate: number) {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const [, , expirationDate] = await this.#creditFacade!.params();

    if (expirationDate >= newExpirationDate) {
      validationResult.warnings.push(
        `New expiration date ${newExpirationDate} is less than current expiration date ${expirationDate}`,
      );
    }

    const block = await this.#provider.getBlock("latest");
    const timestamp = block.timestamp;

    if (timestamp > newExpirationDate) {
      validationResult.errors.push(
        `New expiration date ${newExpirationDate} is less than current timestamp ${timestamp}`,
      );
    } else {
      validationResult.warnings.push(
        `Check that new expiration date ${newExpirationDate} should be more than block.timestamp on the moment of tx execution`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-max-enabled-tokens.ts
  async setMaxEnabledTokens(maxEnabledTokens: number, force = false) {
    await this.#initialize();

    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: setMaxEnabledTokens to ${maxEnabledTokens}`,
    );
    const validationResult =
      await this.setMaxEnabledTokensValidate(maxEnabledTokens);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

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
    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const actualMaxEnabledTokens =
      await this.#creditManager!.maxAllowedEnabledTokenLength();

    if (maxEnabledTokens === actualMaxEnabledTokens) {
      validationResult.warnings.push(
        `New max enabled tokens ${maxEnabledTokens} is equal to current max enabled tokens param`,
      );
    }

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

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-add-emergency-liquidator.ts
  async addEmergencyLiquidator(liquidator: string, force = false) {
    await this.#initialize();

    this.logger.info(
      `CC: ${this.#underlying!.token}: addEmergencyLiquidator to ${liquidator}`,
    );
    const validationResult =
      await this.addEmergencyLiquidatorValidate(liquidator);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "addEmergencyLiquidator(address)",
      args: [liquidator],
      validationResult: validationResult,
    });
  }

  async addEmergencyLiquidatorValidate(liquidator: string) {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const statusCurrent =
      await this.#creditManager!.canLiquidateWhilePaused(liquidator);

    if (statusCurrent) {
      validationResult.warnings.push(
        `Liquidator ${liquidator} is already in emergency liquidators list`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-remove-emergency-liquidator.ts
  async removeEmergencyLiquidator(liquidator: string, force = false) {
    await this.#initialize();

    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: removeEmergencyLiquidator to ${liquidator}`,
    );
    const validationResult =
      await this.removeEmergencyLiquidatorValidate(liquidator);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "removeEmergencyLiquidator(address)",
      args: [liquidator],
      validationResult: validationResult,
    });
  }

  async removeEmergencyLiquidatorValidate(liquidator: string) {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const statusCurrent =
      await this.#creditManager!.canLiquidateWhilePaused(liquidator);

    if (!statusCurrent) {
      validationResult.warnings.push(
        `Liquidator ${liquidator} is not in emergency liquidators list`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-max-cumulative-loss.ts
  async setMaxCumulativeLoss(cumulativeLoss: BigNumber, force = false) {
    await this.#initialize();

    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: setMaxCumulativeLoss to ${cumulativeLoss}`,
    );
    const validationResult =
      await this.setMaxCumulativeLossValidate(cumulativeLoss);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setMaxCumulativeLoss(uint128)",
      args: [cumulativeLoss],
      validationResult: validationResult,
    });
  }

  async setMaxCumulativeLossValidate(cumulativeLoss: BigNumber) {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const [, maxCumulativeLossCurrent] = await this.#creditFacade!.lossParams();
    if (maxCumulativeLossCurrent.eq(cumulativeLoss)) {
      validationResult.warnings.push(
        `New max cumulative loss ${cumulativeLoss} is equal to current ${maxCumulativeLossCurrent}`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-reset-cumulative-loss.ts
  async resetCumulativeLoss(force = false) {
    await this.#initialize();

    this.logger.info(`CC: ${this.#underlying!.token}: resetCumulativeLoss`);
    const validationResult = await this.resetCumulativeLossValidate();

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "resetCumulativeLoss()",
      args: [],
      validationResult: validationResult,
    });
  }

  async resetCumulativeLossValidate() {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // nothing to validate

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-emergency-liquidation-discount.ts
  async setEmergencyLiquidationDiscount(newPremium: number, force = false) {
    await this.#initialize();

    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: setEmergencyLiquidationDiscount to ${newPremium}`,
    );
    const validationResult =
      await this.setEmergencyLiquidationDiscountValidate(newPremium);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setEmergencyLiquidationDiscount(uint16)",
      args: [newPremium],
      validationResult: validationResult,
    });
  }

  async setEmergencyLiquidationDiscountValidate(newPremium: number) {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    if (newPremium > PERCENTAGE_FACTOR) {
      validationResult.errors.push(
        `New emergency liquidation discount ${newPremium} is greater than ${PERCENTAGE_FACTOR}`,
      );
    }

    const [, , , emergencyLiquidationDiscount] =
      await this.#creditFacade!.params();

    if (newPremium === emergencyLiquidationDiscount) {
      validationResult.warnings.push(
        `New emergency liquidation discount ${newPremium} is equal to current ${emergencyLiquidationDiscount}`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-total-debt-limit.ts
  async setTotalDebtLimit(newLimit: BigNumber, force = false) {
    await this.#initialize();

    this.logger.info(
      `CC: ${this.#underlying!.token}: setTotalDebtLimit to ${newLimit}`,
    );
    const validationResult = await this.setTotalDebtLimitValidate(newLimit);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setTotalDebtLimit(uint128)",
      args: [newLimit],
      validationResult: validationResult,
    });
  }

  async setTotalDebtLimitValidate(newLimit: BigNumber) {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const { totalDebtLimit } = await this.#creditFacade!.totalDebt();
    if (totalDebtLimit.eq(newLimit)) {
      validationResult.warnings.push(
        `New total debt limit ${newLimit} is equal to current ${totalDebtLimit}`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-total-debt-params.ts
  async setTotalDebtParams(
    newCurrentTotalDebt: BigNumber,
    newLimit: BigNumber,
    force = false,
  ) {
    await this.#initialize();

    this.logger.info(
      `CC: ${
        this.#underlying!.token
      }: setTotalDebtParams to ${newCurrentTotalDebt}, ${newLimit}`,
    );
    const validationResult = await this.setTotalDebtParamsValidate(
      newCurrentTotalDebt,
      newLimit,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length || validationResult.errors.length)
      this.logger.warn(
        "Validation has errors/warnings",
        JSON.stringify(validationResult, null, 2),
      );

    return this.createTx({
      contract: this.#creditConfigurator,
      method: "setTotalDebtParams(uint128,uint128)",
      args: [newCurrentTotalDebt, newLimit],
      validationResult: validationResult,
    });
  }

  async setTotalDebtParamsValidate(
    newCurrentTotalDebt: BigNumber,
    newLimit: BigNumber,
  ) {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const { currentTotalDebt, totalDebtLimit } =
      await this.#creditFacade!.totalDebt();

    if (currentTotalDebt.eq(newCurrentTotalDebt)) {
      validationResult.warnings.push(
        `New current total debt ${newCurrentTotalDebt} is equal to current ${currentTotalDebt}`,
      );
    }

    if (totalDebtLimit.eq(newLimit)) {
      validationResult.warnings.push(
        `New total debt limit ${newLimit} is equal to current ${totalDebtLimit}`,
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

  async #isContractCompatible(contract: Address) {
    const creditFacadeInterface = ICreditFacade__factory.connect(
      contract,
      this.#provider,
    );

    try {
      const creditManager = await creditFacadeInterface.creditManager();
      return creditManager === this.#creditManager!.address;
    } catch {
      return false;
    }
  }
}
