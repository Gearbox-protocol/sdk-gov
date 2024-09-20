import {
  BalancerVaultConfig,
  GenericSwapConfig,
  UniV3Config,
} from "../adapters";
import {
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e18);
const POOL_DIVIDER = BigInt(2000);

const tier1UniV2Config: GenericSwapConfig = {
  contract: "UNISWAP_V2_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDT" },
    { token0: "USDC", token1: "WETH" },
    { token0: "USDC", token1: "USDT" },
    { token0: "DAI", token1: "USDC" },
    { token0: "DAI", token1: "WETH" },
    { token0: "WBTC", token1: "WETH" },
  ],
};

const tier1UniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "USDC", token1: "WETH", fee: 500 },
    { token0: "WBTC", token1: "WETH", fee: 3000 },
    { token0: "DAI", token1: "USDC", fee: 100 },
    { token0: "WBTC", token1: "WETH", fee: 500 },
    { token0: "USDC", token1: "WETH", fee: 3000 },
    { token0: "WETH", token1: "USDT", fee: 3000 },
    { token0: "DAI", token1: "USDC", fee: 500 },
    { token0: "WBTC", token1: "USDC", fee: 3000 },
    { token0: "WETH", token1: "USDT", fee: 500 },
    { token0: "USDC", token1: "USDT", fee: 100 },
    { token0: "DAI", token1: "WETH", fee: 3000 },
    { token0: "USDC", token1: "USDT", fee: 500 },
    { token0: "DAI", token1: "WETH", fee: 500 },
    { token0: "WBTC", token1: "USDT", fee: 3000 },
    { token0: "USDC", token1: "WETH", fee: 10000 },
  ],
};

const tier1SushiswapConfig: GenericSwapConfig = {
  contract: "SUSHISWAP_ROUTER",
  allowed: [
    { token0: "WBTC", token1: "WETH" },
    { token0: "WETH", token1: "USDT" },
    { token0: "USDC", token1: "WETH" },
    { token0: "DAI", token1: "WETH" },
  ],
};

const tier1CreditManager: CreditManagerV3DeployConfig = {
  name: "Trade WETH Tier 1",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(2e4) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(1e6) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 150,
  liquidationPremium: 400,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: (BigInt(3e6) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "USDC",
      lt: 9000,
    },
    {
      token: "WBTC",
      lt: 9000,
    },
    {
      token: "DAI",
      lt: 9000,
    },
    {
      token: "USDT",
      lt: 9000,
    },
    {
      token: "yvUSDC",
      lt: 8700,
    },
    {
      token: "yvWBTC",
      lt: 8700,
    },
    {
      token: "sDAI",
      lt: 8700,
    },
    // FARMS
    {
      token: "yvWETH",
      lt: 9000,
    },
    {
      token: "STETH",
      lt: 9000,
    },
    // COMPATIBILITY
    { token: "3Crv", lt: 0 },
    { token: "crvUSDTWBTCWETH", lt: 0 },
    { token: "steCRV", lt: 0 },
  ],
  adapters: [
    tier1UniV2Config,
    tier1UniV3Config,
    tier1SushiswapConfig,
    { contract: "CURVE_3CRV_POOL" },
    { contract: "CURVE_3CRYPTO_POOL" },
    { contract: "CURVE_STETH_GATEWAY" },
    { contract: "YEARN_USDC_VAULT" },
    { contract: "YEARN_WBTC_VAULT" },
    { contract: "YEARN_WETH_VAULT" },
    { contract: "MAKER_DSR_VAULT" },
  ],
};

const tier2UniV2Config: GenericSwapConfig = {
  contract: "UNISWAP_V2_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDT" },
    { token0: "USDC", token1: "WETH" },
    { token0: "USDC", token1: "USDT" },
    { token0: "DAI", token1: "USDC" },
    { token0: "DAI", token1: "WETH" },
    { token0: "DAI", token1: "MKR" },
    { token0: "MKR", token1: "WETH" },
    { token0: "LINK", token1: "WETH" },
  ],
};

const tier2UniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "USDC", token1: "WETH", fee: 500 },
    { token0: "DAI", token1: "USDC", fee: 100 },
    { token0: "USDC", token1: "WETH", fee: 3000 },
    { token0: "WETH", token1: "USDT", fee: 3000 },
    { token0: "DAI", token1: "USDC", fee: 500 },
    { token0: "WETH", token1: "USDT", fee: 500 },
    { token0: "UNI", token1: "WETH", fee: 3000 },
    { token0: "USDC", token1: "USDT", fee: 100 },
    { token0: "MKR", token1: "WETH", fee: 3000 },
    { token0: "LINK", token1: "WETH", fee: 3000 },
    { token0: "MKR", token1: "WETH", fee: 10000 },
    { token0: "DAI", token1: "WETH", fee: 3000 },
    { token0: "USDC", token1: "USDT", fee: 500 },
    { token0: "DAI", token1: "WETH", fee: 500 },
    { token0: "LDO", token1: "WETH", fee: 3000 },
    { token0: "USDC", token1: "WETH", fee: 10000 },
  ],
};

