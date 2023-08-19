import { NOT_DEPLOYED } from "@gearbox-protocol/sdk";

import { UpdatedValue } from "./updatedValue";

export interface ContractsRegisterState {
  pools: Array<UpdatedValue<string>>;
  creditManagers: Array<UpdatedValue<string>>;
}

export class ContractsRegisterConfigurator {
  address: string;
  state: ContractsRegisterState;

  static new(): ContractsRegisterConfigurator {
    return new ContractsRegisterConfigurator(NOT_DEPLOYED, {
      pools: [],
      creditManagers: [],
    });
  }

  static async attach(address: string): Promise<ContractsRegisterConfigurator> {
    return new ContractsRegisterConfigurator(address, {
      pools: [],
      creditManagers: [],
    });
  }

  private constructor(address: string, _state: ContractsRegisterState) {
    this.address = address;
    this.state = _state;
  }
}
