import { UpdatedValue } from "./updatedValue";

export interface ContractsRegisterState {
  pools: Array<UpdatedValue<string>>;
  creditManagers: Array<UpdatedValue<string>>;
  pausableAdmins: Array<UpdatedValue<string>>;
  unpausableAdmins: Array<UpdatedValue<string>>;
}

export class ContractsRegisterConfigurator {
  address: string;
  state: ContractsRegisterState;

  static async attach(address: string): Promise<ContractsRegisterConfigurator> {
    return new ContractsRegisterConfigurator(address, {
      pools: [],
      creditManagers: [],
      pausableAdmins: [],
      unpausableAdmins: [],
    });
  }

  private constructor(address: string, _state: ContractsRegisterState) {
    this.address = address;
    this.state = _state;
  }
}
