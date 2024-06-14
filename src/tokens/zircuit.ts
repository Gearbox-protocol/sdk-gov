import { Token } from "yaml/dist/parse/cst";
import { record } from "zod";

import type { SupportedContract } from "../contracts/contracts";
import { PartialRecord } from "../utils/types";
import type { SupportedToken, TokenBase } from "./token";
import { TokenNetwork, TokenType } from "./tokenType";

export type ZircuitStakedPhantomToken = "zpufETH";

export type ZircuitPhantomTokenData = {
  symbol: ZircuitStakedPhantomToken;
  type: PartialRecord<TokenNetwork, TokenType.ZIRCUIT_STAKED_TOKEN>;
  underlying: SupportedToken;
} & TokenBase;

export const zircuitStakedPhantomTokens: Record<
  ZircuitStakedPhantomToken,
  ZircuitPhantomTokenData
> = {
  zpufETH: {
    name: "Zircuit staked pufETH",
    symbol: "zpufETH",
    type: {
      AllNetworks: TokenType.ZIRCUIT_STAKED_TOKEN,
    },
    underlying: "pufETH",
  },
};

export const zircuitTokens: Record<
  ZircuitStakedPhantomToken,
  ZircuitPhantomTokenData
> = {
  ...zircuitStakedPhantomTokens,
};

export const isZircuitStakedPhantomToken = (
  t: unknown,
): t is ZircuitStakedPhantomToken =>
  typeof t === "string" && !!zircuitTokens[t as ZircuitStakedPhantomToken];

export const zircuitStakedTokenByToken = Object.values(
  zircuitStakedPhantomTokens,
).reduce<PartialRecord<SupportedToken, SupportedToken>>((acc, value) => {
  acc[value.underlying] = value.symbol;
  return acc;
}, {});
