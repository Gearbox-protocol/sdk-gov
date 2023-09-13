import type { YearnVaultContract } from "../contracts/contracts";
import { TradeAction, TradeType } from "../pathfinder/tradeTypes";
import type { CurveLPToken } from "./curveLP";
import { NormalToken } from "./normal";
import type { TokenBase } from "./token";
import { TokenType } from "./tokenType";

export type YearnLPToken =
  | "yvDAI"
  | "yvUSDC"
  | "yvWETH"
  | "yvWBTC"
  | "yvCurve_stETH"
  | "yvCurve_FRAX";

export type YearnVaultTokenData = {
  symbol: YearnLPToken;
  type: TokenType.YEARN_ON_NORMAL_TOKEN;
  underlying: NormalToken;
  lpActions: Array<TradeAction>;
  vault: YearnVaultContract;
} & TokenBase;

export type YearnVaultOfCurveLPTokenData = {
  symbol: YearnLPToken;
  type: TokenType.YEARN_ON_CURVE_TOKEN;
  underlying: CurveLPToken;
  lpActions: Array<TradeAction>;
  vault: YearnVaultContract;
} & TokenBase;

export type YearnVaultOfMetaCurveLPTokenData = {
  symbol: YearnLPToken;
  type: TokenType.YEARN_ON_CURVE_TOKEN;
  underlying: CurveLPToken;
  lpActions: Array<TradeAction>;
  vault: YearnVaultContract;
} & TokenBase;

export const yearnTokens: Record<
  YearnLPToken,
  | YearnVaultTokenData
  | YearnVaultOfCurveLPTokenData
  | YearnVaultOfMetaCurveLPTokenData
> = {
  // YEARN TOKENS
  yvDAI: {
    name: "Yearn yvDAI",
    symbol: "yvDAI",
    type: TokenType.YEARN_ON_NORMAL_TOKEN,
    underlying: "DAI",
    vault: "YEARN_DAI_VAULT",
    lpActions: [
      {
        type: TradeType.YearnWithdraw,
        contract: "YEARN_DAI_VAULT",
        tokenOut: "DAI",
      },
    ],
  },

  yvUSDC: {
    name: "Yearn yvUSDC",
    symbol: "yvUSDC",
    type: TokenType.YEARN_ON_NORMAL_TOKEN,
    underlying: "USDC",
    vault: "YEARN_USDC_VAULT",
    lpActions: [
      {
        type: TradeType.YearnWithdraw,
        contract: "YEARN_USDC_VAULT",
        tokenOut: "USDC",
      },
    ],
  },

  yvWETH: {
    name: "Yearn yvWETH",
    symbol: "yvWETH",
    type: TokenType.YEARN_ON_NORMAL_TOKEN,
    underlying: "WETH",
    vault: "YEARN_WETH_VAULT",
    lpActions: [
      {
        type: TradeType.YearnWithdraw,
        contract: "YEARN_WETH_VAULT",
        tokenOut: "WETH",
      },
    ],
  },

  yvWBTC: {
    name: "Yearn yvWBTC",
    symbol: "yvWBTC",
    type: TokenType.YEARN_ON_NORMAL_TOKEN,
    underlying: "WBTC",
    vault: "YEARN_WBTC_VAULT",
    lpActions: [
      {
        type: TradeType.YearnWithdraw,
        contract: "YEARN_WBTC_VAULT",
        tokenOut: "WBTC",
      },
    ],
  },

  // YEARN- CURVE TOKENS
  yvCurve_stETH: {
    name: "Yearn yvCurve-stETH",
    symbol: "yvCurve_stETH",
    type: TokenType.YEARN_ON_CURVE_TOKEN,
    underlying: "steCRV",
    vault: "YEARN_CURVE_STETH_VAULT",
    lpActions: [
      {
        type: TradeType.YearnWithdraw,
        contract: "YEARN_CURVE_STETH_VAULT",
        tokenOut: "steCRV",
      },
    ],
  },

  yvCurve_FRAX: {
    name: "Yearn yvCurve-FRAX",
    symbol: "yvCurve_FRAX",
    type: TokenType.YEARN_ON_CURVE_TOKEN,
    underlying: "FRAX3CRV",
    vault: "YEARN_CURVE_FRAX_VAULT",
    lpActions: [
      {
        type: TradeType.YearnWithdraw,
        contract: "YEARN_CURVE_FRAX_VAULT",
        tokenOut: "FRAX3CRV",
      },
    ],
  },
};

export const isYearnLPToken = (t: unknown): t is YearnLPToken =>
  typeof t === "string" && !!yearnTokens[t as YearnLPToken];
