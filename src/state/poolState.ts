import { Address } from "../utils/types";
import { BaseContractState } from "./state";

export interface CreditManagerDebtParams {
  creditManager: Address;
  borrowed: bigint;
  limit: bigint;
  availableToBorrow: bigint;
}

export interface PoolState extends BaseContractState {
  underlying: Address;
  symbol: string;
  name: string;
  decimals: number;
  availableLiquidity: bigint;
  expectedLiquidity: bigint;
  totalBorrowed: bigint;
  totalDebtLimit: bigint;
  creditManagerDebtParams: Array<CreditManagerDebtParams>;
  totalAssets: bigint;
  totalSupply: bigint;
  supplyRate: bigint;
  baseInterestIndex: bigint;
  baseInterestRate: bigint;
  withdrawFee: number;
  lastBaseInterestUpdate: bigint;
  baseInterestIndexLU: bigint;
  isPaused: boolean;
}

export interface QuotaParams {
  rate: number;
  quotaIncreaseFee: number;
  totalQuoted: bigint;
  limit: bigint;
  isActive: boolean;
}

export interface PoolQuotaKeeperState extends BaseContractState {
  quotas: Record<Address, QuotaParams>;
}

export interface LinearModelState extends BaseContractState {
  U_1: number;
  U_2: number;
  R_base: number;
  R_slope1: number;
  R_slope2: number;
  R_slope3: number;
  isBorrowingMoreU2Forbidden: boolean;
}

export interface GaugeParams {
  minRate: number;
  maxRate: number;
  totalVotesLpSide: number;
  totalVotesCaSide: number;
  rate: number;
}

export interface GaugeState extends BaseContractState {
  currentEpoch: number;
  epochFrozen: boolean;
  quotaParams: Record<Address, GaugeParams>;
}

export interface PoolFactoryState {
  pool: PoolState;
  poolQuotaKeeper: PoolQuotaKeeperState;
  linearModel?: LinearModelState;
  gauge: GaugeState;
}
