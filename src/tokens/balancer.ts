import { NormalToken } from "./normal";
import type { TokenBase } from "./token";
import { TokenType } from "./tokenType";
import { WrappedToken } from "./wrapped";

export type BalancerLPToken =
  | "50OHM_50DAI"
  | "50OHM_50WETH"
  | "OHM_wstETH"
  | "USDC_DAI_USDT"
  | "B_rETH_STABLE";

export type BalancerLpTokenData = {
  symbol: BalancerLPToken;
  type: TokenType.BALANCER_LP_TOKEN;
  underlying: Array<NormalToken | WrappedToken | BalancerLPToken>;
  poolId: string;
} & TokenBase;

export const balancerLpTokens: Record<BalancerLPToken, BalancerLpTokenData> = {
  "50OHM_50DAI": {
    name: "Balancer 50OHM_50DAI",
    symbol: "50OHM_50DAI",
    type: TokenType.BALANCER_LP_TOKEN,
    underlying: ["OHM", "DAI"],
    poolId:
      "0x76fcf0e8c7ff37a47a799fa2cd4c13cde0d981c90002000000000000000003d2",
  },
  "50OHM_50WETH": {
    name: "Balancer 50OHM_50WETH",
    symbol: "50OHM_50WETH",
    type: TokenType.BALANCER_LP_TOKEN,
    underlying: ["OHM", "WETH"],
    poolId:
      "0xd1ec5e215e8148d76f4460e4097fd3d5ae0a35580002000000000000000003d3",
  },
  OHM_wstETH: {
    name: "Balancer OHM_wstETH",
    symbol: "OHM_wstETH",
    type: TokenType.BALANCER_LP_TOKEN,
    underlying: ["OHM", "wstETH"],
    poolId:
      "0xd4f79ca0ac83192693bce4699d0c10c66aa6cf0f00020000000000000000047e",
  },
  USDC_DAI_USDT: {
    name: "Balancer USDC_DAI_USDT",
    symbol: "USDC_DAI_USDT",
    type: TokenType.BALANCER_LP_TOKEN,
    underlying: ["USDC", "DAI", "USDT"],
    poolId:
      "0x79c58f70905f734641735bc61e45c19dd9ad60bc0000000000000000000004e7",
  },

  B_rETH_STABLE: {
    name: "Balancer rETH Stable Pool",
    symbol: "B_rETH_STABLE",
    type: TokenType.BALANCER_LP_TOKEN,
    underlying: ["rETH", "WETH"],
    poolId:
      "0x1e19cf2d73a72ef1332c882f20534b6519be0276000200000000000000000112",
  },
};

export const isBalancerLPToken = (t: unknown): t is BalancerLPToken =>
  typeof t === "string" && !!balancerLpTokens[t as BalancerLPToken];
