import { Address } from "../utils/types";
import { CoreState } from "./coreState";
import { CreditFactoryState } from "./creditState";
import { PeripheryState } from "./peripheryState";
import { PoolFactoryState } from "./poolState";
import { PriceOracleState } from "./priceFactoryState";
import { RouterState } from "./routerState";

export interface BaseContractState {
  address: Address;
  version: number;
}

export interface GearboxState {
  block: number;
  core: CoreState;
  periphery: PeripheryState;
  priceOracle: PriceOracleState;
  poolState: Array<PoolFactoryState>;
  creditState: Array<CreditFactoryState>;
  routerState?: RouterState;
  contractLabels: Record<Address, string>;
}
