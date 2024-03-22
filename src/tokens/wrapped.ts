import { PartialRecord } from "../utils/types";
import type { TokenBase } from "./token";
import { TokenNetwork, TokenType } from "./tokenType";

export type WrappedToken = "wstETH" | "sfrxETH";

export type WrappedTokenData = {
  symbol: WrappedToken;
  type: PartialRecord<
    TokenNetwork,
    TokenType.WRAPPED_TOKEN | TokenType.NORMAL_TOKEN
  >;
} & TokenBase;

export const wrappedTokens: Record<WrappedToken, WrappedTokenData> = {
  wstETH: {
    name: "wstETH",

    symbol: "wstETH",
    type: {
      Mainnet: TokenType.WRAPPED_TOKEN,
      Arbitrum: TokenType.NORMAL_TOKEN,
      Optimism: TokenType.NORMAL_TOKEN,
    },
  },
  sfrxETH: {
    name: "sfrxETH",

    symbol: "sfrxETH",
    type: {
      Mainnet: TokenType.WRAPPED_TOKEN,
      Arbitrum: TokenType.NORMAL_TOKEN,
      Optimism: TokenType.NORMAL_TOKEN,
    },
  },
};

export const isWrappedToken = (t: unknown): t is WrappedToken =>
  typeof t === "string" && !!wrappedTokens[t as WrappedToken];
