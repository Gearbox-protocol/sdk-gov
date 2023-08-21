import { ADDRESS_0X0 } from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { CreditManagerV3Configurator, PriceOracleV3Configurator } from "..";
import { ACLConfigurator } from "./acl";
import { AddressProviderConfigurator } from "./addressProviderV3";
import { ContractsRegisterConfigurator } from "./contractsRegister";

export class CoreConfigurator {
  acl: ACLConfigurator;
  addressProvider: AddressProviderConfigurator;
  contractRegister: ContractsRegisterConfigurator;
  priceOracle: PriceOracleV3Configurator;

  creditManagers: Record<string, CreditManagerV3Configurator> = {};

  static async attach(
    addressProviderAddr: string,
    signer: ethers.providers.JsonRpcProvider,
  ): Promise<CoreConfigurator> {
    const addressProvider: AddressProviderConfigurator =
      await AddressProviderConfigurator.attach(addressProviderAddr, signer);

    const acl: ACLConfigurator = await ACLConfigurator.attach(
      addressProvider.state.acl.value,
    );

    const crAddr = addressProvider.state.contractRegister.value;

    const contractRegister: ContractsRegisterConfigurator =
      crAddr === ADDRESS_0X0
        ? ContractsRegisterConfigurator.new()
        : await ContractsRegisterConfigurator.attach(crAddr);

    const creditManagers: Record<string, CreditManagerV3Configurator> = {};

    for (let cr of contractRegister.state.creditManagers) {
      const creditManager: CreditManagerV3Configurator =
        await CreditManagerV3Configurator.attach(cr.value, 0);

      creditManagers[creditManager.address] = creditManager;
    }

    const poAddr = addressProvider.state.priceOracle.value;

    const priceOracle: PriceOracleV3Configurator =
      poAddr === ADDRESS_0X0
        ? PriceOracleV3Configurator.new()
        : await PriceOracleV3Configurator.attach(poAddr);

    return new CoreConfigurator({
      addressProvider,
      acl,
      contractRegister,
      priceOracle,
      creditManagers,
    });
  }
  private constructor(opts: {
    addressProvider: AddressProviderConfigurator;
    acl: ACLConfigurator;
    contractRegister: ContractsRegisterConfigurator;
    priceOracle: PriceOracleV3Configurator;
    creditManagers: Record<string, CreditManagerV3Configurator>;
  }) {
    this.addressProvider = opts.addressProvider;
    this.acl = opts.acl;
    this.contractRegister = opts.contractRegister;
    this.priceOracle = opts.priceOracle;
    this.creditManagers = opts.creditManagers;

    Object.values(this.creditManagers).forEach(cm => {
      cm.core = this;
    });
  }
}
