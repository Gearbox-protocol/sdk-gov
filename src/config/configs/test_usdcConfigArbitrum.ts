import { UniV3Config } from "../adapters";
import {
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e6);
const POOL_DIVIDER = BigInt(1);

const levUniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [{ token0: "WETH", token1: "ARB", fee: 3000 }],
};

const levCreditManager: CreditManagerV3DeployConfig = {
  name: "Test Credit Manager",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(1e3) * POOL_DECIMALS) / POOL_DIVIDER,
  maxDebt: (BigInt(1e5) * POOL_DECIMALS) / POOL_DIVIDER,
  feeInterest: 2500,
  feeLiquidation: 50,
  liquidationPremium: 100,
  feeLiquidationExpired: 50,
  liquidationPremiumExpired: 100,
  poolLimit: (BigInt(3e6) * POOL_DECIMALS) / POOL_DIVIDER,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "USDT",
      lt: 9000,
    },
    {
      token: "crvUSD",
      lt: 9000,
    },
    // Farms
    {
      token: "cvxcrvUSDT",
      lt: 9000,
    },
    // Compatibility
    {
      token: "crvUSDT",
      lt: 0,
    },
    {
      token: "2CRV",
      lt: 0,
    },
    // Rewards
    {
      token: "CRV",
      lt: 0,
    },
    {
      token: "CVX",
      lt: 0,
    },
    {
      token: "ARB",
      lt: 0,
    },
  ],
  adapters: [
    levUniV3Config,
    {
      contract: "CURVE_2CRV_POOL_ARB",
    },
    {
      contract: "CURVE_CRVUSD_USDT_POOL_ARB",
    },
    {
      contract: "CONVEX_BOOSTER_ARB",
    },
    {
      contract: "CONVEX_CRVUSD_USDT_POOL_ARB",
    },
  ],
};

export const testUsdcConfigArbitrum: PoolV3DeployConfig = {
  id: "arbitrum-usdc-test-v3",
  symbol: "dUSDC-test-V3",
  name: "Test USDC v3",
  network: "Arbitrum",
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
    USDT: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    crvUSD: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    cvxcrvUSDT: {
      minRate: 10,
      maxRate: 1000,
      quotaIncreaseFee: 0,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
  },
  creditManagers: [levCreditManager],
  supportsQuotas: true,
};
