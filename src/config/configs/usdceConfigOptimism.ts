import { VELODROME_V2_DEFAULT_FACTORY } from "../../contracts/contracts";
import {
  BalancerVaultConfig,
  UniV3Config,
  VelodromeV2Config,
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
    { token0: "WETH", token1: "OP", fee: 3000 },
    { token0: "WETH", token1: "USDC_e", fee: 500 },
    { token0: "WETH", token1: "USDC_e", fee: 3000 },
    { token0: "WETH", token1: "WBTC", fee: 3000 },
    { token0: "wstETH", token1: "WETH", fee: 100 },
    { token0: "WETH", token1: "WBTC", fee: 500 },
    { token0: "OP", token1: "USDC_e", fee: 3000 },
    { token0: "WETH", token1: "OP", fee: 500 },
    { token0: "USDC_e", token1: "USDT", fee: 100 },
  ],
};

const tier1BalancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "BPT_rETH_ETH",
      status: 2,
    },
    {
      pool: "ECLP_wstETH_WETH",
      status: 2,
    },
    {
      pool: "BPT_ROAD",
      status: 2,
    },
  ],
};

const tier1VelodromeConfig: VelodromeV2Config = {
  contract: "VELODROME_V2_ROUTER",
  allowed: [
    {
      token0: "wstETH",
      token1: "WETH",
      stable: false,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "WETH",
      token1: "OP",
      stable: false,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "OP",
      token1: "USDC_e",
      stable: false,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "WETH",
      token1: "USDC_e",
      stable: false,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "wstETH",
      token1: "OP",
      stable: false,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "USDC_e",
      token1: "DAI",
      stable: true,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "USDC_e",
      token1: "USDT",
      stable: true,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
  ],
};

const tier1CreditManager: CreditManagerV3DeployConfig = {
  name: "USDC.e Tier 1 Optimism",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(1e3) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(2e5) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 100,
  liquidationPremium: 200,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: (BigInt(2e6) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "DAI",
      lt: 9600,
    },
    {
      token: "USDT",
      lt: 9600,
    },
    {
      token: "WETH",
      lt: 9400,
    },
    {
      token: "WBTC",
      lt: 9400,
    },
    {
      token: "OP",
      lt: 9000,
    },
    // BOOSTED
    {
      token: "yvWETH",
      lt: 9400,
    },
    {
      token: "wstETH",
      lt: 9400,
    },
    {
      token: "rETH",
      lt: 9400,
    },
    // FARMS
    { token: "yvUSDC_e", lt: 9400 },
    { token: "yvDAI", lt: 9400 },
    { token: "yvUSDT", lt: 9400 },
    // COMPATIBILITY
    { token: "3CRV", lt: 0 },
  ],
  adapters: [
    tier1UniV3Config,
    tier1BalancerConfig,
    tier1VelodromeConfig,
    { contract: "CURVE_3CRV_POOL_OP" },
    { contract: "YEARN_WETH_VAULT" },
    { contract: "YEARN_DAI_VAULT" },
    { contract: "YEARN_USDC_E_VAULT" },
    { contract: "YEARN_USDT_VAULT" },
  ],
};

const tier2UniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDC_e", fee: 500 },
    { token0: "WETH", token1: "USDC_e", fee: 3000 },
    { token0: "USDC_e", token1: "WLD", fee: 10000 },
    { token0: "WETH", token1: "WLD", fee: 3000 },
    { token0: "WETH", token1: "SNX", fee: 3000 },
  ],
};

const tier2VelodromeConfig: VelodromeV2Config = {
  contract: "VELODROME_V2_ROUTER",
  allowed: [
    {
      token0: "WETH",
      token1: "USDC_e",
      stable: false,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "USDC_e",
      token1: "SNX",
      stable: false,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
  ],
};

const tier2CreditManager: CreditManagerV3DeployConfig = {
  name: "USDC.e Tier 2 Optimism",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(1e3) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(5e4) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 100,
  liquidationPremium: 200,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: (BigInt(5e5) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "WETH",
      lt: 9400,
    },
    {
      token: "WLD",
      lt: 8500,
    },
    {
      token: "SNX",
      lt: 8500,
    },
  ],
  adapters: [tier2UniV3Config, tier2VelodromeConfig],
};

export const usdceConfigOptimism: PoolV3DeployConfig = {
  id: "optimism-usdce-v3",
  symbol: "dUSDCV3",
  name: "Main USDC.e v3",
  network: "Optimism",
  underlying: "USDC_e",
  accountAmount: BigInt(10_000) * POOL_DECIMALS,
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
    DAI: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(3e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    USDT: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(1.5e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    WBTC: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: (BigInt(3e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    WETH: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: (BigInt(1.5e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    OP: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: (BigInt(1e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    WLD: {
      minRate: 80,
      maxRate: 5000,
      quotaIncreaseFee: 5,
      limit: (BigInt(6e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    SNX: {
      minRate: 80,
      maxRate: 5000,
      quotaIncreaseFee: 5,
      limit: (BigInt(3e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },

    // BOOSTED
    yvWETH: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: (BigInt(5e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    wstETH: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: (BigInt(1e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    rETH: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: (BigInt(8e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },

    // FARMS
    yvDAI: {
      minRate: 5,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(2.3e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    yvUSDC_e: {
      minRate: 5,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(3.3e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    yvUSDT: {
      minRate: 5,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(2.3e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
  },
  creditManagers: [tier1CreditManager, tier2CreditManager],
  supportsQuotas: true,
};
