import { PartialRecord } from "../utils/types";
import type { TokenBase } from "./token";
import { TokenNetwork, TokenType } from "./tokenType";

export type NormalToken =
  | "1INCH"
  | "AAVE"
  | "COMP"
  | "CRV"
  | "DPI"
  | "FEI"
  | "LINK"
  | "SNX"
  | "UNI"
  | "USDT"
  | "USDC"
  | "USDC_e"
  | "DAI"
  | "WETH"
  | "WBTC"
  | "YFI"
  | "WLD"
  | "OP"

  // NEW TOKENS
  | "STETH"
  | "CVX"
  | "FRAX"
  | "FXS"
  | "LDO"
  | "LUSD"
  | "sUSD"
  | "GUSD"
  | "LQTY"
  | "OHM"
  | "MIM"
  | "SPELL"
  | "GMX"
  | "ARB"
  | "RDNT"
  | "BAL"
  | "ARB"
  | "MKR"
  | "RPL"
  | "APE"
  | "rETH"
  | "AURA"
  | "osETH"
  | "weETH"
  | "SWISE"
  | "ezETH"
  | "rsETH"
  | "PENDLE"
  | "frxETH"
  | "cbETH"
  | "rswETH"

  // REDSTONE
  | "SHIB"

  // crvUSD
  | "crvUSD";

export type NormalTokenData = {
  symbol: NormalToken;
  type: PartialRecord<TokenNetwork, TokenType.NORMAL_TOKEN>;
} & TokenBase;

export const normalTokens: Record<NormalToken, NormalTokenData> = {
  "1INCH": {
    name: "1INCH",

    symbol: "1INCH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  AAVE: {
    name: "AAVE",

    symbol: "AAVE",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  COMP: {
    name: "COMP",

    symbol: "COMP",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  CRV: {
    name: "CRV",

    symbol: "CRV",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  DAI: {
    name: "DAI",

    symbol: "DAI",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  DPI: {
    name: "DPI",

    symbol: "DPI",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  FEI: {
    name: "FEI",

    symbol: "FEI",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  LINK: {
    name: "LINK",

    symbol: "LINK",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  SNX: {
    name: "SNX",

    symbol: "SNX",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  UNI: {
    name: "UNI",

    symbol: "UNI",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  USDC: {
    name: "USDC",

    symbol: "USDC",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  USDC_e: {
    name: "USDC (Bridged)",

    symbol: "USDC",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  USDT: {
    name: "USDT",

    symbol: "USDT",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  WBTC: {
    name: "WBTC",

    symbol: "WBTC",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  WETH: {
    name: "WETH",

    symbol: "WETH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  YFI: {
    name: "YFI",

    symbol: "YFI",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  WLD: {
    name: "WLD",
    symbol: "WLD",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  OP: {
    name: "OP",
    symbol: "OP",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  /// UPDATE
  STETH: {
    name: "stETH",

    symbol: "STETH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  CVX: {
    name: "CVX",

    symbol: "CVX",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  FRAX: {
    name: "FRAX",

    symbol: "FRAX",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  FXS: {
    name: "FXS",

    symbol: "FXS",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  LDO: {
    name: "LDO",

    symbol: "LDO",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  LUSD: {
    name: "LUSD",

    symbol: "LUSD",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  sUSD: {
    name: "sUSD",

    symbol: "sUSD",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  GUSD: {
    name: "GUSD",

    symbol: "GUSD",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  LQTY: {
    name: "LQTY",

    symbol: "LQTY",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  OHM: {
    name: "OHM",

    symbol: "OHM",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  MIM: {
    name: "MIM",

    symbol: "MIM",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  SPELL: {
    name: "SPELL",

    symbol: "SPELL",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  GMX: {
    name: "GMX",

    symbol: "GMX",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  ARB: {
    name: "ARB",

    symbol: "ARB",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  RDNT: {
    name: "RDNT",

    symbol: "RDNT",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  BAL: {
    name: "BAL",

    symbol: "BAL",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  SHIB: {
    name: "SHIB",
    symbol: "SHIB",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  crvUSD: {
    name: "crvUSD",
    symbol: "crvUSD",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },

  MKR: {
    name: "MKR",

    symbol: "MKR",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  RPL: {
    name: "RPL",

    symbol: "RPL",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  APE: {
    name: "APE",

    symbol: "APE",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  rETH: {
    name: "Rocket Pool ETH",
    symbol: "rETH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  AURA: {
    name: "Aura Token",
    symbol: "AURA",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  osETH: {
    name: "Stakewise ETH",
    symbol: "osETH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  weETH: {
    name: "ether.fi ETH",
    symbol: "weETH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  SWISE: {
    name: "StakeWise",
    symbol: "SWISE",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  ezETH: {
    name: "Renzo Restaked ETH",
    symbol: "ezETH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  rsETH: {
    name: "Kelp Restaked ETH",
    symbol: "rsETH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  frxETH: {
    name: "Frax ETH",
    symbol: "frxETH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  PENDLE: {
    name: "Pendle",
    symbol: "PENDLE",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  cbETH: {
    name: "Coinbase ETH",
    symbol: "cbETH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
  rswETH: {
    name: "Restaked Swell ETH",
    symbol: "rswETH",
    type: { AllNetworks: TokenType.NORMAL_TOKEN },
  },
};

export const isNormalToken = (t: unknown): t is NormalToken =>
  typeof t === "string" && !!normalTokens[t as NormalToken];
