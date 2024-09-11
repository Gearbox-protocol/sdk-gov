import { NetworkType } from "../core/chains";
import { SupportedToken } from "../tokens/token";
import { AdapterConfig } from "./adapters";
import { LinearIRMParams } from "./linearIRM";

export interface RatesAndLimits {
  minRate: number;
  maxRate: number;
  quotaIncreaseFee: number;
  limit: bigint;
}

export interface CollateralToken {
  token: SupportedToken;
  lt: number;
}

export interface CreditManagerV3DeployConfig {
  degenNft: boolean;
  minDebt: bigint;
  maxDebt: bigint;
  feeInterest: number;
  feeLiquidation: number;
  liquidationPremium: number;
  feeLiquidationExpired: number;
  liquidationPremiumExpired: number;
  expirationDate?: number;
  collateralTokens: Array<CollateralToken>;
  adapters: Array<AdapterConfig>;
  poolLimit: bigint;
  name: string;
  maxEnabledTokens: number;
}

export interface PoolV3DeployConfig {
  id: string;
  symbol: string;
  name: string;
  network: NetworkType;

  underlying: SupportedToken;
  supportsQuotas: boolean;
  accountAmount: bigint;

  irm: LinearIRMParams;
  totalDebtLimit: bigint;
  withdrawalFee: number;

  ratesAndLimits: Partial<Record<SupportedToken, RatesAndLimits>>;

  creditManagers: Array<CreditManagerV3DeployConfig>;
}
