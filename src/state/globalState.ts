import { ACLState } from "./aclState";
import { AddressProviderV3State } from "./addressProviderState";
import { CreditManagerV2State } from "./creditManagerV2State";
import { CreditManagerV3State } from "./creditManagerV3State";
import { PoolV1State } from "./poolV1State";
import { PoolV3State } from "./poolV3State";
import { PriceOracleV2State } from "./priceOracleV2State";
import { PriceOracleV3State } from "./priceOracleV3State";

export class GlobalState {
  addressProviderV3State: AddressProviderV3State;
  aclState: ACLState;
  priceOracleV2State: PriceOracleV2State;
  priceOracleV3State: PriceOracleV3State;

  poolsV1: Record<string, PoolV1State>;
  poolsV3: Record<string, PoolV3State>;

  creditManagersV2: Record<string, CreditManagerV2State>;
  creditManagersV3: Record<string, CreditManagerV3State>;

  constructor(state: {
    addressProviderV3State: AddressProviderV3State;
    aclState: ACLState;
    priceOracleV2State: PriceOracleV2State;
    priceOracleV3State: PriceOracleV3State;
    poolsV1: Record<string, PoolV1State>;
    poolsV3: Record<string, PoolV3State>;
    creditManagersV2: Record<string, CreditManagerV2State>;
    creditManagersV3: Record<string, CreditManagerV3State>;
  }) {
    this.addressProviderV3State = state.addressProviderV3State;
    this.aclState = state.aclState;
    this.priceOracleV2State = state.priceOracleV2State;
    this.priceOracleV3State = state.priceOracleV3State;
    this.poolsV1 = state.poolsV1;
    this.poolsV3 = state.poolsV3;
    this.creditManagersV2 = state.creditManagersV2;
    this.creditManagersV3 = state.creditManagersV3;
  }

  static fromJson(json: string): GlobalState {
    const parsed = JSON.parse(json);

    return new GlobalState({
      addressProviderV3State: AddressProviderV3State.fromJson(
        JSON.stringify(parsed["addressProviderV3"]),
      ),
      aclState: ACLState.fromJson(JSON.stringify(parsed["acl"])),
      priceOracleV2State: PriceOracleV2State.fromJson(
        JSON.stringify(parsed["priceOracleV2"]),
      ),
      priceOracleV3State: PriceOracleV3State.fromJson(
        JSON.stringify(parsed["priceOracleV3"]),
      ),
      poolsV1: PoolV1State.fromJson(JSON.stringify(parsed["poolsV1"])).reduce(
        (acc, pool) => ({ ...acc, [`Pool v1: ${pool.name}`]: pool }),
        {},
      ),
      poolsV3: PoolV3State.fromJson(JSON.stringify(parsed["poolsV3"])).reduce(
        (acc, pool) => ({ ...acc, [`Pool v3: ${pool.name}`]: pool }),
        {},
      ),
      creditManagersV2: CreditManagerV2State.fromJson(
        JSON.stringify(parsed["creditManagersV2"]),
      ).reduce(
        (acc, cm) => ({ ...acc, [`CreditManager v2: ${cm.name}`]: cm }),
        {},
      ),
      creditManagersV3: CreditManagerV3State.fromJson(
        JSON.stringify(parsed["creditManagersV3"]),
      ).reduce(
        (acc, cm) => ({ ...acc, [`CreditManager v3: ${cm.name}`]: cm }),
        {},
      ),
    });
  }
}
