import { NOT_DEPLOYED, SupportedToken } from "@gearbox-protocol/sdk";

import { PoolV3DeployConfig } from "./poolV3DeployConfig";
import { UpdatedValue } from "./updatedValue";

export interface PoolV3State {
  underlying: SupportedToken;
  withdrawalFee: UpdatedValue<number>;
  expectedLiquidityLimit: UpdatedValue<bigint>;
  creditManagersAllowance: Record<string, UpdatedValue<bigint>>;
}

export class PoolV3Configurator {
  address: string;
  state: PoolV3State;

  static new(config: PoolV3DeployConfig): PoolV3Configurator {
    const state: PoolV3State = {
      underlying: config.underlying,
      withdrawalFee: UpdatedValue.new(config.withdrawalFee),
      expectedLiquidityLimit: UpdatedValue.new(config.expectedLiquidityLimit),
      creditManagersAllowance: config.creditManagers.reduce((a, b, num) => {
        return {
          ...a,
          [`${NOT_DEPLOYED}_${num}`]: UpdatedValue.new(b.poolLimit),
        };
      }, {}),
    };

    return new PoolV3Configurator(NOT_DEPLOYED, state);
  }

  static async attach(address: string): Promise<PoolV3Configurator> {
    const state: PoolV3State = {
      underlying: "USDC",
      withdrawalFee: UpdatedValue.new(0),
      expectedLiquidityLimit: UpdatedValue.new(BigInt(0)),
      creditManagersAllowance: {},
    };

    return new PoolV3Configurator(address, state);
  }

  private constructor(address: string, state: PoolV3State) {
    this.state = state;
    this.address = address;
  }

  toString(): string {
    return `Withdrawal Fee: ${this.state.withdrawalFee.toString()},
ExpectedLiquidityLimit: ${this.state.expectedLiquidityLimit.toString()}
CreditManagersAllowance:
${Object.entries(this.state.creditManagersAllowance)
  .map(([cm, allowance]) => `[${cm}]: ${allowance.toString()}`)
  .join("\n")}`;
  }
}
