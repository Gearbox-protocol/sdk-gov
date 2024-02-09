import type {
  AuraPoolContract,
  SupportedContract,
} from "../contracts/contracts";
import { TradeAction, TradeType } from "../pathfinder/tradeTypes";
import { PartialRecord } from "../utils/types";
import { BalancerLPToken } from "./balancer";
import type { SupportedToken, TokenBase } from "./token";
import { TokenNetwork, TokenType } from "./tokenType";

export type AuraLPToken =
  | "auraB_rETH_STABLE"
  | "auraBPT_rETH_ETH"
  | "auraBPT_WSTETH_ETH"
  | "auraweETH_rETH"
  | "auraosETH_wETH_BPT";

export type AuraStakedToken =
  | "auraB_rETH_STABLE_vault"
  | "auraBPT_rETH_ETH_vault"
  | "auraBPT_WSTETH_ETH_vault"
  | "auraweETH_rETH_vault"
  | "auraosETH_wETH_BPT_vault";

type BaseAuraToken = {
  pool: AuraPoolContract;
  pid: number;
  underlying: BalancerLPToken;
  lpActions: Array<TradeAction>;
} & TokenBase;

export type AuraLPTokenData = {
  symbol: AuraLPToken;
  type: PartialRecord<TokenNetwork, TokenType.AURA_LP_TOKEN>;
  stakedToken: AuraStakedToken;
} & BaseAuraToken;

export type AuraStakedTokenData = {
  symbol: AuraStakedToken;
  type: PartialRecord<TokenNetwork, TokenType.AURA_STAKED_TOKEN>;
  lpToken: AuraLPToken;
} & BaseAuraToken;

