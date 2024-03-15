import { BigNumber } from "ethers";

import type { CurvePoolContract } from "../contracts/contracts";
import { PartialRecord } from "../utils/types";
import { ERC4626LPToken } from "./erc4626";
import { NormalToken } from "./normal";
import type { SupportedToken, TokenBase } from "./token";
import { TokenNetwork, TokenType } from "./tokenType";
import { WrappedToken } from "./wrapped";

export type CurveMetaTokens =
  | "FRAX3CRV"
  | "LUSD3CRV"
  | "gusd3CRV"
  | "MIM_3LP3CRV"
  | "OHMFRAXBP";

export type CurveLPToken =
  | CurveMetaTokens
  | "3Crv"
  | "steCRV"
  | "crvPlain3andSUSD"
  | "crvFRAX"
  | "crvCRVETH"
  | "crvCVXETH"
  | "crvUSDTWBTCWETH"
  | "LDOETH"
  | "crvUSDUSDC"
  | "crvUSDUSDT"
  | "crvUSDFRAX"
  | "crvUSDETHCRV"
  | "rETH_f"
  | "USDeUSDC"
  | "FRAXUSDe"
  | "USDecrvUSD"
  | "USDeDAI"
  | "MtEthena"
  | "GHOUSDe"

  /// Arbitrum
  | "2CRV"
  | "3c-crvUSD"
  | "crvUSDC"
  | "crvUSDT"
  | "crvUSDC_e"

  // Optimism
  | "3CRV"
  | "wstETHCRV";

export type CurveLPTokenData = {
  symbol: CurveLPToken;
  type: PartialRecord<TokenNetwork, TokenType.CURVE_LP_TOKEN>;
  tokenOut: Array<CurveLPToken | WrappedToken | ERC4626LPToken | NormalToken>;
  pool: CurvePoolContract;
  wrapper?: CurvePoolContract;
} & TokenBase;

export type MetaCurveLPTokenData = {
  symbol: CurveLPToken;
  type: PartialRecord<TokenNetwork, TokenType.CURVE_LP_TOKEN>;
  tokenOut: Array<CurveLPToken | WrappedToken | ERC4626LPToken | NormalToken>;
  pool: CurvePoolContract;
  wrapper?: CurvePoolContract;
} & TokenBase;

export const Curve3CrvUnderlyingTokenIndex: PartialRecord<
  SupportedToken,
  BigNumber
> = {
  DAI: BigNumber.from(0),
  USDC: BigNumber.from(1),
  USDT: BigNumber.from(2),
};

export const curveMetaTokens: Record<CurveMetaTokens, MetaCurveLPTokenData> = {
  //  META CURVE LP TOKENS
  FRAX3CRV: {
    name: "Curve FRAX3CRV-f",
    symbol: "FRAX3CRV",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_FRAX_POOL",
    tokenOut: ["FRAX", "3Crv"],
  },

  LUSD3CRV: {
    name: "Curve LUSD3CRV-f",
    symbol: "LUSD3CRV",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_LUSD_POOL",
    tokenOut: ["LUSD", "3Crv"],
  },

  gusd3CRV: {
    name: "Curve gusd3CRV",
    symbol: "gusd3CRV",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_GUSD_POOL",
    tokenOut: ["GUSD", "3Crv"],
  },

  MIM_3LP3CRV: {
    name: "Curve MIM_3LP3CRV",
    symbol: "MIM_3LP3CRV",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_MIM_POOL",
    tokenOut: ["MIM", "3Crv"],
  },
  OHMFRAXBP: {
    name: "Curve.fi Factory Crypto Pool: OHM/FRAXBP",
    symbol: "OHMFRAXBP",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_OHMFRAXBP_POOL",
    tokenOut: ["OHM", "FRAX", "USDC"],
  },
};

export const curveTokens: Record<
  CurveLPToken,
  CurveLPTokenData | MetaCurveLPTokenData
