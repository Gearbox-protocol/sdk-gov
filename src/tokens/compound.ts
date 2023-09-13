import { TradeAction, TradeType } from "../pathfinder/tradeTypes";
import { NormalToken } from "./normal";
import type { TokenBase } from "./token";
import { TokenType } from "./tokenType";

export type CompoundV2LPToken = "cDAI" | "cUSDC" | "cETH" | "cUSDT" | "cLINK";

export type CompoundV2PoolTokenData = {
  symbol: CompoundV2LPToken;
  type: TokenType.COMPOUND_V2_C_TOKEN;
  underlying: NormalToken;
  lpActions: Array<TradeAction>;
} & TokenBase;

export const compoundV2Tokens: Record<
  CompoundV2LPToken,
  CompoundV2PoolTokenData
> = {
  cDAI: {
    name: "CompoundV2 cDAI",
    symbol: "cDAI",
    type: TokenType.COMPOUND_V2_C_TOKEN,
    underlying: "DAI",

    lpActions: [
      {
        type: TradeType.CompoundV2Withdraw,
        contract: "COMPOUND_V2_DAI_POOL",
        tokenOut: "DAI",
      },
    ],
  },

  cUSDC: {
    name: "CompoundV2 cUSDC",
    symbol: "cUSDC",
    type: TokenType.COMPOUND_V2_C_TOKEN,
    underlying: "USDC",

    lpActions: [
      {
        type: TradeType.CompoundV2Withdraw,
        contract: "COMPOUND_V2_USDC_POOL",
        tokenOut: "USDC",
      },
    ],
  },

  cUSDT: {
    name: "CompoundV2 cUSDT",
    symbol: "cUSDT",
    type: TokenType.COMPOUND_V2_C_TOKEN,
    underlying: "USDT",

    lpActions: [
      {
        type: TradeType.CompoundV2Withdraw,
        contract: "COMPOUND_V2_USDT_POOL",
        tokenOut: "USDT",
      },
    ],
  },

  cETH: {
    name: "CompoundV2 cETH",
    symbol: "cETH",
    type: TokenType.COMPOUND_V2_C_TOKEN,
    underlying: "WETH",

    lpActions: [
      {
        type: TradeType.CompoundV2Withdraw,
        contract: "COMPOUND_V2_ETH_POOL",
        tokenOut: "WETH",
      },
    ],
  },
  cLINK: {
    name: "CompoundV2 cLINK",
    symbol: "cLINK",
    type: TokenType.COMPOUND_V2_C_TOKEN,
    underlying: "LINK",

    lpActions: [
      {
        type: TradeType.CompoundV2Withdraw,
        contract: "COMPOUND_V2_LINK_POOL",
        tokenOut: "LINK",
      },
    ],
  },
};

export const isCompoundV2LPToken = (t: unknown): t is CompoundV2LPToken =>
  typeof t === "string" && !!compoundV2Tokens[t as CompoundV2LPToken];
