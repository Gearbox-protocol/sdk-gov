import {
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e18);

const tier1CreditManager: CreditManagerV3DeployConfig = {
  name: "crvUSD Tier 1",
  degenNft: false,
  expirationDate: undefined,
  minDebt: BigInt(2e4) * POOL_DECIMALS,
  maxDebt: BigInt(1e6) * POOL_DECIMALS,
  feeInterest: 2500,
  feeLiquidation: 150,
  liquidationPremium: 400,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: BigInt(10e6) * POOL_DECIMALS,
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
    // POINTS FARMING
    {
      token: "USDe",
      lt: 9000,
    },
    {
      token: "sUSDe",
      lt: 9000,
    },
    // FARMS
    {
      token: "sDAI",
      lt: 9000,
    },
    // COMPATIBILITY
    { token: "3Crv", lt: 0 },
    { token: "crvUSDUSDC", lt: 0 },
    { token: "crvUSDUSDT", lt: 0 },
    { token: "USDeUSDC", lt: 0 },
    { token: "USDeDAI", lt: 0 },
    { token: "USDecrvUSD", lt: 0 },
    { token: "MtEthena", lt: 0 },
  ],
  adapters: [
    { contract: "CURVE_3CRV_POOL" },
    { contract: "CURVE_CRVUSD_USDC_POOL" },
    { contract: "CURVE_CRVUSD_USDT_POOL" },
    { contract: "CURVE_USDE_CRVUSD_POOL" },
    { contract: "CURVE_USDE_USDC_POOL" },
    { contract: "CURVE_USDE_DAI_POOL" },
    { contract: "CURVE_SDAI_SUSDE_POOL" },
    { contract: "MAKER_DSR_VAULT" },
    { contract: "STAKED_USDE_VAULT" },
  ],
};

export const crvusdConfigMainnet: PoolV3DeployConfig = {
  id: "mainnet-crvusd-v3",
  symbol: "dcrvUSDV3",
  name: "crvUSD v3",
  network: "Mainnet",
  underlying: "crvUSD",
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
    // TRADEABLE TOKENS

    USDC: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: BigInt(10e6) * POOL_DECIMALS,
    },
    DAI: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: BigInt(10e6) * POOL_DECIMALS,
    },
    USDT: {
      minRate: 4,
      maxRate: 1200,
      quotaIncreaseFee: 1,
      limit: BigInt(10e6) * POOL_DECIMALS,
    },
    // FARMS
    sDAI: {
      minRate: 5,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(10e6) * POOL_DECIMALS,
    },
    // POINTS FARMING
    USDe: {
      minRate: 5,
      maxRate: 5000,
      quotaIncreaseFee: 0,
      limit: BigInt(5e6) * POOL_DECIMALS,
    },
    sUSDe: {
      minRate: 5,
      maxRate: 5000,
      quotaIncreaseFee: 0,
      limit: BigInt(2e6) * POOL_DECIMALS,
    },
  },
  creditManagers: [tier1CreditManager],
  supportsQuotas: true,
};
