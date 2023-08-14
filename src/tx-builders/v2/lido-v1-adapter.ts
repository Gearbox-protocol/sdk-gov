import {
  ILidoV1Adapter,
  ILidoV1Adapter__factory,
} from "@gearbox-protocol/integrations-v3/types";
import {
  detectNetwork,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { BigNumber, ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";

export class LidoV1AdapterTxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  // eslint-disable-next-line no-unused-private-class-members
  #network: NetworkType | undefined;
  #isInit = false;

  #lidoV1Adapter: ILidoV1Adapter;

  constructor(args: { address: Address; provider: ethers.providers.Provider }) {
    const { provider, address } = args;
    super();
    this.#provider = provider;
    this.#lidoV1Adapter = ILidoV1Adapter__factory.connect(
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

    // check if address is LidoV1Adapter,  _gearboxAdapterType = 13 and _gearboxAdapterVersion = 2
    try {
      const version = await this.#lidoV1Adapter._gearboxAdapterVersion();
      if (version !== 2)
        throw new Error("This contract has gearboxAdapterVersion, but not 2");
      const adapterType = await this.#lidoV1Adapter._gearboxAdapterType();
      if (adapterType !== 13)
        throw new Error("This contract has gearboxAdapterType, but not 13");
    } catch {
      throw new Error("This address is not LidoV1Adapter");
    }

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-cancel-account-allowance.ts
  async setLimit(limit: BigNumber, force = false) {
    await this.#initialize();

    this.logger.info(`LidoV1Adapter: setLimit to ${limit.toString()}`);

    const validationResult = await this.setLimitValidate(limit);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#lidoV1Adapter!,
      method: "setLimit(uint256)",
      args: [limit],
      validationResult: validationResult,
    });
  }

  async setLimitValidate(limit: BigNumber) {
    await this.#initialize();

    this.logger.info(`LidoV1Adapter: validate setLimit to ${limit.toString()}`);

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // todo what to validate

    return validationResult;
  }
}
