import {
  AdapterConfig,
  BalancerV3VaultConfig,
  BalancerVaultConfig,
} from "../adapters";
import {
  CollateralToken,
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e18);

const balancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "DVstETH_wstETH_BPT",
      status: 2,
    },
  ],
};

const balancerV3Config: BalancerV3VaultConfig = {
  contract: "BALANCER_V3_ROUTER",
  allowed: [
    {
      pool: "rstETH_Lido_wstETH",
      status: true,
    },
  ],
};

const collateralTokens: CollateralToken[] = [
  {
    token: "rstETH",
    lt: 9500,
  },
  {
    token: "DVstETH",
    lt: 9300,
  },

  // COMPATIBILITY
  { token: "DVstETH_wstETH_BPT", lt: 0 },
  { token: "amphrETH", lt: 0 },
  { token: "Re7LRT", lt: 0 },
  { token: "steakLRT", lt: 0 },
  { token: "waEthLidowstETH", lt: 0 },
];

const adapters: AdapterConfig[] = [
  { contract: "MELLOW_RESTAKING_VAULT" },
  { contract: "AAVE_WSTETH_VAULT" },
  balancerConfig,
  balancerV3Config,
];

const tier1CreditManager: CreditManagerV3DeployConfig = {
  name: "wstETH Correlated Tier 1",
  degenNft: false,
  expirationDate: undefined,
  minDebt: BigInt(50) * POOL_DECIMALS,
  maxDebt: BigInt(1_000) * POOL_DECIMALS,
  feeInterest: 2500,
  feeLiquidation: 20,
  liquidationPremium: 200,
  feeLiquidationExpired: 20,
  liquidationPremiumExpired: 200,
  poolLimit: BigInt(50_000) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens,
  adapters,
};

const tier2CreditManager: CreditManagerV3DeployConfig = {
  name: "wstETH Correlated Tier 2",
  degenNft: false,
  expirationDate: undefined,
  minDebt: BigInt(10) * POOL_DECIMALS,
  maxDebt: BigInt(200) * POOL_DECIMALS,
  feeInterest: 2500,
  feeLiquidation: 30,
  liquidationPremium: 300,
  feeLiquidationExpired: 30,
  liquidationPremiumExpired: 300,
  poolLimit: BigInt(20_000) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens,
  adapters,
};

export const wstethConfigMainnet: PoolV3DeployConfig = {
  id: "mainnet-wsteth-v3",
  symbol: "dWSTETHV3",
  name: "wstETH v3",
  network: "Mainnet",
  underlying: "wstETH",
  accountAmount: BigInt(100_000) * POOL_DECIMALS,
  withdrawalFee: 0,
  totalDebtLimit: BigInt(30_000) * POOL_DECIMALS,
  irm: {
    U1: 7000,
    U2: 9000,
    Rbase: 0,
    Rslope1: 0,
    Rslope2: 0,
    Rslope3: 3000,
    isBorrowingMoreU2Forbidden: true,
  },
  ratesAndLimits: {
    rstETH: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(2_400) * POOL_DECIMALS,
    },
    DVstETH: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(1_400) * POOL_DECIMALS,
    },

    // COMPATIBILITY
    DVstETH_wstETH_BPT: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    amphrETH: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    Re7LRT: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    steakLRT: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    waEthLidowstETH: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
  },
  creditManagers: [tier1CreditManager, tier2CreditManager],
  supportsQuotas: true,
};
