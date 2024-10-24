import {
  BalancerVaultConfig,
  GenericSwapConfig,
  MellowVaultConfig,
  PendlePairStatus,
  PendleRouterConfig,
  UniV3Config,
} from "../adapters";
import {
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e18);
const POOL_DIVIDER = BigInt(1);

const levUniV2Config: GenericSwapConfig = {
  contract: "UNISWAP_V2_ROUTER",
  allowed: [{ token0: "SKY", token1: "USDS" }],
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
      token: "USDS",
      lt: 9000,
    },
    {
      token: "stkUSDS",
      lt: 9000,
    },
    {
      token: "SKY",
      lt: 0,
    },
  ],
  adapters: [
    { contract: "DAI_USDS" },
    { contract: "SKY_STAKING_REWARDS" },
    levUniV2Config,
  ],
};

export const testDaiConfigMainnet: PoolV3DeployConfig = {
  id: "mainnet-dai-test-v3",
  symbol: "dDAI-test-V3",
  name: "Test DAI v3",
  network: "Mainnet",
  underlying: "DAI",
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
    USDS: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    stkUSDS: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    SKY: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: BigInt(0),
    },
  },
  creditManagers: [levCreditManager],
  supportsQuotas: true,
};
