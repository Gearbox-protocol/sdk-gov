import { Token } from "yaml/dist/parse/cst";
import { record } from "zod";

import type { SupportedContract } from "../contracts/contracts";
import { PartialRecord } from "../utils/types";
import type { SupportedToken, TokenBase } from "./token";
import { TokenNetwork, TokenType } from "./tokenType";

export type StakingRewardsPhantomToken = "stkUSDS";

export type StakingRewardsPhantomTokenData = {
  symbol: StakingRewardsPhantomToken;
  type: PartialRecord<TokenNetwork, TokenType.STAKING_REWARDS_PHANTOM_TOKEN>;
  underlying: SupportedToken;
} & TokenBase;

export const stakingRewardsPhantomTokens: Record<
  StakingRewardsPhantomToken,
  StakingRewardsPhantomTokenData
> = {
  stkUSDS: {
    name: "Sky staked USDS",
    symbol: "stkUSDS",
    type: {
      AllNetworks: TokenType.STAKING_REWARDS_PHANTOM_TOKEN,
    },
    underlying: "USDS",
  },
};

export const stakingRewardsTokens: Record<
  StakingRewardsPhantomToken,
  StakingRewardsPhantomTokenData
> = {
  ...stakingRewardsPhantomTokens,
};

export const isStakingRewardsPhantomToken = (
  t: unknown,
): t is StakingRewardsPhantomToken =>
  typeof t === "string" &&
  !!stakingRewardsTokens[t as StakingRewardsPhantomToken];

export const zircuitStakedTokenByToken = Object.values(
  stakingRewardsPhantomTokens,
).reduce<PartialRecord<SupportedToken, SupportedToken>>((acc, value) => {
  acc[value.underlying] = value.symbol;
  return acc;
}, {});
