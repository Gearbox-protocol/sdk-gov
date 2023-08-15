import { NOT_DEPLOYED, SupportedToken } from "@gearbox-protocol/sdk";

import { bnToContractString } from "../base/convert";
import { IConfigurator, ValidationResult } from "./iConfigurator";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";
import { UpdatedValue } from "./updatedValue";

export interface PoolV3State {
  symbol: string;
  name: string;
  underlying: SupportedToken;
  withdrawalFee: UpdatedValue<number>;
  expectedLiquidityLimit: UpdatedValue<bigint>;
  creditManagersAllowance: Record<string, UpdatedValue<bigint>>;
}

export class PoolV3Configurator implements IConfigurator {
  address: string;
  state: PoolV3State;

  static new(config: PoolV3DeployConfig): PoolV3Configurator {
    const state: PoolV3State = {
      symbol: config.symbol,
      name: config.name,
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
      symbol: "dUSDC",
      name: "dUSDC attached",
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
  validate(): ValidationResult {
    return { warnings: [], errors: [] };
  }

  deployConfig(): string {
    return `
string public constant symbol = "${this.state.symbol}";
string public constant name = "${this.state.name}";

PoolV3DeployParams _poolParams = PoolV3DeployParams({withdrawalFee: ${
      this.state.withdrawalFee.value
    }, expectedLiquidityLimit: ${bnToContractString(
      this.state.expectedLiquidityLimit.value,
    )}});
`;
  }

  toString(): string {
    return `Withdrawal Fee: ${this.state.withdrawalFee.value},
ExpectedLiquidityLimit: ${bnToContractString(
      this.state.expectedLiquidityLimit.value,
    )}
CreditManagersAllowance:
${Object.entries(this.state.creditManagersAllowance)
  .map(([cm, allowance]) => `[${cm}]: ${bnToContractString(allowance.value)}`)
  .join("\n")}`;
  }
}
