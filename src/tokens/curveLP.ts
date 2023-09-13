import { BigNumber } from "ethers";

import type { CurvePoolContract } from "../contracts/contracts";
import { TradeAction, TradeType } from "../pathfinder/tradeTypes";
import { PartialRecord } from "../utils/types";
import type { SupportedToken, TokenBase } from "./token";
import { TokenType } from "./tokenType";

export type CurveMetaTokens =
  | "FRAX3CRV"
  | "LUSD3CRV"
  | "gusd3CRV"
  | "MIM_3LP3CRV"
  | "OHMFRAXBP";
export type CurveLPToken =
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
  | CurveMetaTokens;

export type CurveLPTokenData = {
  symbol: CurveLPToken;
  type: TokenType.CURVE_LP_TOKEN;
  swapActions?: Array<TradeAction>;
  lpActions: Array<TradeAction>;
  pool: CurvePoolContract;
  wrapper?: CurvePoolContract;
} & TokenBase;

export type MetaCurveLPTokenData = {
  symbol: CurveLPToken;
  type: TokenType.CURVE_LP_TOKEN;
  lpActions: Array<TradeAction>;
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
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_FRAX_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_FRAX_POOL",
        tokenOut: ["FRAX", "3Crv"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxFRAX3CRV",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxFRAX3CRV",
      },
    ],
  },

  LUSD3CRV: {
    name: "Curve LUSD3CRV-f",
    symbol: "LUSD3CRV",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_LUSD_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_LUSD_POOL",
        tokenOut: ["LUSD", "3Crv"],
      },
    ],
  },

  gusd3CRV: {
    name: "Curve gusd3CRV",
    symbol: "gusd3CRV",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_GUSD_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_GUSD_POOL",
        tokenOut: ["GUSD", "3Crv"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxgusd3CRV",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxgusd3CRV",
      },
    ],
  },

  MIM_3LP3CRV: {
    name: "Curve MIM_3LP3CRV",
    symbol: "MIM_3LP3CRV",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_MIM_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_MIM_POOL",
        tokenOut: ["MIM", "3Crv"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxMIM_3LP3CRV",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxMIM_3LP3CRV",
      },
    ],
  },
  OHMFRAXBP: {
    name: "Curve.fi Factory Crypto Pool: OHM/FRAXBP",
    symbol: "OHMFRAXBP",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_OHMFRAXBP_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_OHMFRAXBP_POOL",
        tokenOut: ["OHM", "FRAX", "USDC"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxOHMFRAXBP",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxOHMFRAXBP",
      },
    ],
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
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_3CRV_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_3CRV_POOL",
        tokenOut: ["DAI", "USDC", "USDT"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvx3Crv",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvx3Crv",
      },
    ],
  },

  crvFRAX: {
    name: "Curve.fi FRAX/USDC",
    symbol: "crvFRAX",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_FRAX_USDC_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_3CRV_POOL",
        tokenOut: ["FRAX", "USDC"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxcrvFRAX",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxcrvFRAX",
      },
    ],
  },

  steCRV: {
    name: "Curve steCRV",
    symbol: "steCRV",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_STETH_GATEWAY",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_STETH_GATEWAY",
        tokenOut: ["STETH", "WETH"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxsteCRV",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxsteCRV",
      },
    ],
  },

  crvPlain3andSUSD: {
    name: "Curve crvPlain3andSUSD",
    symbol: "crvPlain3andSUSD",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_SUSD_POOL",
    wrapper: "CURVE_SUSD_DEPOSIT",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_SUSD_POOL",
        tokenOut: ["DAI", "USDC", "USDT", "sUSD"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxcrvPlain3andSUSD",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxcrvPlain3andSUSD",
      },
    ],
  },
  crvCRVETH: {
    name: "Curve CRV-ETH",
    symbol: "crvCRVETH",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_CRVETH_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_CRVETH_POOL",
        tokenOut: ["WETH", "CRV"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxcrvCRVETH",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxcrvCRVETH",
      },
    ],
  },
  crvCVXETH: {
    name: "Curve CVX-ETH",
    symbol: "crvCVXETH",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_CVXETH_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_CVXETH_POOL",
        tokenOut: ["WETH", "CVX"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxcrvCVXETH",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxcrvCVXETH",
      },
    ],
  },
  crvUSDTWBTCWETH: {
    name: "Curve USDT/WBTC/WETH",
    symbol: "crvUSDTWBTCWETH",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_3CRYPTO_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_3CRYPTO_POOL",
        tokenOut: ["USDT", "WBTC", "WETH"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxcrvUSDTWBTCWETH",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxcrvUSDTWBTCWETH",
      },
    ],
  },
  LDOETH: {
    name: "Curve LDOETH",
    symbol: "LDOETH",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_LDOETH_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_LDOETH_POOL",
        tokenOut: ["LDO", "WETH"],
      },
      {
        type: TradeType.ConvexDepositLP,
        contract: "CONVEX_BOOSTER",
        tokenOut: "cvxLDOETH",
      },
      {
        type: TradeType.ConvexDepositLPAndStake,
        contract: "CONVEX_BOOSTER",
        tokenOut: "stkcvxLDOETH",
      },
    ],
  },

  crvUSDUSDC: {
    name: "Curve crvUSDUSDC",
    symbol: "crvUSDUSDC",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_CRVUSD_USDC_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_CRVUSD_USDC_POOL",
        tokenOut: ["crvUSD", "USDC"],
      },
    ],
  },
  crvUSDUSDT: {
    name: "Curve crvUSDUSDT",
    symbol: "crvUSDUSDT",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_CRVUSD_USDT_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_CRVUSD_USDT_POOL",
        tokenOut: ["crvUSD", "USDT"],
      },
    ],
  },
  crvUSDFRAX: {
    name: "Curve crvUSDFRAX",
    symbol: "crvUSDFRAX",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_CRVUSD_USDC_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_CRVUSD_FRAX_POOL",
        tokenOut: ["crvUSD", "FRAX"],
      },
    ],
  },

  crvUSDETHCRV: {
    name: "Curve crvUSDETHCRV",
    symbol: "crvUSDETHCRV",
    type: TokenType.CURVE_LP_TOKEN,
    pool: "CURVE_TRI_CRV_POOL",
    lpActions: [
      {
        type: TradeType.CurveWithdrawLP,
        contract: "CURVE_TRI_CRV_POOL",
        tokenOut: ["crvUSD", "WETH", "CRV"],
      },
    ],
  },
  ...curveMetaTokens,
};

export const isCurveLPToken = (t: unknown): t is CurveLPToken =>
  typeof t === "string" && !!curveTokens[t as CurveLPToken];

export const isCurveMetaToken = (t: unknown): t is CurveMetaTokens =>
  typeof t === "string" && !!curveMetaTokens[t as CurveMetaTokens];
