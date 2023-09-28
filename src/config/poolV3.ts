import { NOT_DEPLOYED } from "../core/constants";
import { SupportedToken } from "../tokens/token";
import { bnToContractString } from "./convert";
import { IConfigurator, ValidationResult } from "./iConfigurator";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";

export interface PoolV3State {
  symbol: string;
  name: string;
  underlying: SupportedToken;
  withdrawalFee: number;
  expectedLiquidityLimit: bigint;
  creditManagersAllowance: Record<string, bigint>;
}

export class PoolV3Configurator implements IConfigurator {
  address: string;
  state: PoolV3State;

  static new(config: PoolV3DeployConfig): PoolV3Configurator {
    const state: PoolV3State = {
      symbol: config.symbol,
      name: config.name,
      underlying: config.underlying,
      withdrawalFee: config.withdrawalFee,
      expectedLiquidityLimit: config.expectedLiquidityLimit,
      creditManagersAllowance: config.creditManagers.reduce((a, b, num) => {
        return {
          ...a,
          [`${NOT_DEPLOYED}_${num}`]: b.poolLimit,
        };
      }, {}),
    };

    return new PoolV3Configurator(NOT_DEPLOYED, state);
  }

  private constructor(address: string, state: PoolV3State) {
    this.state = state;
    this.address = address;
  }

  async validate(): Promise<ValidationResult> {
    return { warnings: [], errors: [] };
  }

  deployConfig(): string {
    return `
string public constant symbol = "${this.state.symbol}";
string public constant name = "${this.state.name}";

PoolV3DeployParams _poolParams = PoolV3DeployParams({withdrawalFee: ${
      this.state.withdrawalFee
    }, expectedLiquidityLimit: ${bnToContractString(
      this.state.expectedLiquidityLimit,
    )}});
`;
  }

  toString(): string {
    return `Withdrawal Fee: ${this.state.withdrawalFee},
ExpectedLiquidityLimit: ${bnToContractString(this.state.expectedLiquidityLimit)}
CreditManagersAllowance:
${Object.entries(this.state.creditManagersAllowance)
  .map(([cm, allowance]) => `[${cm}]: ${bnToContractString(allowance)}`)
  .join("\n")}`;
  }
}
