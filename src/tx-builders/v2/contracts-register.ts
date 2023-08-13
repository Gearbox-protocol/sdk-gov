import {
  ContractsRegister,
  ContractsRegister__factory,
} from "@gearbox-protocol/core-v2/types";
import {
  ADDRESS_0X0,
  detectNetwork,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, ValidationResult } from "../../base/types";
import { IsContract } from "../../base/utils";

export class ContractsRegisterV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  // eslint-disable-next-line no-unused-private-class-members
  #network: NetworkType | undefined;
  #isInit = false;

  #contractsRegister: ContractsRegister;

  constructor(args: { address: string; provider: ethers.providers.Provider }) {
    const { address, provider } = args;
    super();
    this.#provider = provider;
    this.#contractsRegister = ContractsRegister__factory.connect(
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

    // Check if contract is contractsRegister
    // It has getPools()

    try {
      await this.#contractsRegister.getPools();
    } catch {
      throw new Error(
        "This address is not ContractsRegister contract, no getPools()",
      );
    }

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-add-credit-manager.ts
  async addCreditManager(newCreditManager: Address, force = false) {
    await this.#initialize();

    this.logger.info(`ContractsRegister: addCreditManager ${newCreditManager}`);

    const validationResult = await this.addCreditManagerValidate(
      newCreditManager,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    return this.createTx({
      contract: this.#contractsRegister,
      method: "addCreditManager(address)",
      args: [newCreditManager],
      validationResult: validationResult,
    });
  }

  async addCreditManagerValidate(newCreditManager: Address) {
    await this.#initialize();
    this.logger.info(
      `ContractsRegister: Validating addCreditManager ${newCreditManager}`,
    );

    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    const isContract = await IsContract(newCreditManager, this.#provider);
    if (!isContract) {
      validationResult.errors.push(
        `Address ${newCreditManager} is not a contract`,
      );
    }

    if (newCreditManager === ADDRESS_0X0) {
      validationResult.errors.push(
        `Address ${newCreditManager} is zero address`,
      );
    }

    const isAlreadyAdded = await this.#contractsRegister.isCreditManager(
      newCreditManager,
    );

    if (isAlreadyAdded) {
      validationResult.warnings.push(
        `CreditManager ${newCreditManager} is already added`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-add-pool.ts
  async addPool(newPoolAddress: Address, force = false) {
    await this.#initialize();

    this.logger.info(`ContractsRegister: addPool ${newPoolAddress}`);

    const validationResult = await this.addPoolValidate(newPoolAddress);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    return this.createTx({
      contract: this.#contractsRegister,
      method: "addPool(address)",
      args: [newPoolAddress],
      validationResult: validationResult,
    });
  }

  async addPoolValidate(newPoolAddress: Address) {
    await this.#initialize();
    this.logger.info(`ContractsRegister: Validating addPool ${newPoolAddress}`);

    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    const isContract = await IsContract(newPoolAddress, this.#provider);
    if (!isContract) {
      validationResult.errors.push(
        `Address ${newPoolAddress} is not a contract`,
      );
    }

    if (newPoolAddress === ADDRESS_0X0) {
      validationResult.errors.push(`Address ${newPoolAddress} is zero address`);
    }

    const isAlreadyAdded = await this.#contractsRegister.isPool(newPoolAddress);
    if (isAlreadyAdded) {
      validationResult.warnings.push(`Pool ${newPoolAddress} is already added`);
    }

    return validationResult;
  }
}
