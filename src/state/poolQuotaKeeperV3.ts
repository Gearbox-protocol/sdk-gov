import { NOT_DEPLOYED, SupportedToken } from "@gearbox-protocol/sdk";

import { PoolV3DeployConfig } from "./poolV3DeployConfig";
import { UpdatedValue } from "./updatedValue";

export interface TokenQuotaParams {
  rate: number;
  cumulativeIndexLU: bigint;
  quotaIncreaseFee: number;
  totalQuoted: bigint;
  limit: bigint;
}

export interface PoolQuotaKeeperV3State {
  frozenEpoch: UpdatedValue<boolean>;
  quotaLimits: Partial<Record<SupportedToken, UpdatedValue<TokenQuotaParams>>>;
}

export class PoolQuotaKeeperV3Configurator {
  address: string;
  state: PoolQuotaKeeperV3State;

  static new(config: PoolV3DeployConfig): PoolQuotaKeeperV3Configurator {
    const state: PoolQuotaKeeperV3State = {
      frozenEpoch: UpdatedValue.new(false),
      quotaLimits: {},
    };

    for (const [token, rl] of Object.entries(config.ratesAndLimits)) {
      state.quotaLimits[token as SupportedToken] = UpdatedValue.new({
        rate: rl.minRate,
        cumulativeIndexLU: BigInt(0),
        quotaIncreaseFee: rl.quotaIncreaseFee,
        totalQuoted: BigInt(0),
        limit: BigInt(0),
      });
    }

    return new PoolQuotaKeeperV3Configurator(NOT_DEPLOYED, state);
  }

  static async attach(address: string): Promise<PoolQuotaKeeperV3Configurator> {
    const state: PoolQuotaKeeperV3State = {
      frozenEpoch: UpdatedValue.new(false),
      quotaLimits: {},
    };
    return new PoolQuotaKeeperV3Configurator(address, state);
  }

  private constructor(address: string, state: PoolQuotaKeeperV3State) {
    this.state = state;
    this.address = address;
  }

  setFrozenEpoch(_frozenEpoch: boolean) {
    this.state.frozenEpoch.value = _frozenEpoch;
  }

  setTokenQuotaIncreaseFee(_token: SupportedToken, _fee: number) {
    if (this.state.quotaLimits[_token]) {
      this.state.quotaLimits[_token]!.value = {
        ...this.state.quotaLimits[_token]!.value,
        quotaIncreaseFee: _fee,
      };
    } else {
      throw new Error("Token not found");
    }
  }

  setTokenLimit(_token: SupportedToken, _limit: bigint) {
    if (this.state.quotaLimits[_token]) {
      this.state.quotaLimits[_token]!.value = {
        ...this.state.quotaLimits[_token]!.value,
        limit: _limit,
      };
    } else {
      throw new Error("Token not found");
    }
  }
}
