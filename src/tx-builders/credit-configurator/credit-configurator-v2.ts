import {
  ICreditConfigurator,
  ICreditConfigurator__factory,
} from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";

export class CreditConfiguratorV2TxBuilder extends TxBuilder {
  #contract: ICreditConfigurator;

  constructor(address: string) {
    super();
    this.#contract = ICreditConfigurator__factory.connect(
      address,
      ethers.getDefaultProvider()
    );
  }

  async setMaxEnabledTokens(maxEnabledTokens: number, force = false) {
    const errors = await this.setMaxEnabledTokensValidate(maxEnabledTokens);
    if (errors && !force) throw errors;

    return this.createTx({
      contract: this.#contract,
      method: "setMaxEnabledTokens(uint8)",
      args: [maxEnabledTokens],
    });
  }

  async setMaxEnabledTokensValidate(maxEnabledTokens: number) {
    const errors: string[] = [];
    // check if address is allowed contract
    console.log(maxEnabledTokens);

    // check if token is already allowed
    // const isTokenAllowed = await this.#contract(address);
    // if (isTokenAllowed) errors.push("Token is already allowed");
    if (errors.length) return errors;
    return undefined;
  }

  async allowToken(address: string, force = false) {
    const errors = await this.allowTokenValidate(address);
    if (errors && !force) throw errors;

    return this.createTx({
      contract: this.#contract,
      method: "allowToken(address)",
      args: [address],
    });
  }

  async allowTokenValidate(address: string) {
    const errors: string[] = [];
    // check if address is allowed contract
    console.log(address);

    // check if token is already allowed
    // const isTokenAllowed = await this.#contract(address);
    // if (isTokenAllowed) errors.push("Token is already allowed");
    if (errors.length) return errors;
    return undefined;
  }
}
