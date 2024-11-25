import {
  GenericSwapConfig,
  PendlePairStatus,
  PendleRouterConfig,
  UniV3Config,
} from "../adapters";
import {
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e18);

const tier1UniV2Config: GenericSwapConfig = {
  contract: "UNISWAP_V2_ROUTER",
  allowed: [{ token0: "SKY", token1: "USDS" }],
};

const tier1UniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "DAI", token1: "USDC", fee: 100 },
    { token0: "USDC", token1: "WETH", fee: 500 },
    { token0: "WBTC", token1: "WETH", fee: 500 },
    { token0: "WBTC", token1: "USDC", fee: 500 },
    { token0: "SKY", token1: "WETH", fee: 3000 },
  ],
};

const tier1PendleConfig: PendleRouterConfig = {
  contract: "PENDLE_ROUTER",
  allowed: [
    {
      inputToken: "sUSDe",
      pendleToken: "PT_sUSDe_26DEC2024",
      market: "0xa0ab94DeBB3cC9A7eA77f3205ba4AB23276feD08",
      status: PendlePairStatus.ALLOWED,
    },
  ],
};

const tier1CreditManager: CreditManagerV3DeployConfig = {
  name: "Trade DOLA Tier 1",
  degenNft: false,
  expirationDate: undefined,
  minDebt: BigInt(2e4) * POOL_DECIMALS,
  maxDebt: BigInt(4e5) * POOL_DECIMALS,
  feeInterest: 2500,
  feeLiquidation: 150,
  liquidationPremium: 400,
  feeLiquidationExpired: 150,
  liquidationPremiumExpired: 400,
  poolLimit: BigInt(20e6) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "USDe",
      lt: 9000,
    },
    {
      token: "sUSDe",
      lt: 9000,
    },
    {
      token: "sDAI",
      lt: 9000,
    },
    {
      token: "USDS",
      lt: 9000,
    },
    {
      token: "sUSDS",
      lt: 9000,
    },
    {
      token: "stkUSDS",
      lt: 9000,
    },
    {
      token: "PT_sUSDe_26DEC2024",
      lt: 9000,
    },
    {
      token: "WETH",
      lt: 9000,
    },
    {
      token: "STETH",
      lt: 9000,
    },
    {
      token: "WBTC",
      lt: 9000,
    },

    // COMPATIBILITY
    { token: "USDC", lt: 0 },
    { token: "USDT", lt: 0 },
    { token: "DAI", lt: 0 },
    { token: "SKY", lt: 0 },
    { token: "crvUSD", lt: 0 },
    { token: "FRAX", lt: 0 },
    { token: "3Crv", lt: 0 },
    { token: "crvFRAX", lt: 0 },
    { token: "FRAXUSDe", lt: 0 },
    { token: "USDeUSDC", lt: 0 },
    { token: "MtEthena", lt: 0 },
    { token: "USDecrvUSD", lt: 0 },
    { token: "FRAXsDAI", lt: 0 },
    { token: "steCRV", lt: 0 },
    { token: "DOLAFRAXBP3CRV_f", lt: 0 },
    { token: "crvUSDDOLA_f", lt: 0 },
  ],
  adapters: [
    tier1UniV2Config,
    tier1UniV3Config,
    tier1PendleConfig,

    { contract: "CURVE_3CRV_POOL" },
    { contract: "CURVE_FRAX_USDE_POOL" },
    { contract: "CURVE_USDE_USDC_POOL" },
    { contract: "CURVE_SDAI_SUSDE_POOL" },
    { contract: "CURVE_USDE_CRVUSD_POOL" },
    { contract: "CURVE_FRAX_SDAI_POOL" },
    { contract: "CURVE_STETH_GATEWAY" },
    { contract: "CURVE_DOLA_FRAXBP_POOL" },
    { contract: "CURVE_DOLA_CRVUSD_POOL" },

    { contract: "DAI_USDS" },
    { contract: "STAKED_USDS_VAULT" },
    { contract: "MAKER_DSR_VAULT" },
    { contract: "SKY_STAKING_REWARDS" },
  ],
};

export const dolaConfigMainnet: PoolV3DeployConfig = {
  id: "mainnet-dola-v3",
  symbol: "dDOLAV3",
  name: "Trade DOLA v3",
  network: "Mainnet",
  underlying: "DOLA",
  accountAmount: BigInt(100_000) * POOL_DECIMALS,
  withdrawalFee: 0,
  totalDebtLimit: BigInt(100_000_000) * POOL_DECIMALS,
  irm: {
    U1: 7000,
    U2: 9000,
    Rbase: 250,
    Rslope1: 0,
    Rslope2: 0,
    Rslope3: 0,
    isBorrowingMoreU2Forbidden: true,
  },
  ratesAndLimits: {
    WETH: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 0,
      limit: BigInt(7e6) * POOL_DECIMALS,
    },
    STETH: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 0,
      limit: BigInt(3.5e6) * POOL_DECIMALS,
    },
    WBTC: {
      minRate: 4,
      maxRate: 4000,
      quotaIncreaseFee: 0,
      limit: BigInt(7e6) * POOL_DECIMALS,
    },

    USDe: {
      minRate: 5,
      maxRate: 2500,
      quotaIncreaseFee: 0,
      limit: BigInt(8e6) * POOL_DECIMALS,
    },
    sUSDe: {
      minRate: 5,
      maxRate: 2500,
      quotaIncreaseFee: 0,
      limit: BigInt(7e6) * POOL_DECIMALS,
    },
    sDAI: {
      minRate: 50,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(7e6) * POOL_DECIMALS,
    },
    USDS: {
      minRate: 5,
      maxRate: 2500,
      quotaIncreaseFee: 0,
      limit: BigInt(7.5e6) * POOL_DECIMALS,
    },
    sUSDS: {
      minRate: 5,
      maxRate: 2500,
      quotaIncreaseFee: 0,
      limit: BigInt(4.5e6) * POOL_DECIMALS,
    },
    stkUSDS: {
      minRate: 5,
      maxRate: 2500,
      quotaIncreaseFee: 0,
      limit: BigInt(4.5e6) * POOL_DECIMALS,
    },
    PT_sUSDe_26DEC2024: {
      minRate: 5,
      maxRate: 2500,
      quotaIncreaseFee: 0,
      limit: BigInt(3e6) * POOL_DECIMALS,
    },

    // COMPATIBILITY
    USDC: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    USDT: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    DAI: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    SKY: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    crvUSD: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    FRAX: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    "3Crv": {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    FRAXUSDe: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    USDeUSDC: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    MtEthena: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    USDecrvUSD: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    FRAXsDAI: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    steCRV: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    DOLAFRAXBP3CRV_f: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    crvUSDDOLA_f: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    crvFRAX: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
  },
  creditManagers: [tier1CreditManager],
  supportsQuotas: true,
};
