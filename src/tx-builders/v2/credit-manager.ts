import {
  CreditManager,
  CreditManager__factory,
} from "@gearbox-protocol/core-v2";
import {
  detectNetwork,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";

export class CreditManagerV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  // eslint-disable-next-line no-unused-private-class-members
  #network: NetworkType | undefined;
  #isInit = false;

  #creditManager: CreditManager;

  constructor(args: { address: Address; provider: ethers.providers.Provider }) {
    const { provider, address } = args;
    super();
    this.#provider = provider;
    this.#creditManager = CreditManager__factory.connect(
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

    // check if address is creditManager, it has poolService
    try {
      await this.#creditManager.poolService();
    } catch {
      throw new Error(
        "This address is not CreditManager contract, no poolService()",
      );
    }

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-pause-credit-manager.ts
  async pause(force = false) {
    await this.#initialize();

    this.logger.info(`CreditManager ${this.#creditManager.address}: pause()`);

    const validationResult = await this.pauseValidate();

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#creditManager!,
      method: "pause()",
      args: [],
      validationResult: validationResult,
    });
  }

  async pauseValidate() {
    await this.#initialize();

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // todo nothing to validate?

    return validationResult;
  }
}
