import {
  CreditManager__factory,
  IInterestRateModel__factory,
  PoolService,
  PoolService__factory,
} from "@gearbox-protocol/core-v2";
import {
  ADDRESS_0X0,
  detectNetwork,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { BigNumber, ethers } from "ethers";

import { MAX_WITHDRAW_FEE } from "../../base/constants";
import { isContractIdentical } from "../../base/is-contract-identical";
import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";
import { IsContract } from "../../base/utils";

export class PoolServiceV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  // eslint-disable-next-line no-unused-private-class-members
  #network: NetworkType | undefined;
  #isInit = false;

  #poolService: PoolService;

  constructor(args: { address: Address; provider: ethers.providers.Provider }) {
    const { provider, address } = args;
    super();
    this.#provider = provider;
    this.#poolService = PoolService__factory.connect(address, this.#provider);
  }

  async #initialize() {
    if (this.#isInit) return;

    const network = await detectNetwork(this.#provider);
    if (!supportedChains.includes(network))
      throw new Error("Provider's network is not supported");
    this.#network = network;

    // check if address is PoolService, it has underlyingToken
    try {
      await this.#poolService.underlyingToken();
    } catch {
      throw new Error(
        "This address is not PoolService contract, no underlyingToken()",
      );
    }

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-connect-cm-to-pool.ts
  async connectCreditManager(creditManager: Address, force = false) {
    await this.#initialize();

    this.logger.info(
      `PoolService ${
        this.#poolService.address
      }: connectCreditManager ${creditManager}`,
    );

    const validationResult = await this.connectCreditManagerValidate(
      creditManager,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#poolService!,
      method: "connectCreditManager(address)",
      args: [creditManager],
      validationResult: validationResult,
    });
  }

  async connectCreditManagerValidate(creditManager: Address) {
    await this.#initialize();

    this.logger.info(
      `PoolService ${
        this.#poolService.address
      }: validating connectCreditManager ${creditManager}`,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // check if address is creditManager compatible, it has poolService() = this pool address
    try {
      const identityCheckResult = await isContractIdentical(creditManager);
      if (!identityCheckResult.identical) {
        validationResult.errors.push(
          `Address ${creditManager} is not identical to github repo, error: ${identityCheckResult.error}`,
        );
      }

      const creditManagerContract = CreditManager__factory.connect(
        creditManager,
        this.#provider,
      );
      const poolService = await creditManagerContract.poolService();
      if (poolService !== this.#poolService.address)
        validationResult.errors.push(
          `CreditManager ${creditManager} poolService() is not compatible with this pool, it has poolService() == ${poolService}`,
        );
    } catch (e) {
      validationResult.errors.push(
        `Address ${creditManager} is not a creditManager`,
      );
    }

    // check if this cm is added already
    const isExist = await this.#poolService.creditManagersCanRepay(
      creditManager,
    );
    if (isExist) {
      validationResult.errors.push(
        `CreditManager ${creditManager} is already added`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-expected-liquidity-limit.ts
  async setExpectedLiquidityLimit(newLimit: BigNumber, force = false) {
    await this.#initialize();

    this.logger.info(
      `PoolService ${
        this.#poolService.address
      }: setExpectedLiquidityLimit ${newLimit}`,
    );

    const validationResult = await this.setExpectedLiquidityLimitValidate(
      newLimit,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#poolService!,
      method: "setExpectedLiquidityLimit(uint256)",
      args: [newLimit],
      validationResult: validationResult,
    });
  }

  async setExpectedLiquidityLimitValidate(newLimit: BigNumber) {
    await this.#initialize();

    this.logger.info(
      `PoolService ${
        this.#poolService.address
      }: validating setExpectedLiquidityLimit ${newLimit}`,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // check if new limit is not existing value
    const actualLimit = await this.#poolService.expectedLiquidityLimit();
    if (actualLimit.eq(newLimit)) {
      validationResult.warnings.push(
        `New limit ${newLimit} is equal to existing ${actualLimit}`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-withdraw-fee.ts
  async setWithdrawFee(fee: BigNumber, force = false) {
    await this.#initialize();

    this.logger.info(
      `PoolService ${this.#poolService.address}: setWithdrawFee ${fee}`,
    );

    const validationResult = await this.setWithdrawFeeValidate(fee);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#poolService!,
      method: "setWithdrawFee(uint256)",
      args: [fee],
      validationResult: validationResult,
    });
  }

  async setWithdrawFeeValidate(fee: BigNumber) {
    await this.#initialize();

    this.logger.info(
      `PoolService ${
        this.#poolService.address
      }: validating setWithdrawFee ${fee}`,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    if (fee.gt(MAX_WITHDRAW_FEE)) {
      validationResult.errors.push(
        `Fee ${fee} is greater than max allowed ${MAX_WITHDRAW_FEE}`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-update-interest-rate-model.ts
  async updateInterestRateModel(interestRateModel: Address, force = false) {
    await this.#initialize();

    this.logger.info(
      `PoolService ${
        this.#poolService.address
      }: updateInterestRateModel ${interestRateModel}`,
    );

    const validationResult = await this.updateInterestRateModelValidate(
      interestRateModel,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#poolService!,
      method: "updateInterestRateModel(address)",
      args: [interestRateModel],
      validationResult: validationResult,
    });
  }

  async updateInterestRateModelValidate(interestRateModel: Address) {
    await this.#initialize();

    this.logger.info(
      `PoolService ${
        this.#poolService.address
      }: validating updateInterestRateModel ${interestRateModel}`,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    if (interestRateModel === ADDRESS_0X0) {
      validationResult.errors.push(
        `InterestRateModel ${interestRateModel} is zero address`,
      );
    }

    const isContract = await IsContract(interestRateModel, this.#provider);
    if (!isContract) {
      validationResult.errors.push(
        `Address ${interestRateModel} is not a contract`,
      );
    }

    const interestRateModelContract = await IInterestRateModel__factory.connect(
      interestRateModel,
      this.#provider,
    );

    try {
      const version = await interestRateModelContract.version();
      if (!version.eq(BigNumber.from(1))) {
        validationResult.errors.push(
          `InterestRateModel ${interestRateModel} is not version 1`,
        );
      }
    } catch {
      validationResult.errors.push(
        `Address ${interestRateModel} is not InterestRateModel, no version()`,
      );
    }

    return validationResult;
  }
}
