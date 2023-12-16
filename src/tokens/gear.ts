import type { TokenBase } from "./token";
import { TokenType } from "./tokenType";

export type DieselV1TokenTypes =
  | "dDAI"
  | "dUSDC"
  | "dWBTC"
  | "dWETH"
  | "dwstETH"
  | "dFRAX";

export type DieselV3TokenTypes = "dUSDCV3" | "dWBTCV3" | "dWETHV3";

export type DieselTokenTypes = DieselV1TokenTypes | DieselV3TokenTypes;

export type DieselStakedTokenTypes = "sdUSDCV3" | "sdWBTCV3" | "sdWETHV3";

export type GearboxToken = "GEAR";

export type DieselTokenV1Data = {
  symbol: DieselV1TokenTypes;
  type: TokenType.DIESEL_LP_TOKEN;
} & TokenBase;

export type DieselTokenV3Data = {
  symbol: DieselV3TokenTypes;
  type: TokenType.DIESEL_LP_TOKEN;
  stakedToken: DieselStakedTokenTypes;
} & TokenBase;

export type DieselStakedTokenData = {
  symbol: DieselStakedTokenTypes;
  type: TokenType.DIESEL_LP_TOKEN;
  underlying: DieselV3TokenTypes;
} & TokenBase;

export type DieselTokenData = DieselTokenV1Data | DieselTokenV3Data;

export type GearboxTokenData = {
  symbol: GearboxToken;
  type: TokenType.GEAR_TOKEN;
} & TokenBase;

const dieselV1Tokens: Record<DieselV1TokenTypes, DieselTokenV1Data> = {
  dDAI: {
    name: "dDAI",
    symbol: "dDAI",
    type: TokenType.DIESEL_LP_TOKEN,
  },

  dUSDC: {
    name: "dUSDC",
    symbol: "dUSDC",
    type: TokenType.DIESEL_LP_TOKEN,
  },

  dWBTC: {
    name: "dWBTC",
    symbol: "dWBTC",
    type: TokenType.DIESEL_LP_TOKEN,
  },

  dWETH: {
    name: "dWETH",
    symbol: "dWETH",
    type: TokenType.DIESEL_LP_TOKEN,
  },

  dwstETH: {
    name: "dwstETH",
    symbol: "dwstETH",
    type: TokenType.DIESEL_LP_TOKEN,
  },

  dFRAX: {
    name: "dFRAX",
    symbol: "dFRAX",
    type: TokenType.DIESEL_LP_TOKEN,
  },
};

const dieselV3Tokens: Record<DieselV3TokenTypes, DieselTokenV3Data> = {
  dUSDCV3: {
    name: "dUSDCV3",
    symbol: "dUSDCV3",
    type: TokenType.DIESEL_LP_TOKEN,
    stakedToken: "sdUSDCV3",
  },
  dWBTCV3: {
    name: "dWBTCV3",
    symbol: "dWBTCV3",
    type: TokenType.DIESEL_LP_TOKEN,
    stakedToken: "sdWBTCV3",
  },
  dWETHV3: {
    name: "dWETHV3",
    symbol: "dWETHV3",
    type: TokenType.DIESEL_LP_TOKEN,
    stakedToken: "sdWETHV3",
  },
};

const dieselTokens = { ...dieselV1Tokens, ...dieselV3Tokens };

const dieselStakedTokens: Record<
  DieselStakedTokenTypes,
  DieselStakedTokenData
> = {
  sdUSDCV3: {
    name: "sdUSDCV3",
    symbol: "sdUSDCV3",
    type: TokenType.DIESEL_LP_TOKEN,
    underlying: "dUSDCV3",
  },
  sdWBTCV3: {
    name: "sdWBTCV3",
    symbol: "sdWBTCV3",
    type: TokenType.DIESEL_LP_TOKEN,
    underlying: "dWBTCV3",
  },
  sdWETHV3: {
    name: "sdWETHV3",
    symbol: "sdWETHV3",
    type: TokenType.DIESEL_LP_TOKEN,
    underlying: "dWETHV3",
  },
};

export const gearTokens: Record<
  DieselTokenTypes | GearboxToken | DieselStakedTokenTypes,
  DieselTokenData | GearboxTokenData | DieselStakedTokenData
> = {
  ...dieselTokens,
  ...dieselStakedTokens,
  GEAR: {
    name: "GEAR",
    symbol: "GEAR",
    type: TokenType.GEAR_TOKEN,
  },
};

export const isDieselToken = (t: unknown): t is DieselTokenTypes =>
  typeof t === "string" && !!dieselTokens[t as DieselTokenTypes];

export const isDieselV1Token = (t: unknown): t is DieselV1TokenTypes =>
  typeof t === "string" && !!dieselV1Tokens[t as DieselV1TokenTypes];

export const isDieselV3Token = (t: unknown): t is DieselV3TokenTypes =>
  typeof t === "string" && !!dieselV3Tokens[t as DieselV3TokenTypes];

export const isDieselStakedToken = (t: unknown): t is DieselStakedTokenTypes =>
  typeof t === "string" && !!dieselStakedTokens[t as DieselStakedTokenTypes];
