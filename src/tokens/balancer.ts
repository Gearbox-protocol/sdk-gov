import { PartialRecord } from "../utils/types";
import { NormalToken } from "./normal";
import type { TokenBase } from "./token";
import { TokenNetwork, TokenType } from "./tokenType";
import { WrappedToken } from "./wrapped";

export type BalancerLPToken =
  | "50OHM_50DAI"
  | "50OHM_50WETH"
  | "OHM_wstETH"
  | "USDC_DAI_USDT"
  | "B_rETH_STABLE"
  | "BPT_rETH_ETH"
  | "BPT_WSTETH_ETH"
  | "BPT_ROAD"
  | "ECLP_wstETH_WETH";

export type BalancerLpTokenData = {
  symbol: BalancerLPToken;
  type: PartialRecord<TokenNetwork, TokenType.BALANCER_LP_TOKEN>;
  underlying: Array<NormalToken | WrappedToken | BalancerLPToken>;
  poolId: string;
} & TokenBase;

export const balancerLpTokens: Record<BalancerLPToken, BalancerLpTokenData> = {
  "50OHM_50DAI": {
    name: "Balancer 50OHM_50DAI",
    symbol: "50OHM_50DAI",
    type: {
      AllNetworks: TokenType.BALANCER_LP_TOKEN,
    },
    underlying: ["OHM", "DAI"],
    poolId:
      "0x76fcf0e8c7ff37a47a799fa2cd4c13cde0d981c90002000000000000000003d2",
  },
  "50OHM_50WETH": {
    name: "Balancer 50OHM_50WETH",
    symbol: "50OHM_50WETH",
    type: {
      AllNetworks: TokenType.BALANCER_LP_TOKEN,
    },
    underlying: ["OHM", "WETH"],
    poolId:
      "0xd1ec5e215e8148d76f4460e4097fd3d5ae0a35580002000000000000000003d3",
  },
  OHM_wstETH: {
    name: "Balancer OHM_wstETH",
    symbol: "OHM_wstETH",
    type: {
      AllNetworks: TokenType.BALANCER_LP_TOKEN,
    },
    underlying: ["OHM", "wstETH"],
    poolId:
      "0xd4f79ca0ac83192693bce4699d0c10c66aa6cf0f00020000000000000000047e",
  },
  USDC_DAI_USDT: {
    name: "Balancer USDC_DAI_USDT",
    symbol: "USDC_DAI_USDT",
    type: {
      AllNetworks: TokenType.BALANCER_LP_TOKEN,
    },
    underlying: ["USDC", "DAI", "USDT"],
    poolId:
      "0x79c58f70905f734641735bc61e45c19dd9ad60bc0000000000000000000004e7",
  },

  B_rETH_STABLE: {
    name: "Balancer rETH Stable Pool",
    symbol: "B_rETH_STABLE",
    type: {
      AllNetworks: TokenType.BALANCER_LP_TOKEN,
    },
    underlying: ["rETH", "WETH"],
    poolId:
      "0x1e19cf2d73a72ef1332c882f20534b6519be0276000200000000000000000112",
  },

  BPT_rETH_ETH: {
    name: "BeethovenX rETH-ETH Pool",
    symbol: "BPT_rETH_ETH",
    type: {
      AllNetworks: TokenType.BALANCER_LP_TOKEN,
    },
    underlying: ["WETH", "rETH"],
    poolId:
      "0x4fd63966879300cafafbb35d157dc5229278ed2300020000000000000000002b",
  },

  BPT_WSTETH_ETH: {
    name: "BeethovenX wstETH-ETH Pool",
    symbol: "BPT_WSTETH_ETH",
    type: {
      AllNetworks: TokenType.BALANCER_LP_TOKEN,
    },
    underlying: ["wstETH", "WETH"],
    poolId:
      "0x7b50775383d3d6f0215a8f290f2c9e2eebbeceb200020000000000000000008b",
  },

  BPT_ROAD: {
    name: "BeethovenX WETH-OP-USDC Pool",
    symbol: "BPT_ROAD",
    type: {
      AllNetworks: TokenType.BALANCER_LP_TOKEN,
    },
    underlying: ["WETH", "OP", "USDC"],
    poolId:
      "0x39965c9dab5448482cf7e002f583c812ceb53046000100000000000000000003",
  },

  ECLP_wstETH_WETH: {
    name: "BeethovenX ECLP wstETH-ETH Pool",
    symbol: "ECLP_wstETH_WETH",
    type: {
      AllNetworks: TokenType.BALANCER_LP_TOKEN,
    },
    underlying: ["wstETH", "WETH"],
    poolId:
      "0x7ca75bdea9dede97f8b13c6641b768650cb837820002000000000000000000d5",
  },
};

export const isBalancerLPToken = (t: unknown): t is BalancerLPToken =>
  typeof t === "string" && !!balancerLpTokens[t as BalancerLPToken];
