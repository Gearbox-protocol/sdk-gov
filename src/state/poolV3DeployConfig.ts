import {
  NetworkType,
  SupportedContract,
  SupportedToken,
} from "@gearbox-protocol/sdk";
import { BalancerLPToken } from "@gearbox-protocol/sdk/lib/tokens/balancer";

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

interface BalancerPoolConfig {
  pool: BalancerLPToken;
  status: "NOT_ALLOWED" | "ALLOWED" | "SWAP_ONLY";
}

interface UniswapV2PairConfig {
  token0: SupportedToken;
  token1: SupportedToken;
  whitelisted: boolean;
}

interface UniswapV3PoolConfig {
  token0: SupportedToken;
  token1: SupportedToken;
  fee: 100 | 500 | 3000 | 10000;
  whitelisted: boolean;
}

export interface CreditManagerV3DeployConfig {
  degenNft: boolean;
  minDebt: bigint;
  maxDebt: bigint;
  expirationDate?: number;
  collateralTokens: Array<CollateralToken>;
  adapters: Array<SupportedContract>;
  poolLimit: bigint;
  balancerPools: Array<BalancerPoolConfig>;
  uniswapV2Pairs: Array<UniswapV2PairConfig>;
  uniswapV3Pools: Array<UniswapV3PoolConfig>;
  sushiswapPairs: Array<UniswapV2PairConfig>;
}

export interface PoolV3DeployConfig {
  id: string;
  symbol: string;
  name: string;
  network: NetworkType;

  underlying: SupportedToken;
  supportsQuotas: boolean;
  accountAmount: bigint;

  irm: LinearIRMParams;
  expectedLiquidityLimit: bigint;
  withdrawalFee: number;

  ratesAndLimits: Partial<Record<SupportedToken, RatesAndLimits>>;

  creditManagers: Array<CreditManagerV3DeployConfig>;
}
