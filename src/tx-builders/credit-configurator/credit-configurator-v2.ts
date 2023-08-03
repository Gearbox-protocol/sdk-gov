import {
  ADDRESS_PROVIDER,
  detectNetwork,
  ICreditConfigurator,
  ICreditConfigurator__factory,
  ICreditManagerV2,
  ICreditManagerV2__factory,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { BigNumber, ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { ValidationResult } from "../../base/types";

export class CreditConfiguratorV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  #network: NetworkType | undefined;
  #isInit = false;

  #creditManager: ICreditManagerV2 | undefined;
  #creditConfigurator: ICreditConfigurator;

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

    // It has creditManager property
    await this.#creditConfigurator.creditManager();

    const cmAddress = await this.#creditConfigurator.creditManager();
    this.#creditManager = ICreditManagerV2__factory.connect(
      cmAddress,
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
    });
  }

  async setMaxEnabledTokensValidate(maxEnabledTokens: number) {
    await this.#initialize();
    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    // it fits uint8 value
    if (maxEnabledTokens > 20) validationResult.errors.push("Value is too big");

    const currentValue =
      await this.#creditManager!.maxAllowedEnabledTokenLength();
    if (currentValue === maxEnabledTokens) {
      validationResult.errors.push(
        "setMaxEnabledTokens: New value is equal to old value"
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
}
