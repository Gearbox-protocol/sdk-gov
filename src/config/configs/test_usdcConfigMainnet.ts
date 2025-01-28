import {
  BalancerPoolStatus,
  BalancerVaultConfig,
  MellowVaultConfig,
  PendlePairStatus,
  PendleRouterConfig,
  UniV3Config,
} from "../adapters";
import {
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e6);
const POOL_DIVIDER = BigInt(1);

const levUniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "USDC", token1: "WETH", fee: 500 },
    { token0: "USDT", token1: "WETH", fee: 3000 },
    { token0: "WETH", token1: "WBTC", fee: 3000 },
    { token0: "USDe", token1: "USDT", fee: 100 },
  ],
};

const levBalancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    { pool: "GHO_USDT_USDC", status: BalancerPoolStatus.ALLOWED },
    { pool: "B_50WBTC_50WETH", status: BalancerPoolStatus.ALLOWED },
  ],
};

const levPendleConfig: PendleRouterConfig = {
  contract: "PENDLE_ROUTER",
  allowed: [
    {
      market: "0xcDd26Eb5EB2Ce0f203a84553853667aE69Ca29Ce",
      inputToken: "sUSDe",
      pendleToken: "PT_sUSDe_27MAR2025",
      status: PendlePairStatus.ALLOWED,
    },
  ],
};

const levCreditManager: CreditManagerV3DeployConfig = {
  name: "Test Credit Manager",
  degenNft: false,
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
      token: "DAI",
      lt: 9000,
    },
    {
      token: "WETH",
      lt: 9000,
    },
    {
      token: "USDT",
      lt: 9000,
    },
    {
      token: "WBTC",
      lt: 9000,
    },
    {
      token: "USDe",
      lt: 9000,
    },
    {
      token: "GHO",
      lt: 9000,
    },
    {
      token: "sDAI",
      lt: 9000,
    },
    {
      token: "sUSDe",
      lt: 9000,
    },
    {
      token: "PT_sUSDe_27MAR2025",
      lt: 9000,
    },
    {
      token: "3Crv",
      lt: 0,
    },
    {
      token: "MtEthena",
      lt: 0,
    },
    {
      token: "cvx3Crv",
      lt: 0,
    },
    {
      token: "stkcvx3Crv",
      lt: 0,
    },
    {
      token: "CRV",
      lt: 0,
    },
    {
      token: "CVX",
      lt: 0,
    },
    {
      token: "GHO_USDT_USDC",
      lt: 0,
    },
    {
      token: "B_50WBTC_50WETH",
      lt: 0,
    },
  ],
  adapters: [
    levUniV3Config,
    levPendleConfig,
    levBalancerConfig,
    { contract: "CURVE_3CRV_POOL" },
    { contract: "CURVE_SDAI_SUSDE_POOL" },
    { contract: "CONVEX_BOOSTER" },
    { contract: "CONVEX_3CRV_POOL" },
    { contract: "STAKED_USDE_VAULT" },
    { contract: "MAKER_DSR_VAULT" },
  ],
};

export const testUsdcConfigMainnet: PoolV3DeployConfig = {
  id: "mainnet-usdc-test-v3",
  symbol: "dUSDC-test-V3",
  name: "Test USDC v3",
  network: "Mainnet",
  underlying: "USDC",
  accountAmount: BigInt(100_000) * POOL_DECIMALS,
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
    WETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    USDT: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    DAI: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    GHO: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    WBTC: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    USDe: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    sDAI: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    sUSDe: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    PT_sUSDe_27MAR2025: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    "3Crv": {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    MtEthena: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    cvx3Crv: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    stkcvx3Crv: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    CRV: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    CVX: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    GHO_USDT_USDC: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    B_50WBTC_50WETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
  },
  creditManagers: [levCreditManager],
  supportsQuotas: true,
};