const tier2SushiswapConfig: GenericSwapConfig = {
  contract: "SUSHISWAP_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDT" },
    { token0: "USDC", token1: "WETH" },
    { token0: "DAI", token1: "WETH" },
    { token0: "LDO", token1: "WETH" },
    { token0: "LINK", token1: "WETH" },
  ],
};

const tier2CreditManager: CreditManagerV3DeployConfig = {
  name: "Trade WETH Tier 2",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(2e4) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(5e5) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 150,
  liquidationPremium: 400,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: (BigInt(3e6) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "USDC",
      lt: 9000,
    },
    {
      token: "DAI",
      lt: 9000,
    },
    {
      token: "USDT",
      lt: 9000,
    },
    {
      token: "MKR",
      lt: 8250,
    },
    {
      token: "UNI",
      lt: 8250,
    },
    {
      token: "LINK",
      lt: 8250,
    },
    {
      token: "LDO",
      lt: 8250,
    },
  ],
  adapters: [tier2UniV2Config, tier2UniV3Config, tier2SushiswapConfig],
};

const tier3UniV2Config: GenericSwapConfig = {
  contract: "UNISWAP_V2_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDT" },
    { token0: "USDC", token1: "WETH" },
    { token0: "USDC", token1: "USDT" },
    { token0: "DAI", token1: "USDC" },
    { token0: "DAI", token1: "WETH" },
    { token0: "FXS", token1: "FRAX" },
    { token0: "SNX", token1: "WETH" },
  ],
};

const tier3UniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "USDC", token1: "WETH", fee: 500 },
    { token0: "DAI", token1: "USDC", fee: 100 },
    { token0: "FRAX", token1: "USDC", fee: 500 },
    { token0: "USDC", token1: "WETH", fee: 3000 },
    { token0: "WETH", token1: "USDT", fee: 3000 },
    { token0: "DAI", token1: "USDC", fee: 500 },
    { token0: "WETH", token1: "USDT", fee: 500 },
    { token0: "USDC", token1: "USDT", fee: 100 },
    { token0: "DAI", token1: "FRAX", fee: 500 },
    { token0: "DAI", token1: "WETH", fee: 3000 },
    { token0: "USDC", token1: "USDT", fee: 500 },
    { token0: "DAI", token1: "WETH", fee: 500 },
    { token0: "USDC", token1: "WETH", fee: 10000 },
    { token0: "APE", token1: "WETH", fee: 3000 },
    { token0: "WETH", token1: "CRV", fee: 3000 },
    { token0: "WETH", token1: "CRV", fee: 10000 },
    { token0: "WETH", token1: "CVX", fee: 10000 },
    { token0: "FXS", token1: "FRAX", fee: 10000 },
    { token0: "FXS", token1: "FRAX", fee: 10000 },
  ],
};

const tier3SushiswapConfig: GenericSwapConfig = {
  contract: "SUSHISWAP_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDT" },
    { token0: "USDC", token1: "WETH" },
    { token0: "DAI", token1: "WETH" },
    { token0: "WETH", token1: "FXS" },
    { token0: "CVX", token1: "WETH" },
    { token0: "CRV", token1: "WETH" },
  ],
};

const tier3FraxswapConfig: GenericSwapConfig = {
  contract: "FRAXSWAP_ROUTER",
  allowed: [
    { token0: "FRAX", token1: "FXS" },
    { token0: "FRAX", token1: "WETH" },
  ],
};

const tier3CreditManager: CreditManagerV3DeployConfig = {
  name: "Trade WETH Tier 3",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(2e4) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(2e5) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 150,
  liquidationPremium: 400,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: (BigInt(3e6) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "USDC",
      lt: 9000,
    },
    {
      token: "DAI",
      lt: 9000,
    },
    {
      token: "USDT",
      lt: 9000,
    },
    {
      token: "FRAX",
      lt: 9000,
    },
    {
      token: "CRV",
      lt: 7250,
    },
    {
      token: "CVX",
      lt: 7250,
    },
    {
      token: "FXS",
      lt: 7250,
    },
    {
      token: "APE",
      lt: 7250,
    },
    // COMPATIBILITY
    { token: "crvCVXETH", lt: 0 },
    { token: "crvUSDETHCRV", lt: 0 },
    { token: "crvUSD", lt: 0 },
  ],
  adapters: [
    tier3UniV2Config,
    tier3UniV3Config,
    tier3SushiswapConfig,
    tier3FraxswapConfig,
    { contract: "CURVE_CVXETH_POOL" },
    { contract: "CURVE_TRI_CRV_POOL" },
  ],
};

const farmUniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "WETH", token1: "CRV", fee: 3000 },
    { token0: "WETH", token1: "CRV", fee: 10000 },
    { token0: "WETH", token1: "CVX", fee: 10000 },
    { token0: "WBTC", token1: "WETH", fee: 3000 },
    { token0: "WBTC", token1: "WETH", fee: 500 },
    { token0: "WETH", token1: "SWISE", fee: 3000 },
  ],
};

const farmBalancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "weETH_rETH",
      status: 2,
    },
    {
      pool: "osETH_wETH_BPT",
      status: 2,
    },
    {
      pool: "B_rETH_STABLE",
      status: 1,
    },
    {
      pool: "B_80BAL_20WETH",
      status: 2,
    },
    {
      pool: "50WETH_50AURA",
      status: 2,
    },
  ],
};

const farmCreditManager: CreditManagerV3DeployConfig = {
  name: "Farm WETH",
  degenNft: true,
  expirationDate: undefined,
  minDebt: (BigInt(5e4) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(1e6) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 150,
  liquidationPremium: 400,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: (BigInt(5e6) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "WBTC",
      lt: 9000,
    },
    {
      token: "USDT",
      lt: 9000,
    },
    // LSD
    {
      token: "STETH",
      lt: 9000,
    },
    {
      token: "rETH",
      lt: 9000,
    },
    {
      token: "weETH",
      lt: 9000,
    },
    {
      token: "osETH",
      lt: 9000,
    },
    // Yearn
    { token: "yvWETH", lt: 9000 },

    // Convex
    { token: "stkcvxcrvUSDETHCRV", lt: 8500 },
    { token: "stkcvxcrvUSDTWBTCWETH", lt: 8500 },

    // Aura
    { token: "auraB_rETH_STABLE_vault", lt: 8700 },

    // Rewards
    { token: "CRV", lt: 7250 },
    { token: "CVX", lt: 7250 },
    { token: "BAL", lt: 0 },
    { token: "AURA", lt: 0 },
    { token: "SWISE", lt: 0 },

    // Compatibility
    { token: "crvUSDETHCRV", lt: 0 },
    { token: "cvxcrvUSDETHCRV", lt: 0 },

    { token: "crvUSDTWBTCWETH", lt: 0 },
    { token: "cvxcrvUSDTWBTCWETH", lt: 0 },

    { token: "B_rETH_STABLE", lt: 0 },
    { token: "auraB_rETH_STABLE", lt: 0 },

    { token: "steCRV", lt: 0 },
    { token: "crvUSD", lt: 0 },
    { token: "crvCVXETH", lt: 0 },
    { token: "rETH_f", lt: 0 },
  ],
  adapters: [
    // Swapping
    farmUniV3Config,
    farmBalancerConfig,
    { contract: "CURVE_CVXETH_POOL" },
    { contract: "CURVE_STETH_GATEWAY" },
    { contract: "CURVE_RETH_ETH_POOL" },

    // Curve
    { contract: "CURVE_TRI_CRV_POOL" },
    { contract: "CURVE_3CRYPTO_POOL" },

    // Convex
    { contract: "CONVEX_BOOSTER" },
    { contract: "CONVEX_TRI_CRV_POOL" },
    { contract: "CONVEX_3CRYPTO_POOL" },

    // Aura
    { contract: "AURA_BOOSTER" },
    { contract: "AURA_B_RETH_STABLE_POOL" },

    // Yearn
    { contract: "YEARN_WETH_VAULT" },
  ],
};

const restakingUniswapV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "pufETH", token1: "WETH", fee: 3000 },
    { token0: "weETH", token1: "WETH", fee: 500 },
    { token0: "rETH", token1: "WETH", fee: 500 },
    { token0: "rETH", token1: "WETH", fee: 100 },
  ],
};

const restakingPancakeswapV3Config: UniV3Config = {
  contract: "PANCAKESWAP_V3_ROUTER",
  allowed: [{ token0: "rswETH", token1: "WETH", fee: 500 }],
};

const restakingBalancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "weETH_rETH",
      status: 2,
    },
    {
      pool: "ezETH_WETH_BPT",
      status: 2,
    },
    {
      pool: "B_rETH_STABLE",
      status: 2,
    },
    {
      pool: "weETH_ezETH_rswETH",
      status: 2,
    },
    {
      pool: "rsETH_WETH",
      status: 2,
    },
  ],
};

