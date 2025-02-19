import { BalancerVaultConfig, VelodromeCLConfig } from "../adapters";
import {
  CollateralToken,
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e18);
const POOL_DIVIDER = BigInt(1);

const shadowConfig: VelodromeCLConfig = {
  contract: "SHADOW_ROUTER",
  allowed: [{ token0: "wS", token1: "stS", tickSpacing: 1 }],
};

const beetsCorrelatedConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "bpt_sss",
      status: 2,
    },
  ],
};

const correlatedCollateralTokens: CollateralToken[] = [
  {
    token: "stS",
    lt: 9000,
  },

  // COMPATIBILITY
  { token: "bpt_sss", lt: 0 },
];

const tier1CorrelatedCreditManager: CreditManagerV3DeployConfig = {
  name: "wS Correlated Tier 1",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(50_000) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(1_000_000) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 50,
  liquidationPremium: 200,
  feeLiquidationExpired: 50,
  liquidationPremiumExpired: 200,
  poolLimit: (BigInt(700_000) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: correlatedCollateralTokens,
  adapters: [shadowConfig, beetsCorrelatedConfig],
};

const tier2CorrelatedCreditManager: CreditManagerV3DeployConfig = {
  name: "wS Correlated Tier 2",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(2_500) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(50_000) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 50,
  liquidationPremium: 300,
  feeLiquidationExpired: 50,
  liquidationPremiumExpired: 300,
  poolLimit: (BigInt(300_000) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: correlatedCollateralTokens,
  adapters: [shadowConfig, beetsCorrelatedConfig],
};

export const wsConfigSonic: PoolV3DeployConfig = {
  id: "sonic-ws-v3",
  symbol: "dwS.eV3",
  name: "wS v3 Sonic",
  network: "Sonic",
  underlying: "wS",
  accountAmount: BigInt(10_000) * POOL_DECIMALS,
  withdrawalFee: 0,
  totalDebtLimit: BigInt(50_000_000) * POOL_DECIMALS,

  irm: {
    U1: 7000,
    U2: 9000,
    Rbase: 0,
    Rslope1: 150,
    Rslope2: 200,
    Rslope3: 2150,
    isBorrowingMoreU2Forbidden: true,
  },
  ratesAndLimits: {
    stS: {
      minRate: 5,
      maxRate: 1000,
      quotaIncreaseFee: 1,
      limit: (BigInt(7_500_000) * POOL_DECIMALS) / POOL_DIVIDER,
    },

    // COMPATIBILITY
    bpt_rsb: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    bpt_sss: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    BPT_scUSD_stS: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    BPT_USDCe_stS: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
  },
  creditManagers: [tier1CorrelatedCreditManager, tier2CorrelatedCreditManager],
  supportsQuotas: true,
};
