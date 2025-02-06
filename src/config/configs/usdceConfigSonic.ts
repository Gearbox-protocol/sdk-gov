import {
  EQUALIZER_DEFAULT_FACTORY,
  VELODROME_V2_DEFAULT_FACTORY,
} from "../../contracts/contracts";
import {
  BalancerVaultConfig,
  EqualizerConfig,
  UniV3Config,
  VelodromeCLConfig,
  VelodromeV2Config,
} from "../adapters";
import {
  CollateralToken,
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e6);
const POOL_DIVIDER = BigInt(1);

const shadowConfig: VelodromeCLConfig = {
  contract: "SHADOW_ROUTER",
  allowed: [
    { token0: "USDC", token1: "scUSD", tickSpacing: 5 },
    { token0: "USDC", token1: "WETH", tickSpacing: 100 },
    { token0: "wS", token1: "USDC", tickSpacing: 50 },
    { token0: "wS", token1: "stS", tickSpacing: 1 },
  ],
};

const beetsCorrelatedConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "bpt_rsb",
      status: 2,
    },
  ],
};

const correlatedCollateralTokens: CollateralToken[] = [
  {
    token: "scUSD",
    lt: 9000,
  },

  // COMPATIBILITY
  { token: "bpt_rsb", lt: 0 },
];

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
  collateralTokens: correlatedCollateralTokens,
  adapters: [shadowConfig, beetsCorrelatedConfig],
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
  collateralTokens: correlatedCollateralTokens,
  adapters: [shadowConfig, beetsCorrelatedConfig],
};

const beetsVolatileConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "bpt_rsb",
      status: 2,
    },
    {
      pool: "bpt_sss",
      status: 2,
    },
    {
      pool: "BPT_scUSD_stS",
      status: 2,
    },
    {
      pool: "BPT_USDCe_stS",
      status: 2,
    },
  ],
};

const equalizerConfig: EqualizerConfig = {
  contract: "EQUALIZER_ROUTER",
  allowed: [
    {
      token0: "USDC",
      token1: "WETH",
      stable: false,
    },
  ],
};

const volatileCollateralTokens: CollateralToken[] = [
  {
    token: "stS",
    lt: 8200,
  },
  {
    token: "wS",
    lt: 8500,
  },
  {
    token: "WETH",
    lt: 8500,
  },

  // COMPATIBILITY
  { token: "bpt_rsb", lt: 0 },
  { token: "bpt_sss", lt: 0 },
  { token: "BPT_scUSD_stS", lt: 0 },
  { token: "BPT_USDCe_stS", lt: 0 },
];

const tier1VolatileCreditManager: CreditManagerV3DeployConfig = {
  name: "USDC.e Volatile Tier 1",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(50_000) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(1_000_000) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 0,
  liquidationPremium: 300,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 300,
  poolLimit: (BigInt(0) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: volatileCollateralTokens,
  adapters: [shadowConfig, beetsVolatileConfig, equalizerConfig],
};

const tier2VolatileCreditManager: CreditManagerV3DeployConfig = {
  name: "USDC.e Volatile Tier 2",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(2_500) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(50_000) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 0,
  liquidationPremium: 400,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 400,
  poolLimit: (BigInt(0) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: volatileCollateralTokens,
  adapters: [shadowConfig, beetsVolatileConfig, equalizerConfig],
};

export const usdceConfigSonic: PoolV3DeployConfig = {
  id: "sonic-usdce-v3",
  symbol: "dUSDC.eV3",
  name: "USDC.e v3 Sonic",
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
  creditManagers: [
    tier1CorrelatedCreditManager,
    tier2CorrelatedCreditManager,
    tier1VolatileCreditManager,
    tier2VolatileCreditManager,
  ],
  supportsQuotas: true,
};
