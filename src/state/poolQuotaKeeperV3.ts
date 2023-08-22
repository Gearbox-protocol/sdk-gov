import {
  decimals,
  formatBN,
  NOT_DEPLOYED,
  SupportedToken,
} from "@gearbox-protocol/sdk";

import { bnToContractPercentage, bnToContractString } from "../base/convert";
import { safeEnum } from "../utils/safeEnum";
import { IConfigurator, ValidationResult } from "./iConfigurator";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";
import { UpdatedValue } from "./updatedValue";

export interface TokenQuotaParams {
  rate: number;
  cumulativeIndexLU: bigint;
  quotaIncreaseFee: UpdatedValue<number>;
  totalQuoted: bigint;
  limit: UpdatedValue<bigint>;
}

export interface PoolQuotaKeeperV3State {
  frozenEpoch: UpdatedValue<boolean>;
  quotaLimits: Partial<Record<SupportedToken, TokenQuotaParams>>;
}

export class PoolQuotaKeeperV3Configurator implements IConfigurator {
  address: string;
  underlying: SupportedToken;
  state: PoolQuotaKeeperV3State;

  static new(config: PoolV3DeployConfig): PoolQuotaKeeperV3Configurator {
    const state: PoolQuotaKeeperV3State = {
      frozenEpoch: UpdatedValue.new(false),
      quotaLimits: {},
    };

    for (const [token, rl] of Object.entries(config.ratesAndLimits)) {
      state.quotaLimits[token as SupportedToken] = {
        rate: rl.minRate,
        cumulativeIndexLU: BigInt(0),
        quotaIncreaseFee: UpdatedValue.new(rl.quotaIncreaseFee),
        totalQuoted: BigInt(0),
        limit: UpdatedValue.new(rl.limit),
      };
    }

    return new PoolQuotaKeeperV3Configurator({
      address: NOT_DEPLOYED,
      state,
      underlying: config.underlying,
    });
  }

  static async attach(address: string): Promise<PoolQuotaKeeperV3Configurator> {
    const state: PoolQuotaKeeperV3State = {
      frozenEpoch: UpdatedValue.new(false),
      quotaLimits: {},
    };
    return new PoolQuotaKeeperV3Configurator({
      address,
      state,
      underlying: "USDC",
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
            params.quotaIncreaseFee.value,
          )}, limit: ${bnToContractString(params.limit.value)}}));`,
      )
      .join("\n");
  }

  setFrozenEpoch(_frozenEpoch: boolean) {
    this.state.frozenEpoch.value = _frozenEpoch;
  }

  setTokenQuotaIncreaseFee(_token: SupportedToken, _fee: number) {
    if (this.state.quotaLimits[_token]) {
      this.state.quotaLimits[_token]!.quotaIncreaseFee.value = _fee;
    } else {
      throw new Error("Token not found");
    }
  }

  setTokenLimit(_token: SupportedToken, _limit: bigint) {
    if (this.state.quotaLimits[_token]) {
      this.state.quotaLimits[_token]!.limit.value = _limit;
    } else {
      throw new Error("Token not found");
    }
  }

  toString(): string {
    const quotaLimitsStr = Object.entries(this.state.quotaLimits)
      .map(
        ([token, ql]) => `[${token}]: {
  rate: ${formatBN(ql.rate * 100, 2)}%,
  cumulativeIndexLU:  ${formatBN(ql.cumulativeIndexLU, 27)},
  quotaIncreaseFee:  ${ql.quotaIncreaseFee.toString({ decimals: 2 })}
  totalQuoted: ${ql.totalQuoted};
  limit: ${ql.limit.toString({ decimals: decimals[this.underlying] })};
}`,
      )
      .join(",\n");
    return `Fronzen epoch: ${this.state.frozenEpoch}\n${quotaLimitsStr}`;
  }
}
