import {
  IBalancerV2VaultAdapter,
  IBalancerV2VaultAdapter__factory,
} from "@gearbox-protocol/integrations-v3/types";
import {
  detectNetwork,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";

export class BalancerV2VaultAdapterTxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  // eslint-disable-next-line no-unused-private-class-members
  #network: NetworkType | undefined;
  #isInit = false;

  #balancerV2VaultAdapter: IBalancerV2VaultAdapter;

  constructor(args: { address: Address; provider: ethers.providers.Provider }) {
    const { provider, address } = args;
    super();
    this.#provider = provider;
    this.#balancerV2VaultAdapter = IBalancerV2VaultAdapter__factory.connect(
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

    // check if address is BalancerV2VaultAdapter, it has  _gearboxAdapterVersion = 1 and _gearboxAdapterType = 16
    try {
      const version =
        await this.#balancerV2VaultAdapter._gearboxAdapterVersion();
      if (version !== 1)
        throw new Error("This contract has gearboxAdapterVersion, but not 1");

      const adapterType =
        await this.#balancerV2VaultAdapter._gearboxAdapterType();
      if (adapterType !== 16)
        throw new Error("This contract has gearboxAdapterType, but not 16");
    } catch {
      throw new Error("This address is not BalancerV2VaultAdapter contract");
    }

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-cancel-account-allowance.ts
  async setPoolIDStatus(
    poolId: string,
    status: number, // enum PoolStatus { NOT_ALLOWED, ALLOWED, SWAP_ONLY }
    force = false,
  ) {
    await this.#initialize();

    this.logger.info(
      `BalancerV2VaultAdapter: setPoolIDStatus of pool ${poolId} to ${status}`,
    );

    const validationResult = await this.setPoolIDValidate(poolId, status);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#balancerV2VaultAdapter!,
      method: "setPoolIDStatus(bytes32,uint8)",
      args: [poolId, status],
      validationResult: validationResult,
    });
  }

  async setPoolIDValidate(poolId: string, status: number) {
    await this.#initialize();

    this.logger.info(
      `BalancerV2VaultAdapter: validation of setPoolIDStatus of pool ${poolId} to ${status}`,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    if (status < 0 || status > 2) {
      validationResult.errors.push(`status ${status} is not valid`);
    }

    // todo: check if poolId is pool

    return validationResult;
  }
}
