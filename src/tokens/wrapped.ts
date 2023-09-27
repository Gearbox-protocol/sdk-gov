import type { TokenBase } from "./token";
import { TokenType } from "./tokenType";

export type WrappedToken = "wstETH";

export type WrappedTokenData = {
  symbol: WrappedToken;
  type: TokenType.WRAPPED_TOKEN;
} & TokenBase;

export const wrappedTokens: Record<WrappedToken, WrappedTokenData> = {
  wstETH: {
    name: "wstETH",

    symbol: "wstETH",
    type: TokenType.WRAPPED_TOKEN,
  },
};
