import { SupportedContract } from "../contracts/contracts";
import { BalancerLPToken } from "../tokens/balancer";
import { NormalToken } from "../tokens/normal";
import { SupportedToken } from "../tokens/token";
import { Address } from "../utils/types";

export enum BalancerPoolStatus {
  NOT_ALLOWED = 0,
  ALLOWED = 1,
  SWAP_ONLY = 2,
}

export enum PendlePairStatus {
  NOT_ALLOWED = 0,
  ALLOWED = 1,
  EXIT_ONLY = 2,
}

export type AdapterDeployConfig =
  | DefaultAdapterConfig
  | UniV3Config
  | GenericSwapConfig
  | BalancerVaultConfig
  | BalancerV3VaultConfig
  | VelodromeV2Config
  | PendleRouterConfig;

export interface DefaultAdapterConfig {
  contract: SupportedContract;
}

export interface BalancerPoolConfig {
  pool: BalancerLPToken;
  status: BalancerPoolStatus;
}

export interface BalancerVaultConfig {
  contract: "BALANCER_VAULT";
  allowed: Array<BalancerPoolConfig>;
}

export interface BalancerV3PoolConfig {
  pool: NormalToken;
  status: boolean;
}

export interface BalancerV3VaultConfig {
  contract: "BALANCER_V3_ROUTER";
  allowed: Array<BalancerV3PoolConfig>;
}

export interface PendlePairConfig {
  market: Address;
  inputToken: SupportedToken;
  pendleToken: SupportedToken;
  status: PendlePairStatus;
}

export interface PendleRouterConfig {
  contract: "PENDLE_ROUTER";
  allowed: Array<PendlePairConfig>;
}

export interface GenericSwapConfig {
  contract:
    | "UNISWAP_V2_ROUTER"
    | "SUSHISWAP_ROUTER"
    | "FRAXSWAP_ROUTER"
    | "CAMELOT_V3_ROUTER";
  allowed: Array<GenericSwapPair>;
}

export interface GenericSwapPair {
  token0: SupportedToken;
  token1: SupportedToken;
}

export interface UniV3Config {
  contract: "UNISWAP_V3_ROUTER" | "PANCAKESWAP_V3_ROUTER";
  allowed: Array<UniswapV3Pair>;
}

export interface VelodromeCLConfig {
  contract: "VELODROME_CL_ROUTER" | "SHADOW_ROUTER";
  allowed: Array<VelodromeCLPool>;
}

export interface UniswapV3Pair extends GenericSwapPair {
  fee: 100 | 500 | 3_000 | 10000;
}

export interface VelodromeCLPool extends GenericSwapPair {
  tickSpacing: 1 | 5 | 50 | 100 | 200 | 2000;
}

export interface VelodromeV2Pool {
  token0: SupportedToken;
  token1: SupportedToken;
  stable: boolean;
  factory: Address;
}

export interface VelodromeV2Config {
  contract: "VELODROME_V2_ROUTER";
  allowed: Array<VelodromeV2Pool>;
}

export interface EqualizerPool {
  token0: SupportedToken;
  token1: SupportedToken;
  stable: boolean;
}

export interface EqualizerConfig {
  contract: "EQUALIZER_ROUTER";
  allowed: Array<EqualizerPool>;
}

export type AdapterConfig =
  | DefaultAdapterConfig
  | UniV3Config
  | GenericSwapConfig
  | BalancerVaultConfig
  | VelodromeV2Config
  | PendleRouterConfig
  | VelodromeCLConfig
  | EqualizerConfig;
