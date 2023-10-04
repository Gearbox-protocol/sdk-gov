import type {
  AuraPoolContract,
  SupportedContract,
} from "../contracts/contracts";
import { TradeAction, TradeType } from "../pathfinder/tradeTypes";
import { BalancerLPToken } from "./balancer";
import type { SupportedToken, TokenBase } from "./token";
import { TokenType } from "./tokenType";

export type AuraLPToken = "auraB_rETH_STABLE";

export type AuraStakedToken = "auraB_rETH_STABLE_vault";

type BaseAuraToken = {
  pool: AuraPoolContract;
  pid: number;
  underlying: BalancerLPToken;
  lpActions: Array<TradeAction>;
} & TokenBase;

export type AuraLPTokenData = {
  symbol: AuraLPToken;
  type: TokenType.AURA_LP_TOKEN;
  stakedToken: AuraStakedToken;
} & BaseAuraToken;

export type AuraStakedTokenData = {
  symbol: AuraStakedToken;
  type: TokenType.AURA_STAKED_TOKEN;
  lpToken: AuraLPToken;
} & BaseAuraToken;

export const auraLpTokens: Record<AuraLPToken, AuraLPTokenData> = {
  auraB_rETH_STABLE: {
    name: "Balancer rETH Stable Pool Aura Deposit",

    symbol: "auraB_rETH_STABLE",
    type: TokenType.AURA_LP_TOKEN,
    pool: "AURA_B_RETH_STABLE_POOL",
    pid: 109,
    underlying: "B_rETH_STABLE",
    stakedToken: "auraB_rETH_STABLE_vault",
    lpActions: [
      {
        type: TradeType.AuraWithdrawLP,
        contract: "AURA_BOOSTER",
        tokenOut: "B_rETH_STABLE",
      },
      {
        type: TradeType.AuraStake,
        contract: "AURA_B_RETH_STABLE_POOL",
        tokenOut: "auraB_rETH_STABLE_vault",
      },
    ],
  },
};

export const auraStakedTokens: Record<AuraStakedToken, AuraStakedTokenData> = {
  auraB_rETH_STABLE_vault: {
    name: "Aura B_rETH_STABLE_vault",

    symbol: "auraB_rETH_STABLE_vault",
    type: TokenType.AURA_STAKED_TOKEN,
    pool: "AURA_B_RETH_STABLE_POOL",
    pid: 149,
    underlying: "B_rETH_STABLE",
    lpToken: "auraB_rETH_STABLE",
    lpActions: [
      // TODO: add actions here
      // {
      //   type: TradeType.AuraWithdrawLP,
      //   contract: "auraB_rETH_STABLE_vault",
      //   tokenOut: "cvxLDOETH",
      // },
      // {
      //   type: TradeType.ConvexWithdrawAndUnwrap,
      //   contract: "CONVEX_3CRYPTO_POOL",
      //   tokenOut: "LDOETH",
      // },
    ],
  },
};

export const auraTokens: Record<
  AuraLPToken | AuraStakedToken,
  AuraLPTokenData | AuraStakedTokenData
> = {
  ...auraLpTokens,
  ...auraStakedTokens,
};

export const isAuraToken = (t: unknown): t is AuraLPToken | AuraStakedToken =>
  typeof t === "string" && !!auraTokens[t as AuraLPToken | AuraStakedToken];

export const isAuraLPToken = (t: unknown): t is AuraLPToken =>
  typeof t === "string" && !!auraLpTokens[t as AuraLPToken];

export const isAuraStakedToken = (t: unknown): t is AuraStakedToken =>
  typeof t === "string" && !!auraStakedTokens[t as AuraStakedToken];

export const auraPoolByPid = Object.values(auraLpTokens).reduce<
  Record<number, SupportedContract>
>((acc, value) => {
  acc[value.pid] = value.pool;
  return acc;
}, {});

export const auraLpTokenByPid = Object.entries(auraLpTokens).reduce<
  Record<number, SupportedToken>
>((acc, [token, data]) => {
  acc[data.pid] = token as SupportedToken;
  return acc;
}, {});
