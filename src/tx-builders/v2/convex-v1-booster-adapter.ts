import {
  IConvexV1BoosterAdapter,
  IConvexV1BoosterAdapter__factory,
} from "@gearbox-protocol/integrations-v3";
import {
  detectNetwork,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";

export class ConvexV1BoosterAdapterTxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  // eslint-disable-next-line no-unused-private-class-members
  #network: NetworkType | undefined;
  #isInit = false;

  #convexV1BoosterAdapter: IConvexV1BoosterAdapter;

  constructor(args: { address: Address; provider: ethers.providers.Provider }) {
    const { provider, address } = args;
    super();
    this.#provider = provider;
    this.#convexV1BoosterAdapter = IConvexV1BoosterAdapter__factory.connect(
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

    // check if address is ConvexV1BoosterAdapter, _gearboxAdapterType = 11 and _gearboxAdapterVersion = 2
    try {
      const version =
        await this.#convexV1BoosterAdapter._gearboxAdapterVersion();
      if (version !== 2)
        throw new Error("This contract has gearboxAdapterVersion, but not 2");
      const adapterType =
        await this.#convexV1BoosterAdapter._gearboxAdapterType();
      if (adapterType !== 11)
        throw new Error("This contract has gearboxAdapterType, but not 13");
    } catch {
      throw new Error("This address is not ConvexV1BoosterAdapter");
    }

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-update-convex-staked-token-map.ts
  async updateStakedPhantomTokensMap(force = false) {
    await this.#initialize();

    this.logger.info(`ConvexV1BoosterAdapter: updateStakedPhantomTokensMap()`);

    const validationResult = await this.updateStakedPhantomTokensMapValidate();

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#convexV1BoosterAdapter!,
      method: "updateStakedPhantomTokensMap()",
      args: [],
      validationResult: validationResult,
    });
  }

  async updateStakedPhantomTokensMapValidate() {
    await this.#initialize();

    this.logger.info(
      `ConvexV1BoosterAdapter: validate updateStakedPhantomTokensMap()`,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // todo what to validate

    return validationResult;
  }
}
