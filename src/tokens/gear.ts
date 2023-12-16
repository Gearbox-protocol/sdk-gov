import type { TokenBase } from "./token";
import { TokenType } from "./tokenType";

export type DieselTokenTypes =
  | "dDAI"
  | "dUSDC"
  | "dWBTC"
  | "dWETH"
  | "dwstETH"
  | "dFRAX"
  | "dUSDCV3" //  - 0x9ef444a6d7F4A5adcd68FD5329aA5240C90E14d2
  | "dWBTCV3" //  - 0xA8cE662E45E825DAF178DA2c8d5Fae97696A788A
  | "dWETHV3"; //  - 0x0418fEB7d0B25C411EB77cD654305d29FcbFf685

export type GearboxToken = "GEAR";

export type DieselTokenData = {
  symbol: DieselTokenTypes;
  type: TokenType.DIESEL_LP_TOKEN;
} & TokenBase;

export type GearboxTokenData = {
  symbol: GearboxToken;
  type: TokenType.GEAR_TOKEN;
} & TokenBase;

const dieselTokens: Record<DieselTokenTypes, DieselTokenData> = {
  // GEARBOX
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

  dUSDCV3: {
    name: "dUSDCV3",
    symbol: "dUSDCV3",
    type: TokenType.DIESEL_LP_TOKEN,
  },
  dWBTCV3: {
    name: "dWBTCV3",
    symbol: "dWBTCV3",
    type: TokenType.DIESEL_LP_TOKEN,
  },
  dWETHV3: {
    name: "dWETHV3",
    symbol: "dWETHV3",
    type: TokenType.DIESEL_LP_TOKEN,
  },
};

export const gearTokens: Record<
  DieselTokenTypes | GearboxToken,
  DieselTokenData | GearboxTokenData
> = {
  ...dieselTokens,
  GEAR: {
    name: "GEAR",
    symbol: "GEAR",
    type: TokenType.GEAR_TOKEN,
  },
};

export const isDieselToken = (t: unknown): t is DieselTokenTypes =>
  typeof t === "string" && !!dieselTokens[t as DieselTokenTypes];
