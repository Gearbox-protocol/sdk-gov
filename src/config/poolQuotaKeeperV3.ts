import { NOT_DEPLOYED } from "../core/constants";
import { decimals } from "../tokens/decimals";
import { SupportedToken } from "../tokens/token";
import { formatBN } from "../utils/formatter";
import { safeEnum } from "../utils/safeEnum";
import { bnToContractPercentage, bnToContractString } from "./convert";
import { IConfigurator, ValidationResult } from "./iConfigurator";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";

export interface TokenQuotaParams {
  rate: number;
  cumulativeIndexLU: bigint;
  quotaIncreaseFee: number;
  totalQuoted: bigint;
  limit: bigint;
}

export interface PoolQuotaKeeperV3State {
  frozenEpoch: boolean;
  quotaLimits: Partial<Record<SupportedToken, TokenQuotaParams>>;
}

export class PoolQuotaKeeperV3Configurator implements IConfigurator {
  address: string;
  underlying: SupportedToken;
  state: PoolQuotaKeeperV3State;

  static new(config: PoolV3DeployConfig): PoolQuotaKeeperV3Configurator {
    const state: PoolQuotaKeeperV3State = {
      frozenEpoch: false,
      quotaLimits: {},
    };

    for (const [token, rl] of Object.entries(config.ratesAndLimits)) {
      state.quotaLimits[token as SupportedToken] = {
        rate: rl.minRate,
        cumulativeIndexLU: BigInt(0),
        quotaIncreaseFee: rl.quotaIncreaseFee,
        totalQuoted: BigInt(0),
        limit: rl.limit,
      };
    }

    return new PoolQuotaKeeperV3Configurator({
      address: NOT_DEPLOYED,
      state,
      underlying: config.underlying,
    });
  }

  private constructor(opts: {
    address: string;
    state: PoolQuotaKeeperV3State;
    underlying: SupportedToken;
  }) {
    this.state = opts.state;
    this.address = opts.address;
    this.underlying = opts.underlying;
  }

  async validate(): Promise<ValidationResult> {
    return { warnings: [], errors: [] };
  }

  deployConfig(): string {
    return Object.entries(this.state.quotaLimits)
      .map(
        ([token, params]) =>
          `_quotaLimits.push(PoolQuotaLimit({token: Tokens.${safeEnum(
            token,
          )}, quotaIncreaseFee: ${bnToContractPercentage(
            params.quotaIncreaseFee,
          )}, limit: ${bnToContractString(params.limit)}}));`,
      )
      .join("\n");
  }

  toString(): string {
    const quotaLimitsStr = Object.entries(this.state.quotaLimits)
      .map(
        ([token, ql]) => `[${token}]: {
  rate: ${formatBN(BigInt(ql.rate * 100), 2)}%,
  cumulativeIndexLU:  ${formatBN(ql.cumulativeIndexLU, 27)},
  quotaIncreaseFee:  ${ql.quotaIncreaseFee.toFixed(2)}
  totalQuoted: ${ql.totalQuoted};
  limit: ${formatBN(ql.limit, decimals[this.underlying])})};
}`,
      )
      .join(",\n");
    return `Fronzen epoch: ${this.state.frozenEpoch}\n${quotaLimitsStr}`;
  }
}
