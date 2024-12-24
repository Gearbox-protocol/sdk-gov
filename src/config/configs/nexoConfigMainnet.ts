import {
  AdapterConfig,
  PendlePairStatus,
  PendleRouterConfig,
  UniV3Config,
} from "../adapters";
import {
  CollateralToken,
  CreditManagerV3DeployConfig,
  PoolV3DeployConfig,
} from "../poolV3DeployConfig";

const POOL_DECIMALS = BigInt(1e18);

const uniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [{ token0: "USDe", token1: "USDT", fee: 100 }],
};

const pendleConfig: PendleRouterConfig = {
  contract: "PENDLE_ROUTER",
  allowed: [
    {
      inputToken: "sUSDe",
      pendleToken: "PT_sUSDe_27MAR2025",
      market: "0xcDd26Eb5EB2Ce0f203a84553853667aE69Ca29Ce",
      status: PendlePairStatus.ALLOWED,
    },
  ],
};

const collateralTokens: CollateralToken[] = [
  {
    token: "USDe",
    lt: 9000,
  },
  {
    token: "sUSDe",
    lt: 9000,
  },
  {
    token: "PT_sUSDe_27MAR2025",
    lt: 8600,
  },
  {
    token: "sDAI",
    lt: 9000,
  },
  {
    token: "sUSDS",
    lt: 9000,
  },
  {
    token: "USDC",
    lt: 9000,
  },
  {
    token: "USDS",
    lt: 9000,
  },
  {
    token: "DAI",
    lt: 9000,
  },

  // COMPATIBILITY
  { token: "3Crv", lt: 0 },
  { token: "MtEthena", lt: 0 },
  { token: "USDeUSDC", lt: 0 },
  { token: "USDeDAI", lt: 0 },
];

const adapters: AdapterConfig[] = [
  uniV3Config,
  pendleConfig,
  { contract: "CURVE_3CRV_POOL" },
  { contract: "CURVE_SDAI_SUSDE_POOL" },
  { contract: "CURVE_USDE_USDC_POOL" },
  { contract: "CURVE_USDE_DAI_POOL" },

  { contract: "DAI_USDS" },
  { contract: "STAKED_USDS_VAULT" },
  { contract: "MAKER_DSR_VAULT" },
];

const tierSCreditManager: CreditManagerV3DeployConfig = {
  name: "NEXO USDT stable S",
  degenNft: false,
  expirationDate: undefined,
  minDebt: BigInt(2e4) * POOL_DECIMALS,
  maxDebt: BigInt(4e5) * POOL_DECIMALS,
  feeInterest: 1000,
  feeLiquidation: 0,
  liquidationPremium: 400,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 400,
  poolLimit: BigInt(100e6) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens,
  adapters,
};

const tierMCreditManager: CreditManagerV3DeployConfig = {
  name: "NEXO USDT stable M",
  degenNft: false,
  expirationDate: undefined,
  minDebt: BigInt(4e5) * POOL_DECIMALS,
  maxDebt: BigInt(8e6) * POOL_DECIMALS,
  feeInterest: 1000,
  feeLiquidation: 0,
  liquidationPremium: 300,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 300,
  poolLimit: BigInt(100e6) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens,
  adapters,
};

export const nexoConfigMainnet: PoolV3DeployConfig = {
  id: "mainnet-nexo-v3",
  symbol: "dUSDTV3N",
  name: "Nexo USDT v3 stable",
  network: "Mainnet",
  underlying: "USDT",
  accountAmount: BigInt(100_000) * POOL_DECIMALS,
  withdrawalFee: 0,
  totalDebtLimit: BigInt(1_000_000_000) * POOL_DECIMALS,
  irm: {
    U1: 7000,
    U2: 9000,
    Rbase: 0,
    Rslope1: 200,
    Rslope2: 500,
    Rslope3: 2300,
    isBorrowingMoreU2Forbidden: true,
  },
  ratesAndLimits: {
    USDe: {
      minRate: 5,
      maxRate: 2500,
      quotaIncreaseFee: 0,
      limit: BigInt(30e6) * POOL_DECIMALS,
    },
    sUSDe: {
      minRate: 5,
      maxRate: 2500,
      quotaIncreaseFee: 0,
      limit: BigInt(30e6) * POOL_DECIMALS,
    },
    PT_sUSDe_27MAR2025: {
      minRate: 5,
      maxRate: 2500,
      quotaIncreaseFee: 0,
      limit: BigInt(10e6) * POOL_DECIMALS,
    },
    sDAI: {
      minRate: 5,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(30e6) * POOL_DECIMALS,
    },
    sUSDS: {
      minRate: 5,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(30e6) * POOL_DECIMALS,
    },
    USDC: {
      minRate: 5,
      maxRate: 500,
      quotaIncreaseFee: 0,
      limit: BigInt(100e6) * POOL_DECIMALS,
    },
    USDS: {
      minRate: 5,
      maxRate: 500,
      quotaIncreaseFee: 0,
      limit: BigInt(100e6) * POOL_DECIMALS,
    },
    DAI: {
      minRate: 5,
      maxRate: 500,
      quotaIncreaseFee: 0,
      limit: BigInt(100e6) * POOL_DECIMALS,
    },
    // COMPATIBILITY
    "3Crv": {
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
    USDeUSDC: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    USDeDAI: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
  },
  creditManagers: [tierSCreditManager, tierMCreditManager],
  supportsQuotas: true,
};
