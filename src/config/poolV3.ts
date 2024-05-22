import { NOT_DEPLOYED } from "../core/constants";
import { SupportedToken } from "../tokens/token";
import { formatNumberToString_ } from "../utils/formatter";
import { IConfigurator, ValidationResult } from "./iConfigurator";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";

export interface PoolV3State {
  symbol: string;
  name: string;
  underlying: SupportedToken;
  withdrawalFee: number;
  totalDebtLimit: bigint;
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
      totalDebtLimit: config.totalDebtLimit,
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
    }, totalDebtLimit: ${formatNumberToString_(this.state.totalDebtLimit)}});
`;
  }

  toString(): string {
    return `Withdrawal Fee: ${this.state.withdrawalFee},
TotalDebtLimit: ${formatNumberToString_(this.state.totalDebtLimit)}
CreditManagersAllowance:
${Object.entries(this.state.creditManagersAllowance)
  .map(([cm, allowance]) => `[${cm}]: ${formatNumberToString_(allowance)}`)
  .join("\n")}`;
  }
}