export const auraLpTokens: Record<AuraLPToken, AuraLPTokenData> = {
  auraB_rETH_STABLE: {
    name: "Balancer rETH Stable Pool Aura Deposit",

    symbol: "auraB_rETH_STABLE",
    type: {
      AllNetworks: TokenType.AURA_LP_TOKEN,
    },
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
  auraosETH_wETH_BPT: {
    name: "Balancer osETH-WETH Stable Pool Aura Deposit",

    symbol: "auraosETH_wETH_BPT",
    type: {
      AllNetworks: TokenType.AURA_LP_TOKEN,
    },
    pool: "AURA_OSETH_WETH_POOL",
    pid: 182,
    underlying: "osETH_wETH_BPT",
    stakedToken: "auraosETH_wETH_BPT_vault",
    lpActions: [
      {
        type: TradeType.AuraWithdrawLP,
        contract: "AURA_BOOSTER",
        tokenOut: "osETH_wETH_BPT",
      },
      {
        type: TradeType.AuraStake,
        contract: "AURA_B_RETH_STABLE_POOL",
        tokenOut: "auraosETH_wETH_BPT_vault",
      },
    ],
  },
  auraweETH_rETH: {
    name: "Balancer weETH-rETH Stable Pool Aura Deposit",

    symbol: "auraweETH_rETH",
    type: {
      AllNetworks: TokenType.AURA_LP_TOKEN,
    },
    pool: "AURA_WEETH_RETH_POOL",
    pid: 179,
    underlying: "weETH_rETH",
    stakedToken: "auraweETH_rETH_vault",
    lpActions: [
      {
        type: TradeType.AuraWithdrawLP,
        contract: "AURA_BOOSTER",
        tokenOut: "weETH_rETH",
      },
      {
        type: TradeType.AuraStake,
        contract: "AURA_B_RETH_STABLE_POOL",
        tokenOut: "auraweETH_rETH_vault",
      },
    ],
  },
  auraBPT_rETH_ETH: {
    name: "BeethovenX rETH-ETH Aura Deposit",

    symbol: "auraBPT_rETH_ETH",
    type: {
      AllNetworks: TokenType.AURA_LP_TOKEN,
    },
    pool: "AURA_BPT_RETH_ETH_POOL",
    pid: 0,
    underlying: "BPT_rETH_ETH",
    stakedToken: "auraBPT_rETH_ETH_vault",
    lpActions: [
      {
        type: TradeType.AuraWithdrawLP,
        contract: "AURA_BOOSTER",
        tokenOut: "BPT_rETH_ETH",
      },
      {
        type: TradeType.AuraStake,
        contract: "AURA_BPT_RETH_ETH_POOL",
        tokenOut: "auraBPT_rETH_ETH_vault",
      },
    ],
  },
  auraBPT_WSTETH_ETH: {
    name: "BeethovenX wstETH-ETH Aura Deposit",

    symbol: "auraBPT_WSTETH_ETH",
    type: {
      AllNetworks: TokenType.AURA_LP_TOKEN,
    },
    pool: "AURA_BPT_WSTETH_ETH_POOL",
    pid: 4,
    underlying: "BPT_WSTETH_ETH",
    stakedToken: "auraBPT_WSTETH_ETH_vault",
    lpActions: [
      {
        type: TradeType.AuraWithdrawLP,
        contract: "AURA_BOOSTER",
        tokenOut: "BPT_WSTETH_ETH",
      },
      {
        type: TradeType.AuraStake,
        contract: "AURA_BPT_WSTETH_ETH_POOL",
        tokenOut: "auraBPT_WSTETH_ETH_vault",
      },
    ],
  },
};

export const auraStakedTokens: Record<AuraStakedToken, AuraStakedTokenData> = {
  auraB_rETH_STABLE_vault: {
    name: "Aura B_rETH_STABLE_vault",

    symbol: "auraB_rETH_STABLE_vault",
    type: {
      AllNetworks: TokenType.AURA_STAKED_TOKEN,
    },
    pool: "AURA_B_RETH_STABLE_POOL",
    pid: 149,
    underlying: "B_rETH_STABLE",
    lpToken: "auraB_rETH_STABLE",
    lpActions: [],
  },
  auraosETH_wETH_BPT_vault: {
    name: "Balancer osETH-WETH Stable Pool Aura Deposit Vault",

    symbol: "auraosETH_wETH_BPT_vault",
    type: {
      AllNetworks: TokenType.AURA_STAKED_TOKEN,
    },
    pool: "AURA_OSETH_WETH_POOL",
    pid: 182,
    underlying: "osETH_wETH_BPT",
    lpToken: "auraosETH_wETH_BPT",
    lpActions: [],
  },
  auraweETH_rETH_vault: {
    name: "Balancer weETH-rETH Stable Pool Aura Deposit Vault",

    symbol: "auraweETH_rETH_vault",
    type: {
      AllNetworks: TokenType.AURA_STAKED_TOKEN,
    },
    pool: "AURA_WEETH_RETH_POOL",
    pid: 182,
    underlying: "weETH_rETH",
    lpToken: "auraweETH_rETH",
    lpActions: [],
  },
  auraBPT_rETH_ETH_vault: {
    name: "Aura BPT_rETH_ETH vault",

    symbol: "auraBPT_rETH_ETH_vault",
    type: {
      AllNetworks: TokenType.AURA_STAKED_TOKEN,
    },
    pool: "AURA_BPT_RETH_ETH_POOL",
    pid: 0,
    underlying: "BPT_rETH_ETH",
    lpToken: "auraBPT_rETH_ETH",
    lpActions: [],
  },
  auraBPT_WSTETH_ETH_vault: {
    name: "Aura BPT_WSTETH_ETH vault",

    symbol: "auraBPT_WSTETH_ETH_vault",
    type: {
      AllNetworks: TokenType.AURA_STAKED_TOKEN,
    },
    pool: "AURA_BPT_WSTETH_ETH_POOL",
    pid: 0,
    underlying: "BPT_WSTETH_ETH",
    lpToken: "auraBPT_WSTETH_ETH",
    lpActions: [],
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
