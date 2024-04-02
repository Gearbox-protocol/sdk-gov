import { Address } from "../utils/types";
import { CoreState } from "./coreState";
import { CreditFactoryState } from "./creditState";
import { PoolFactoryState } from "./poolState";
import { PriceOracleState } from "./priceFactoryState";

export interface BaseContractState {
  address: Address;
  version: number;
}

export interface GearboxState {
  block: number;
  core: CoreState;
  priceOracle: PriceOracleState;
  poolState: Array<PoolFactoryState>;
  creditState: Array<CreditFactoryState>;
}
