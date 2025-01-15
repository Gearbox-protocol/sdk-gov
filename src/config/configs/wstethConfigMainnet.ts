import {
  BalancerVaultConfig,
  GenericSwapConfig,
  MellowVaultConfig,
  PendlePairStatus,
  PendleRouterConfig,
  UniV3Config,
} from "../adapters";
import {
  CollateralToken,
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e18);

const mellowVaultConfigList: MellowVaultConfig[] = [
  {
    contract: "MELLOW_RESTAKING_VAULT",
    allowed: ["wstETH"],
  },
  {
    contract: "MELLOW_DECENTALIZED_VALIDATOR_VAULT",
    allowed: ["wstETH"],
  },
];

const balancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "trenSTETH",
      status: 2,
    },
    {
      pool: "DVstETH_wstETH_BPT",
      status: 2,
    },
  ],
};

const tier1CreditManager: CreditManagerV3DeployConfig = {
  name: "wstETH Correlated Tier 1",
  degenNft: false,
  expirationDate: undefined,
  minDebt: BigInt(50) * POOL_DECIMALS,
  maxDebt: BigInt(1_000) * POOL_DECIMALS,
  feeInterest: 2500,
  feeLiquidation: 0,
  liquidationPremium: 100,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 100,
  poolLimit: BigInt(50_000) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "rstETH",
      lt: 9600,
    },
    {
      token: "DVstETH",
      lt: 9600,
    },

    // COMPATIBILITY
    { token: "trenSTETH", lt: 0 },
    { token: "DVstETH_wstETH_BPT", lt: 0 },
    { token: "amphrETH", lt: 0 },
    { token: "Re7LRT", lt: 0 },
    { token: "steakLRT", lt: 0 },
  ],
  adapters: [...mellowVaultConfigList, balancerConfig],
};

const tier2CreditManager: CreditManagerV3DeployConfig = {
  name: "wstETH Correlated Tier 2",
  degenNft: false,
  expirationDate: undefined,
  minDebt: BigInt(10) * POOL_DECIMALS,
  maxDebt: BigInt(200) * POOL_DECIMALS,
  feeInterest: 2500,
  feeLiquidation: 0,
  liquidationPremium: 300,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 300,
  poolLimit: BigInt(20_000) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "rstETH",
      lt: 9400,
    },
    {
      token: "DVstETH",
      lt: 9400,
    },

    // COMPATIBILITY
    { token: "trenSTETH", lt: 0 },
    { token: "DVstETH_wstETH_BPT", lt: 0 },
    { token: "amphrETH", lt: 0 },
    { token: "Re7LRT", lt: 0 },
    { token: "steakLRT", lt: 0 },
  ],
  adapters: [...mellowVaultConfigList, balancerConfig],
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
    Rslope1: 25,
    Rslope2: 50,
    Rslope3: 2500,
    isBorrowingMoreU2Forbidden: true,
  },
  ratesAndLimits: {
    rstETH: {
      minRate: 5,
      maxRate: 200,
      quotaIncreaseFee: 0,
      limit: BigInt(5_000) * POOL_DECIMALS,
    },
    DVstETH: {
      minRate: 5,
      maxRate: 200,
      quotaIncreaseFee: 0,
      limit: BigInt(5_000) * POOL_DECIMALS,
    },

    // COMPATIBILITY
    trenSTETH: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
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
  },
  creditManagers: [tier1CreditManager, tier2CreditManager],
  supportsQuotas: true,
};
