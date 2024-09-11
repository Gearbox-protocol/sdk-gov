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

const tier1UniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDC_e", fee: 500 },
    { token0: "USDC", token1: "WETH", fee: 500 },
    { token0: "WETH", token1: "WBTC", fee: 3000 },
    { token0: "WETH", token1: "WBTC", fee: 500 },
    { token0: "USDC", token1: "USDT", fee: 100 },
    { token0: "wstETH", token1: "WETH", fee: 100 },
    { token0: "USDC", token1: "DAI", fee: 100 },
    { token0: "USDC_e", token1: "DAI", fee: 100 },
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
      pool: "bpt_ethtri",
      status: 2,
    },
    {
      pool: "ECLP_wstETH_WETH",
      status: 2,
    },
  ],
};

const tier1VelodromeConfig: VelodromeV2Config = {
  contract: "VELODROME_V2_ROUTER",
  allowed: [
    {
      token0: "USDC",
      token1: "USDC_e",
      stable: true,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "wstETH",
      token1: "WETH",
      stable: false,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "USDC_e",
      token1: "DAI",
      stable: true,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
  ],
};

const tier1VelodromeCLConfig: VelodromeCLConfig = {
  contract: "VELODROME_CL_ROUTER",
  allowed: [
    {
      token0: "USDC",
      token1: "USDC_e",
      tickSpacing: 1,
    },
    {
      token0: "USDC",
      token1: "WETH",
      tickSpacing: 100,
    },
    {
      token0: "USDC",
      token1: "USDT",
      tickSpacing: 1,
    },
    {
      token0: "USDC",
      token1: "DAI",
      tickSpacing: 1,
    },
  ],
};

const tier1CreditManager: CreditManagerV3DeployConfig = {
  name: "USDC Tier 1 Optimism",
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
      token: "USDC_e",
      lt: 9400,
    },
    {
      token: "DAI",
      lt: 9400,
    },
    {
      token: "USDT",
      lt: 9400,
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
      token: "rETH",
      lt: 8700,
    },
    {
      token: "wstETH",
      lt: 8700,
    },
    { token: "3CRV", lt: 0 },
    { token: "wstETHCRV", lt: 0 },
  ],
  adapters: [
    tier1UniV3Config,
    tier1BalancerConfig,
    tier1VelodromeConfig,
    tier1VelodromeCLConfig,
    { contract: "CURVE_3CRV_POOL_OP" },
    { contract: "CURVE_ETH_WSTETH_GATEWAY_OP" },
  ],
};

const tier2UniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "WETH", token1: "USDC_e", fee: 500 },
    { token0: "USDC", token1: "WETH", fee: 500 },
    { token0: "WETH", token1: "WBTC", fee: 3000 },
    { token0: "WETH", token1: "WBTC", fee: 500 },
    { token0: "WETH", token1: "OP", fee: 3000 },
    { token0: "WETH", token1: "OP", fee: 500 },
    { token0: "USDC", token1: "USDT", fee: 100 },
    { token0: "wstETH", token1: "WETH", fee: 100 },
    { token0: "USDC", token1: "DAI", fee: 100 },
    { token0: "USDC_e", token1: "DAI", fee: 100 },
  ],
};

const tier2VelodromeConfig: VelodromeV2Config = {
  contract: "VELODROME_V2_ROUTER",
  allowed: [
    {
      token0: "USDC",
      token1: "USDC_e",
      stable: true,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "wstETH",
      token1: "WETH",
      stable: false,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
    {
      token0: "USDC_e",
      token1: "DAI",
      stable: true,
      factory: VELODROME_V2_DEFAULT_FACTORY,
    },
  ],
};
const tier2VelodromeCLConfig: VelodromeCLConfig = {
  contract: "VELODROME_CL_ROUTER",
  allowed: [
    {
      token0: "USDC",
      token1: "USDC_e",
      tickSpacing: 1,
    },
    {
      token0: "USDC",
      token1: "WETH",
      tickSpacing: 100,
    },
    {
      token0: "WETH",
      token1: "OP",
      tickSpacing: 200,
    },
    {
      token0: "USDC",
      token1: "OP",
      tickSpacing: 200,
    },
    {
      token0: "USDC",
      token1: "USDT",
      tickSpacing: 1,
    },
    {
      token0: "USDC",
      token1: "DAI",
      tickSpacing: 1,
    },
  ],
};

const tier2BalancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "BPT_rETH_ETH",
      status: 2,
    },
    {
      pool: "bpt_ethtri",
      status: 2,
    },
    {
      pool: "ECLP_wstETH_WETH",
      status: 2,
    },
  ],
};

const tier2CreditManager: CreditManagerV3DeployConfig = {
  name: "USDC Tier 2 Optimism",
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
      token: "USDC_e",
      lt: 9400,
    },
    {
      token: "DAI",
      lt: 9400,
    },
    {
      token: "USDT",
      lt: 9400,
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
      token: "rETH",
      lt: 8700,
    },
    {
      token: "wstETH",
      lt: 8700,
    },
    {
      token: "OP",
      lt: 8000,
    },
    { token: "3CRV", lt: 0 },
    { token: "wstETHCRV", lt: 0 },
  ],
  adapters: [
    tier2UniV3Config,
    tier2BalancerConfig,
    tier2VelodromeConfig,
    tier2VelodromeCLConfig,
    { contract: "CURVE_3CRV_POOL_OP" },
    { contract: "CURVE_ETH_WSTETH_GATEWAY_OP" },
  ],
};

export const usdcConfigOptimism: PoolV3DeployConfig = {
  id: "optimism-usdc-v3",
  symbol: "dUSDCV3",
  name: "Main USDC v3",
  network: "Optimism",
  underlying: "USDC",
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
    USDC_e: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(2e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    DAI: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(1e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    USDT: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(2e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    WETH: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(3e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    WBTC: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: (BigInt(5e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    rETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(7.5e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    wstETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(7.5e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    OP: {
      minRate: 4,
      maxRate: 2400,
      quotaIncreaseFee: 1,
      limit: (BigInt(7.5e5) * POOL_DECIMALS) / POOL_DIVIDER,
    },
  },
  creditManagers: [tier1CreditManager, tier2CreditManager],
  supportsQuotas: true,
};
