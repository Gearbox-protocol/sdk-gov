import { VELODROME_V2_DEFAULT_FACTORY } from "../../contracts/contracts";
import {
  BalancerVaultConfig,
  UniV3Config,
  VelodromeCLConfig,
  VelodromeV2Config,
} from "../adapters";
import {
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e6);
const POOL_DIVIDER = BigInt(1);

const shadowCorrelatedConfig: VelodromeCLConfig = {
  contract: "SHADOW_ROUTER",
  allowed: [
    { token0: "USDC", token1: "scUSD", tickSpacing: 5 },
    { token0: "USDC", token1: "WETH", tickSpacing: 100 },
    { token0: "wS", token1: "USDC", tickSpacing: 50 },
    { token0: "wS", token1: "stS", tickSpacing: 1 },
  ],
};

const beetsCorrelatedConfig: BalancerVaultConfig = {
  contract: "BEETS_VAULT",
  allowed: [
    {
      pool: "bpt_rsb",
      status: 2,
    },
  ],
};

const tier1CorrelatedCreditManager: CreditManagerV3DeployConfig = {
  name: "USDC.e Correlated Tier 1",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(50_000) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(1_000_000) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 0,
  liquidationPremium: 200,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 200,
  poolLimit: (BigInt(30_000_000) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "scUSD",
      lt: 9000,
    },

    // COMPATIBILITY
    { token: "bpt_rsb", lt: 0 },
  ],
  adapters: [shadowCorrelatedConfig, beetsCorrelatedConfig],
};

const tier2CorrelatedCreditManager: CreditManagerV3DeployConfig = {
  name: "USDC.e Correlated Tier 2",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(2_500) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(50_000) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 0,
  liquidationPremium: 300,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 300,
  poolLimit: (BigInt(10_000_000) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "scUSD",
      lt: 9000,
    },

    // COMPATIBILITY
    { token: "bpt_rsb", lt: 0 },
  ],
  adapters: [shadowCorrelatedConfig, beetsCorrelatedConfig],
};

export const usdceConfigSonic: PoolV3DeployConfig = {
  id: "sonic-usdce-v3",
  symbol: "dUSDC.eV3",
  name: "Main USDC.e v3",
  network: "Sonic",
  underlying: "USDC",
  accountAmount: BigInt(10_000) * POOL_DECIMALS,
  withdrawalFee: 0,
  totalDebtLimit: BigInt(50_000_000) * POOL_DECIMALS,

  irm: {
    U1: 7000,
    U2: 9000,
    Rbase: 0,
    Rslope1: 200,
    Rslope2: 500,
    Rslope3: 2300,
    isBorrowingMoreU2Forbidden: true,
  },
  ratesAndLimits: {
    scUSD: {
      minRate: 500,
      maxRate: 500,
      quotaIncreaseFee: 1,
      limit: (BigInt(750_000) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    stS: {
      minRate: 1000,
      maxRate: 1000,
      quotaIncreaseFee: 1,
      limit: (BigInt(400_000) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    wS: {
      minRate: 1000,
      maxRate: 1000,
      quotaIncreaseFee: 1,
      limit: (BigInt(800_000) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    WETH: {
      minRate: 1000,
      maxRate: 1000,
      quotaIncreaseFee: 1,
      limit: (BigInt(100_000) * POOL_DECIMALS) / POOL_DIVIDER,
    },

    // COMPATIBILITY
    bpt_rsb: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
  },
  creditManagers: [tier1CorrelatedCreditManager, tier2CorrelatedCreditManager],
  supportsQuotas: true,
};
