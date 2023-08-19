import { AddressProviderV3__factory } from "@gearbox-protocol/core-v3/";
import { ethers } from "ethers";

import { IConfigurator, Message, ValidationResult } from "./iConfigurator";
import { UpdatedValue } from "./updatedValue";

export const NO_VERSION = 0;
export const AP_ACL = "ACL";

export interface AddressProviderState {
  addrs: Record<string, Record<number, UpdatedValue<string>>>;
  acl: UpdatedValue<string>;
  contractRegister: UpdatedValue<string>;
  priceOracle: UpdatedValue<string>;
}

export class AddressProviderConfigurator implements IConfigurator {
  address: string;
  state: AddressProviderState;

  static async attach(
    address: string,
    signer: ethers.providers.JsonRpcProvider,
  ): Promise<AddressProviderConfigurator> {
    const contract = AddressProviderV3__factory.connect(address, signer);

    const acl = await contract.getACL();
    const contractsRegister = await contract.getContractsRegister();
    const priceOracle = await contract.getPriceOracle();

    const state: AddressProviderState = {
      acl: UpdatedValue.from(acl),
      contractRegister: UpdatedValue.from(contractsRegister),
      priceOracle: UpdatedValue.from(priceOracle),
      addrs: {},
    };
    return new AddressProviderConfigurator({ address, state });
  }

  private constructor(opts: { address: string; state: AddressProviderState }) {
    this.address = opts.address;
    this.state = opts.state;
  }

  async setAddress(
    key: string,
    address: string,
    version: number,
  ): Promise<void> {
    this.state.addrs[key][version].value = address;
    if (key === AP_ACL && version === NO_VERSION) {
      this.state.acl.value = address;
    }

    // this.txBatcher.createTx({
    //   contract: this.#priceOracle!,
    //   method: "addPriceFeed(address,address)",
    //   args: [tokenAddress, priceFeed]
    // });
  }

  async validate(): Promise<ValidationResult> {
    const warnings: Array<Message> = [];
    const errors: Array<Message> = [];

    if (this.state.acl.isUpdated) {
      const diff = await this.isContractIdentical(this.state.acl.value);
      if (diff.length > 0) {
        diff.forEach(msg => {
          errors.push({
            component: "AddressProvider",
            address: this.state.acl.value,
            message: `ACL contract is not identical: ${msg}`,
          });
        });
      }
    }

    return { warnings, errors };
  }

  async isContractIdentical(address: string): Promise<Array<string>> {
    console.log("isContractIdentical", address);
    return [];
  }

  deployConfig(): string {
    return "";
  }
}
