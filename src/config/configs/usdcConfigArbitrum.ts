import {
  BalancerVaultConfig,
  GenericSwapConfig,
  UniV3Config,
} from "../adapters";
import {
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e6);
const POOL_DIVIDER = BigInt(1);

const tier1UniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDC", fee: 500 },
    { token0: "WETH", token1: "WBTC", fee: 500 },
    { token0: "wstETH", token1: "WETH", fee: 100 },
    { token0: "WBTC", token1: "WETH", fee: 3000 },
    { token0: "WBTC", token1: "USDC", fee: 500 },
    { token0: "wstETH", token1: "USDC", fee: 500 },
  ],
};

const tier1CamelotV3Config: GenericSwapConfig = {
  contract: "CAMELOT_V3_ROUTER",
  allowed: [{ token0: "USDe", token1: "USDC" }],
};

const tier1BalancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "wstETH_WETH_BPT",
      status: 2,
    },
    {
      pool: "rETH_wETH_BPT",
      status: 2,
    },
    {
      pool: "cbETH_rETH_wstETH",
      status: 2,
    },
  ],
};

const tier1CreditManager: CreditManagerV3DeployConfig = {
  name: "Trade USDC Tier 1 Arbitrum",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(2e4) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(4e5) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 50,
  liquidationPremium: 500,
  feeLiquidationExpired: 50,
  liquidationPremiumExpired: 500,
  poolLimit: (BigInt(4e6) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "USDe",
      lt: 9000,
    },
    {
      token: "WETH",
      lt: 8700,
    },
    {
      token: "WBTC",
      lt: 8700,
    },

    // BOOSTED
    {
      token: "wstETH",
      lt: 8700,
    },
    {
      token: "rETH",
      lt: 8700,
    },
    {
      token: "cbETH",
      lt: 8700,
    },
    // Compatibility
    {
      token: "USDEUSDC",
      lt: 0,
    },
  ],
  adapters: [
    tier1UniV3Config,
    tier1BalancerConfig,
    tier1CamelotV3Config,
    { contract: "CURVE_USDE_USDC_POOL_ARB" },
  ],
};

const tier2UniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDC", fee: 500 },
    { token0: "WETH", token1: "WBTC", fee: 500 },
    { token0: "wstETH", token1: "WETH", fee: 100 },
    { token0: "WBTC", token1: "WETH", fee: 3000 },
    { token0: "WBTC", token1: "USDC", fee: 500 },
    { token0: "wstETH", token1: "USDC", fee: 500 },
    { token0: "PENDLE", token1: "WETH", fee: 3000 },
    { token0: "WETH", token1: "ARB", fee: 500 },
    { token0: "WETH", token1: "ARB", fee: 3000 },
    { token0: "ARB", token1: "USDC", fee: 500 },
  ],
};

const tier2BalancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "wstETH_WETH_BPT",
      status: 2,
    },
    {
      pool: "rETH_wETH_BPT",
      status: 2,
    },
    {
      pool: "cbETH_rETH_wstETH",
      status: 2,
    },
  ],
};

const tier2CamelotV3Config: GenericSwapConfig = {
  contract: "CAMELOT_V3_ROUTER",
  allowed: [{ token0: "USDe", token1: "USDC" }],
};

const tier2CreditManager: CreditManagerV3DeployConfig = {
  name: "Trade USDC Tier 2 Arbitrum",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(1e3) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(2e4) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 50,
  liquidationPremium: 500,
  feeLiquidationExpired: 50,
  liquidationPremiumExpired: 500,
  poolLimit: (BigInt(2e6) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "USDe",
      lt: 9000,
    },
    {
      token: "WETH",
      lt: 8700,
    },
    {
      token: "WBTC",
      lt: 8700,
    },
    {
      token: "ARB",
      lt: 8000,
    },
    {
      token: "PENDLE",
      lt: 7000,
    },
    /// BOOSTED
    {
      token: "wstETH",
      lt: 8700,
    },
    {
      token: "rETH",
      lt: 8700,
    },
    {
      token: "cbETH",
      lt: 8700,
    },
    /// Compatibility
    {
      token: "USDEUSDC",
      lt: 0,
    },
  ],
  adapters: [
    tier2UniV3Config,
    tier2BalancerConfig,
    tier2CamelotV3Config,
    { contract: "CURVE_USDE_USDC_POOL_ARB" },
  ],
};

export const usdcConfigArbitrum: PoolV3DeployConfig = {
  id: "arbitrum-usdc-v3",
  symbol: "dUSDCV3",
  name: "Main USDC v3",
  network: "Arbitrum",
  underlying: "USDC",
  accountAmount: BigInt(20_000) * POOL_DECIMALS,
  withdrawalFee: 0,
  totalDebtLimit: BigInt(100_000_000) * POOL_DECIMALS,
  irm: {
    U1: 7000,
    U2: 9000,
    Rbase: 0,
    Rslope1: 100,
    Rslope2: 125,
    Rslope3: 10000,
    isBorrowingMoreU2Forbidden: true,
  },
  ratesAndLimits: {
    // TRADEABLE TOKENS
    WBTC: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(2.5e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    WETH: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(7e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    ARB: {
      minRate: 80,
      maxRate: 2400,
      quotaIncreaseFee: 5,
      limit: (BigInt(1.5e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    PENDLE: {
      minRate: 80,
      maxRate: 2400,
      quotaIncreaseFee: 5,
      limit: (BigInt(5e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    // BOOSTED
    wstETH: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(5.5e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    rETH: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(3e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    cbETH: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(2e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    // POINTS FARMING
    USDe: {
      minRate: 50,
      maxRate: 5000,
      quotaIncreaseFee: 0,
      limit: (BigInt(5e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
  },
  creditManagers: [tier1CreditManager, tier2CreditManager],
  supportsQuotas: true,
};
