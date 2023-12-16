import type { TokenBase } from "./token";
import { TokenType } from "./tokenType";

export type DieselSimpleTokenTypes =
  | "dDAI"
  | "dUSDC"
  | "dWBTC"
  | "dWETH"
  | "dwstETH"
  | "dFRAX";

export type DieselTokenWithStkTypes = "dUSDCV3" | "dWBTCV3" | "dWETHV3";

export type DieselTokenTypes = DieselSimpleTokenTypes | DieselTokenWithStkTypes;

export type DieselStakedTokenTypes = "sdUSDCV3" | "sdWBTCV3" | "sdWETHV3";

export type GearboxToken = "GEAR";

export type DieselSimpleTokenData = {
  symbol: DieselSimpleTokenTypes;
  type: TokenType.DIESEL_LP_TOKEN;
} & TokenBase;

export type DieselWithStkTokenV3Data = {
  symbol: DieselTokenWithStkTypes;
  type: TokenType.DIESEL_LP_TOKEN;
  stakedToken: DieselStakedTokenTypes;
} & TokenBase;

export type DieselStakedTokenData = {
  symbol: DieselStakedTokenTypes;
  type: TokenType.DIESEL_LP_TOKEN;
  underlying: DieselTokenWithStkTypes;
} & TokenBase;

export type DieselTokenData = DieselSimpleTokenData | DieselWithStkTokenV3Data;

export type GearboxTokenData = {
  symbol: GearboxToken;
  type: TokenType.GEAR_TOKEN;
} & TokenBase;

const dieselSimpleTokens: Record<
  DieselSimpleTokenTypes,
  DieselSimpleTokenData
> = {
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

const dieselWithStkTokens: Record<
  DieselTokenWithStkTypes,
  DieselWithStkTokenV3Data
> = {
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

const dieselTokens = { ...dieselSimpleTokens, ...dieselWithStkTokens };

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

export const isDieselSimpleToken = (t: unknown): t is DieselSimpleTokenTypes =>
  typeof t === "string" && !!dieselSimpleTokens[t as DieselSimpleTokenTypes];

export const isDieselWithStkToken = (
  t: unknown,
): t is DieselTokenWithStkTypes =>
  typeof t === "string" && !!dieselWithStkTokens[t as DieselTokenWithStkTypes];

export const isDieselStakedToken = (t: unknown): t is DieselStakedTokenTypes =>
  typeof t === "string" && !!dieselStakedTokens[t as DieselStakedTokenTypes];
