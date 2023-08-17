import {
  PauseMulticall,
  PauseMulticall__factory,
} from "@gearbox-protocol/core-v2";
import {
  detectNetwork,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";

export class PauseMulticallV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  // eslint-disable-next-line no-unused-private-class-members
  #network: NetworkType | undefined;
  #isInit = false;

  #pauseMulticall: PauseMulticall;

  constructor(args: { address: Address; provider: ethers.providers.Provider }) {
    const { provider, address } = args;
    super();
    this.#provider = provider;
    this.#pauseMulticall = PauseMulticall__factory.connect(
      address,
      this.#provider,
    );
  }

  async #initialize() {
    if (this.#isInit) return;

    const network = await detectNetwork(this.#provider);
    if (!supportedChains.includes(network))
      throw new Error("Provider's network is not supported");
    this.#network = network;

    // check if address is PauseMulticall, it has acl()
    try {
      await this.#pauseMulticall.acl();
    } catch {
      throw new Error("This address is not PauseMulticall contract, no acl()");
    }

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-pause-all-credit-managers.ts
  async pauseAllCreditManagers(force = false) {
    await this.#initialize();

    this.logger.info(`PauseMulticall: pauseAllCreditManagers()`);

    const validationResult = await this.pauseAllCreditManagersValidate();

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#pauseMulticall!,
      method: "pauseAllCreditManagers()",
      args: [],
      validationResult: validationResult,
    });
  }

  async pauseAllCreditManagersValidate() {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // todo nothing to validate?

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-pause-whole-system.ts
  async pauseAllContracts(force = false) {
    await this.#initialize();

    this.logger.info(`PauseMulticall: pauseAllContracts()`);

    const validationResult = await this.pauseAllContractsValidate();

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#pauseMulticall!,
      method: "pauseAllContracts()",
      args: [],
      validationResult: validationResult,
    });
  }

  async pauseAllContractsValidate() {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // todo nothing to validate?

    return validationResult;
  }
}