const restakingCreditManager: CreditManagerV3DeployConfig = {
  name: "Restaking WETH",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(5e4) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(1e6) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 100,
  liquidationPremium: 300,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: BigInt(30000) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens: [
    // LRT
    {
      token: "weETH",
      lt: 9150,
    },
    {
      token: "ezETH",
      lt: 8700,
    },
    {
      token: "rsETH",
      lt: 9000,
    },
    {
      token: "pufETH",
      lt: 8700,
    },
    {
      token: "rswETH",
      lt: 8700,
    },
    // Compatibility
    {
      token: "STETH",
      lt: 0,
    },
    {
      token: "wstETH",
      lt: 0,
    },
    {
      token: "rETH",
      lt: 0,
    },
    {
      token: "rETH_f",
      lt: 0,
    },
    {
      token: "steCRV",
      lt: 0,
    },
    {
      token: "pufETHwstE",
      lt: 0,
    },
  ],
  adapters: [
    restakingUniswapV3Config,
    restakingPancakeswapV3Config,
    restakingBalancerConfig,
    { contract: "CURVE_RETH_ETH_POOL" },
    { contract: "CURVE_PUFETH_WSTETH_POOL" },
    { contract: "CURVE_STETH_GATEWAY" },
    { contract: "LIDO_WSTETH" },
  ],
};

export const wethConfigMainnet: PoolV3DeployConfig = {
  id: "mainnet-weth-v3",
  symbol: "dWETHV3",
  name: "Trade WETH v3",
  network: "Mainnet",
  underlying: "WETH",
  accountAmount: (BigInt(100_000) * POOL_DECIMALS) / POOL_DIVIDER,
  withdrawalFee: 0,
  totalDebtLimit: (BigInt(100_000_000) * POOL_DECIMALS) / POOL_DIVIDER,
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
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    USDC: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    DAI: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    FRAX: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    USDT: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    MKR: {
      minRate: 80,
      maxRate: 2400,
      quotaIncreaseFee: 1,
      limit: BigInt(135) * POOL_DECIMALS,
    },
    UNI: {
      minRate: 80,
      maxRate: 2400,
      quotaIncreaseFee: 1,
      limit: BigInt(135) * POOL_DECIMALS,
    },
    LINK: {
      minRate: 80,
      maxRate: 2400,
      quotaIncreaseFee: 1,
      limit: BigInt(135) * POOL_DECIMALS,
    },
    LDO: {
      minRate: 80,
      maxRate: 2400,
      quotaIncreaseFee: 1,
      limit: BigInt(135) * POOL_DECIMALS,
    },
    CRV: {
      minRate: 240,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: BigInt(55) * POOL_DECIMALS,
    },
    CVX: {
      minRate: 240,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: BigInt(55) * POOL_DECIMALS,
    },
    FXS: {
      minRate: 240,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    APE: {
      minRate: 240,
      maxRate: 4000,
      quotaIncreaseFee: 1,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    yvUSDC: {
      minRate: 1,
      maxRate: 2700,
      quotaIncreaseFee: 1,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    yvWBTC: {
      minRate: 1,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(1e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    sDAI: {
      minRate: 1,
      maxRate: 2700,
      quotaIncreaseFee: 1,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },

    // FARMS
    STETH: {
      minRate: 5,
      maxRate: 350,
      quotaIncreaseFee: 0,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    rETH: {
      minRate: 5,
      maxRate: 316,
      quotaIncreaseFee: 0,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    osETH: {
      minRate: 5,
      maxRate: 316,
      quotaIncreaseFee: 0,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    yvWETH: {
      minRate: 50,
      maxRate: 500,
      quotaIncreaseFee: 0,
      limit: (BigInt(30e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    stkcvxcrvUSDTWBTCWETH: {
      minRate: 100,
      maxRate: 700,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    stkcvxcrvUSDETHCRV: {
      minRate: 100,
      maxRate: 1470,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    auraB_rETH_STABLE_vault: {
      minRate: 100,
      maxRate: 550,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    // LRT
    weETH: {
      minRate: 5,
      maxRate: 3000,
      quotaIncreaseFee: 0,
      limit: BigInt(20000) * POOL_DECIMALS,
    },
    ezETH: {
      minRate: 5,
      maxRate: 3000,
      quotaIncreaseFee: 0,
      limit: BigInt(40000) * POOL_DECIMALS,
    },
    rsETH: {
      minRate: 5,
      maxRate: 3000,
      quotaIncreaseFee: 0,
      limit: BigInt(10000) * POOL_DECIMALS,
    },
    pufETH: {
      minRate: 5,
      maxRate: 3000,
      quotaIncreaseFee: 0,
      limit: BigInt(10000) * POOL_DECIMALS,
    },
    rswETH: {
      minRate: 5,
      maxRate: 3000,
      quotaIncreaseFee: 0,
      limit: BigInt(10000) * POOL_DECIMALS,
    },
  },
  creditManagers: [
    tier1CreditManager,
    tier2CreditManager,
    tier3CreditManager,
    farmCreditManager,
    restakingCreditManager,
  ],
  supportsQuotas: true,
};
