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

const POOL_DECIMALS = BigInt(1e18);

const VELODROME_V2_DEFAULT_FACTORY =
  "0xF1046053aa5682b4F9a81b5481394DA16BE5FF5a";

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
      token1: "WETH",
      stable: false,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
  ],
};

const tier1VelodromeCLConfig: VelodromeCLConfig = {
  contract: "VELODROME_CL_ROUTER",
  allowed: [
    {
      token0: "ezETH",
      token1: "wstETH",
      tickSpacing: 1,
    },
  ],
};

const tier1CreditManager: CreditManagerV3DeployConfig = {
  name: "WETH Tier 1 Optimism",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(35) * POOL_DECIMALS) / BigInt(100),
  maxDebt: BigInt(150) * POOL_DECIMALS,
  feeInterest: 2500,
  feeLiquidation: 100,
  liquidationPremium: 200,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: BigInt(700) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "USDC_e",
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
      token: "yvUSDC_e",
      lt: 9400,
    },
    // FARMS
    {
      token: "wstETH",
      lt: 9400,
    },
    {
      token: "rETH",
      lt: 9400,
    },
    {
      token: "ezETH",
      lt: 9400,
    },
    { token: "yvWETH", lt: 9400 },
  ],
  adapters: [
    tier1UniV3Config,
    tier1BalancerConfig,
    tier1VelodromeConfig,
    tier1VelodromeCLConfig,
    { contract: "YEARN_USDC_E_VAULT" },
    { contract: "YEARN_WETH_VAULT" },
  ],
};

const tier2UniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDC_e", fee: 500 },
    { token0: "WETH", token1: "USDC_e", fee: 3000 },
    { token0: "USDC", token1: "WLD", fee: 10000 },
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
  name: "Trade WETH Tier 2 Optimism",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(35) * POOL_DECIMALS) / BigInt(100),
  maxDebt: BigInt(35) * POOL_DECIMALS,
  feeInterest: 2500,
  feeLiquidation: 100,
  liquidationPremium: 200,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: BigInt(350) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "USDC_e",
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

export const wethConfigOptimism: PoolV3DeployConfig = {
  id: "optimism-weth-v3",
  symbol: "dWETHV3",
  name: "WETH v3",
  network: "Optimism",
  underlying: "WETH",
  accountAmount: BigInt(10) * POOL_DECIMALS,
  withdrawalFee: 0,
  totalDebtLimit: BigInt(150_000) * POOL_DECIMALS,
  irm: {
    U1: 7000,
    U2: 9000,
    Rbase: 0,
    Rslope1: 200,
    Rslope2: 250,
    Rslope3: 6000,
    isBorrowingMoreU2Forbidden: true,
  },
  ratesAndLimits: {
    // TRADEABLE TOKENS

    WBTC: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: BigInt(150) * POOL_DECIMALS,
    },
    USDC_e: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: BigInt(1000) * POOL_DECIMALS,
    },
    OP: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: BigInt(300) * POOL_DECIMALS,
    },
    WLD: {
      minRate: 80,
      maxRate: 5000,
      quotaIncreaseFee: 5,
      limit: BigInt(100) * POOL_DECIMALS,
    },
    SNX: {
      minRate: 80,
      maxRate: 5000,
      quotaIncreaseFee: 5,
      limit: BigInt(100) * POOL_DECIMALS,
    },
    // BOOSTED
    yvUSDC_e: {
      minRate: 5,
      maxRate: 2700,
      quotaIncreaseFee: 0,
      limit: BigInt(100) * POOL_DECIMALS,
    },

    // FARMS
    yvWETH: {
      minRate: 4,
      maxRate: 500,
      quotaIncreaseFee: 0,
      limit: BigInt(180) * POOL_DECIMALS,
    },
    wstETH: {
      minRate: 4,
      maxRate: 500,
      quotaIncreaseFee: 0,
      limit: BigInt(1000) * POOL_DECIMALS,
    },
    rETH: {
      minRate: 4,
      maxRate: 500,
      quotaIncreaseFee: 0,
      limit: BigInt(500) * POOL_DECIMALS,
    },
    ezETH: {
      minRate: 4,
      maxRate: 500,
      quotaIncreaseFee: 0,
      limit: BigInt(500) * POOL_DECIMALS,
    },
  },
  creditManagers: [tier1CreditManager, tier2CreditManager],
  supportsQuotas: true,
};
