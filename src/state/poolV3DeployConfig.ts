import {
  NetworkType,
  SupportedContract,
  SupportedToken,
} from "@gearbox-protocol/sdk";

import { LinearIRMParams } from "./linearIRM";

export interface RatesAndLimits {
  minRate: number;
  maxRate: number;
  quotaIncreaseFee: number;
  limit: bigint;
}

export interface CollateralToken {
  token: SupportedToken;
  lt: number;
}

export interface CreditManagerV3DeployConfig {
  degenNft: boolean;
  minDebt: bigint;
  maxDebt: bigint;
  collateralTokens: Array<CollateralToken>;
  adapters: Array<SupportedContract>;
  poolLimit: bigint;
}

export interface PoolV3DeployConfig {
  symbol: string;
  name: string;
  network: NetworkType;

  underlying: SupportedToken;
  irm: LinearIRMParams;
  expectedLiquidityLimit: bigint;
  withdrawalFee: number;

  ratesAndLimits: Partial<Record<SupportedToken, RatesAndLimits>>;

  creditManagers: Array<CreditManagerV3DeployConfig>;
}
