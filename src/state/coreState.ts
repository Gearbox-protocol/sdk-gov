import { Address } from "../utils/types";
import { BaseContractState } from "./state";

export interface AddressProviderV3State extends BaseContractState {
  addresses: Record<string, Record<number, Address>>;
}

export interface ACLState extends BaseContractState {
  owner: Address;
  pausableAdmins: Array<Address>;
  unpausableAdmins: Array<Address>;
}

export interface PolicyStruct {
  enabled: boolean;
  admin: Address;
  delay: bigint;
  flags: bigint;
  exactValue: bigint;
  minValue: bigint;
  maxValue: bigint;
  referencePoint: bigint;
  referencePointUpdatePeriod: bigint;
  referencePointTimestampLU: bigint;
  minPctChangeDown: bigint;
  minPctChangeUp: bigint;
  maxPctChangeDown: bigint;
  maxPctChangeUp: bigint;
  minChange: bigint;
  maxChange: bigint;
}

export interface ControllerTimelockV3State extends BaseContractState {
  policies: Record<string, PolicyStruct>;
  groups: Record<string, Array<Address>>;
}

export type DegenNFT2State = BaseContractState;

export interface GearStakingV3State extends BaseContractState {
  successor: Address;
  migrator: Address;
}

export interface CoreState {
  addressProviderV3: AddressProviderV3State;
  acl: ACLState;
  controllerTimelockV3: ControllerTimelockV3State;
  degenNFT2: DegenNFT2State;
  gearStakingV3: GearStakingV3State;
}
