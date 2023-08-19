import { ContractsRegisterConfigurator } from "./contractsRegister";
import { UpdatedValue } from "./updatedValue";

export interface ACLState {
  owner: UpdatedValue<string>;
  pausableAdmins: Array<UpdatedValue<string>>;
  unpausableAdmins: Array<UpdatedValue<string>>;
}

export class ACLConfigurator {
  address: string;
  state: ACLState;

  static async attach(address: string): Promise<ACLConfigurator> {
    const state: ACLState = {
      owner: UpdatedValue.new(""),
      pausableAdmins: [],
      unpausableAdmins: [],
    };
    return new ACLConfigurator({ address, state });
  }

  private constructor(opts: { address: string; state: ACLState }) {
    this.address = opts.address;
    this.state = opts.state;
  }
}