> = {
  // CURVE LP TOKENS
  "3Crv": {
    name: "Curve 3Crv",
    symbol: "3Crv",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_3CRV_POOL",
    tokenOut: ["DAI", "USDC", "USDT"],
  },

  crvFRAX: {
    name: "Curve.fi FRAX/USDC",
    symbol: "crvFRAX",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_FRAX_USDC_POOL",
    tokenOut: ["FRAX", "USDC"],
  },

  steCRV: {
    name: "Curve steCRV",
    symbol: "steCRV",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_STETH_GATEWAY",
    tokenOut: ["STETH", "WETH"],
  },

  crvPlain3andSUSD: {
    name: "Curve crvPlain3andSUSD",
    symbol: "crvPlain3andSUSD",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_SUSD_POOL",
    wrapper: "CURVE_SUSD_DEPOSIT",
    tokenOut: ["DAI", "USDC", "USDT", "sUSD"],
  },
  crvCRVETH: {
    name: "Curve CRV-ETH",
    symbol: "crvCRVETH",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_CRVETH_POOL",
    tokenOut: ["WETH", "CRV"],
  },
  crvCVXETH: {
    name: "Curve CVX-ETH",
    symbol: "crvCVXETH",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_CVXETH_POOL",
    tokenOut: ["WETH", "CVX"],
  },
  crvUSDTWBTCWETH: {
    name: "Curve USDT/WBTC/WETH",
    symbol: "crvUSDTWBTCWETH",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_3CRYPTO_POOL",
    tokenOut: ["USDT", "WBTC", "WETH"],
  },
  LDOETH: {
    name: "Curve LDOETH",
    symbol: "LDOETH",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_LDOETH_POOL",
    tokenOut: ["LDO", "WETH"],
  },

  crvUSDUSDC: {
    name: "Curve crvUSDUSDC",
    symbol: "crvUSDUSDC",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_CRVUSD_USDC_POOL",
    tokenOut: ["crvUSD", "USDC"],
  },
  crvUSDUSDT: {
    name: "Curve crvUSDUSDT",
    symbol: "crvUSDUSDT",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_CRVUSD_USDT_POOL",
    tokenOut: ["crvUSD", "USDT"],
  },
  crvUSDFRAX: {
    name: "Curve crvUSDFRAX",
    symbol: "crvUSDFRAX",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_CRVUSD_FRAX_POOL",
    tokenOut: ["crvUSD", "FRAX"],
  },

  crvUSDETHCRV: {
    name: "Curve crvUSDETHCRV",
    symbol: "crvUSDETHCRV",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_TRI_CRV_POOL",
    tokenOut: ["crvUSD", "WETH", "CRV"],
  },

  rETH_f: {
    name: "Curve.fi Factory Crypto Pool: Rocketpool rETH/ETH",
    symbol: "rETH_f",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_RETH_ETH_POOL",
    tokenOut: ["rETH", "WETH"],
  },

  USDeUSDC: {
    name: "Curve USDe-USDC Pool",
    symbol: "USDeUSDC",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_USDE_USDC_POOL",
    tokenOut: ["USDe", "USDC"],
  },

  FRAXUSDe: {
    name: "Curve FRAX-USDe Pool",
    symbol: "FRAXUSDe",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_FRAX_USDE_POOL",
    tokenOut: ["FRAX", "USDe"],
  },

  USDecrvUSD: {
    name: "Curve USDe-crvUSD Pool",
    symbol: "USDecrvUSD",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_USDE_CRVUSD_POOL",
    tokenOut: ["USDe", "crvUSD"],
  },

  USDeDAI: {
    name: "Curve USDe-DAI pool",
    symbol: "USDeDAI",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_USDE_DAI_POOL",
    tokenOut: ["USDe", "crvUSD"],
  },

  MtEthena: {
    name: "Curve sDAI-sUSDe Pool",
    symbol: "MtEthena",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_SDAI_SUSDE_POOL",
    tokenOut: ["sDAI", "sUSDe"],
  },

  GHOUSDe: {
    name: "Curve GHO-USDe Pool",
    symbol: "GHOUSDe",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_GHO_USDE_POOL",
    tokenOut: ["GHO", "USDe"],
  },

  wstETHCRV: {
    name: "Curve wstETHCRV",
    symbol: "wstETHCRV",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_ETH_WSTETH_GATEWAY_OP",
    tokenOut: ["WETH", "wstETH"],
  },

  "2CRV": {
    name: "Curve 2CRV",
    symbol: "2CRV",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_2CRV_POOL_ARB",
    tokenOut: ["USDC_e", "USDT"],
  },

  "3c-crvUSD": {
    name: "Curve TriCrypto crvUSD",
    symbol: "3c-crvUSD",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_TRICRYPTO_CRVUSD_POOL_ARB",
    tokenOut: ["crvUSD", "WBTC", "WETH"],
  },

  crvUSDC: {
    name: "Curve crvUSD/USDC LP (Arbitrum)",
    symbol: "crvUSDC",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_CRVUSD_USDC_POOL_ARB",
    tokenOut: ["crvUSD", "USDC"],
  },

  crvUSDT: {
    name: "Curve crvUSD/USDT LP (Arbitrum)",
    symbol: "crvUSDT",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_CRVUSD_USDT_POOL_ARB",
    tokenOut: ["crvUSD", "USDT"],
  },

  crvUSDC_e: {
    name: "Curve crvUSD/USDC_e LP (Arbitrum)",
    symbol: "crvUSDC_e",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_CRVUSD_USDC_E_POOL_ARB",
    tokenOut: ["crvUSD", "USDC_e"],
  },

  "3CRV": {
    name: "Curve 3Crv",
    symbol: "3CRV",
    type: { AllNetworks: TokenType.CURVE_LP_TOKEN },
    pool: "CURVE_3CRV_POOL_OP",
    tokenOut: ["DAI", "USDC_e", "USDT"],
  },
  ...curveMetaTokens,
};

export const isCurveLPToken = (t: unknown): t is CurveLPToken =>
  typeof t === "string" && !!curveTokens[t as CurveLPToken];

export const isCurveMetaToken = (t: unknown): t is CurveMetaTokens =>
  typeof t === "string" && !!curveMetaTokens[t as CurveMetaTokens];
