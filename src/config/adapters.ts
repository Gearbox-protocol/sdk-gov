import { SupportedContract } from "../contracts/contracts";
import { BalancerLPToken } from "../tokens/balancer";
import { SupportedToken } from "../tokens/token";

enum BalanceStatus {
  ALLOWED = 1,
  SWAP_ONLY = 2,
}

export type AdapterDeployConfig =
  | DefaultAdapterConfig
  | UniV3Config
  | UniV2Config
  | BalancerVaultConfig;

export interface DefaultAdapterConfig {
  contract: SupportedContract;
}

export interface BalancerPoolConfig {
  pool: BalancerLPToken;
  status: BalanceStatus;
}

export interface BalancerVaultConfig {
  contract: "BALANCER_VAULT";
  allowed: Array<BalancerPoolConfig>;
}

export interface UniV2Config {
  contract: "UNISWAP_V2_ROUTER" | "SUSHISWAP_ROUTER" | "FRAXSWAP_ROUTER";
  allowed: Array<UniswapV2Pair>;
}

export interface UniswapV2Pair {
  token0: SupportedToken;
  token1: SupportedToken;
}

export interface UniV3Config {
  contract: "UNISWAP_V3_ROUTER";
  allowed: Array<UniswapV3Pair>;
}

export interface UniswapV3Pair extends UniswapV2Pair {
  fee: 100 | 500 | 3_000 | 10000;
}

export type AdapterConfig =
  | DefaultAdapterConfig
  | UniV3Config
  | UniV2Config
  | BalancerVaultConfig;
