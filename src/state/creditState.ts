import { Address } from "../utils/types";
import { BaseContractState } from "./state";

export interface CreditFacadeState extends BaseContractState {
  maxQuotaMultiplier: number;
  expirable: boolean;
  weth: Address;
  isDegenMode: boolean;
  degenNFT: Address;
  expirationDate: number;
  maxDebtPerBlockMultiplier: number;
  botList: Address;
  minDebt: bigint;
  maxDebt: bigint;
  currentCumulativeLoss: bigint;
  maxCumulativeLoss: bigint;
  forbiddenTokenMask: bigint;
  isPaused: boolean;
}

export interface CreditManagerState extends BaseContractState {
  addressProvider: Address;
  accountFactory: Address;
  underlying: Address;
  pool: Address;
  creditFacade: Address;
  creditConfigurator: Address;
  priceOracle: Address;

  maxEnabledTokens: number;
  collateralTokens: Record<Address, number>;

  feeInterest: number;
  feeLiquidation: number;
  liquidationDiscount: number;
  feeLiquidationExpired: number;
  liquidationDiscountExpired: number;
  quotedTokensMask: bigint;
  contractsToAdapters: Record<Address, Address>;
  creditAccounts: Array<Address>;

  name: string;
}

export interface CreditConfiguratorState extends BaseContractState {
  emergencyLiquidators: Array<Address>;
}

export interface CreditFactoryState {
  creditFacade: CreditFacadeState;
  creditManager: CreditManagerState;
  creditConfigurator: CreditConfiguratorState;
}
