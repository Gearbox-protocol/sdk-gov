import { NOT_DEPLOYED, SupportedToken } from "@gearbox-protocol/sdk";

import { IConfigurator, ValidationResult } from "./iConfigurator";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";
import { UpdatedValue } from "./updatedValue";

export interface QuotaRateParams {
  minRate: UpdatedValue<number>;
  maxRate: UpdatedValue<number>;
  totalVotesLpSide: bigint;
  totalVotesCaSide: bigint;
}

export interface GaugeV3State {
  quotaTokenParams: Partial<Record<SupportedToken, QuotaRateParams>>;
}

export class GaugeV3Configurator implements IConfigurator {
  address: string;
  state: GaugeV3State;

  static new(config: PoolV3DeployConfig): GaugeV3Configurator {
    const state: GaugeV3State = {
      quotaTokenParams: {},
    };

    for (const [token, rl] of Object.entries(config.ratesAndLimits)) {
      state.quotaTokenParams[token as SupportedToken] = {
        minRate: UpdatedValue.new(rl.minRate),
        maxRate: UpdatedValue.new(rl.maxRate),
        totalVotesLpSide: BigInt(0),
        totalVotesCaSide: BigInt(0),
      };
    }

    return new GaugeV3Configurator({ address: NOT_DEPLOYED, state });
  }

  static async attach(address: string): Promise<GaugeV3Configurator> {
    const state: GaugeV3State = {
      quotaTokenParams: {},
    };
    return new GaugeV3Configurator({ address, state });
  }

  private constructor(opts: { address: string; state: GaugeV3State }) {
    this.address = opts.address;
    this.state = opts.state;
  }

  async validate(): Promise<ValidationResult> {
    return { warnings: [], errors: [] };
  }

  deployConfig(): string {
    return Object.entries(this.state.quotaTokenParams)
      .map(
        ([token, params]) =>
          `_gaugeRates.push(GaugeRate({token: Tokens.${token}, minRate: ${params.minRate.value.toString()}, maxRate: ${params.maxRate.value.toString()}}));`,
      )
      .join("\n");
  }

  toString(): string {
    return Object.entries(this.state.quotaTokenParams)
      .map(([token, params]) => {
        return `[${token}]: ${this.qtpToString(params)}`;
      })
      .join("\n");
  }

  private qtpToString(qtp: QuotaRateParams): string {
    return `minRate: ${qtp.minRate.toString()}; maxRate: ${qtp.maxRate.toString()}; totalVotesLpSide: ${
      qtp.totalVotesLpSide
    }; totalVotesCaSide: ${qtp.totalVotesCaSide}`;
  }
}
