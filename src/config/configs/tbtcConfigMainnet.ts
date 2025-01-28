import {
  BalancerVaultConfig,
  GenericSwapConfig,
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

const correlatedUniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "tBTC", token1: "WBTC", fee: 100 },
    { token0: "tBTC", token1: "WBTC", fee: 500 },
    { token0: "WBTC", token1: "pumpBTC", fee: 500 },
    { token0: "WBTC", token1: "LBTC", fee: 500 },
  ],
};
const tradeUniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "tBTC", token1: "WBTC", fee: 100 },
    { token0: "tBTC", token1: "WBTC", fee: 500 },
    { token0: "WBTC", token1: "WETH", fee: 500 },
    { token0: "WBTC", token1: "USDC", fee: 3000 },
  ],
};

const pendleConfig: PendleRouterConfig = {
  contract: "PENDLE_ROUTER",
  allowed: [
    {
      inputToken: "LBTC",
      pendleToken: "PT_LBTC_27MAR2025",
      market: "0x70B70Ac0445C3eF04E314DFdA6caafd825428221",
      status: PendlePairStatus.ALLOWED,
    },
    {
      inputToken: "eBTC",
      pendleToken: "PT_corn_eBTC_27MAR2025",
      market: "0x2C71Ead7ac9AE53D05F8664e77031d4F9ebA064B",
      status: PendlePairStatus.ALLOWED,
    },
  ],
};

const balancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "pumpBTC_WBTC_BPT",
      status: 2,
    },
    {
      pool: "eBTC_WBTC_BPT",
      status: 2,
    },
  ],
};

const correlatedCollateralTokens: CollateralToken[] = [
  {
    token: "eBTC",
    lt: 9000,
  },
  {
    token: "LBTC",
    lt: 9000,
  },
  {
    token: "PT_LBTC_27MAR2025",
    lt: 8500,
  },
  {
    token: "PT_corn_eBTC_27MAR2025",
    lt: 8700,
  },
  {
    token: "pumpBTC",
    lt: 9000,
  },
  // COMPATIBILITY
  { token: "WBTC", lt: 0 },
  { token: "2BTC-f", lt: 0 },
  { token: "TriBTC", lt: 0 },
  { token: "LBTCWBTC", lt: 0 },
  { token: "pumpBTCWBTC", lt: 0 },
  { token: "eBTCWBTC", lt: 0 },
  { token: "pumpBTC_WBTC_BPT", lt: 0 },
  { token: "eBTC_WBTC_BPT", lt: 0 },
];

const tier1CorrelatedCreditManager: CreditManagerV3DeployConfig = {
  name: "tBTC Correlated Tier 1",
  degenNft: false,
  expirationDate: undefined,
  minDebt: BigInt(6) * POOL_DECIMALS,
  maxDebt: BigInt(120) * POOL_DECIMALS,
  feeInterest: 1500,
  feeLiquidation: 0,
  liquidationPremium: 100,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 100,
  poolLimit: BigInt(20e6) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens: correlatedCollateralTokens,
  adapters: [
    correlatedUniV3Config,
    pendleConfig,
    balancerConfig,

    { contract: "CURVE_tBTC_WBTC_POOL" },
    { contract: "CURVE_TRIBTC_POOL" },
    { contract: "CURVE_LBTC_WBTC_POOL" },
    { contract: "CURVE_PUMPBTC_WBTC_POOL" },
    { contract: "CURVE_EBTC_WBTC_POOL" },
  ],
};

const tier2CorrelatedCreditManager: CreditManagerV3DeployConfig = {
  name: "tBTC Correlated Tier 2",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(3) * POOL_DECIMALS) / 10n,
  maxDebt: BigInt(6) * POOL_DECIMALS,
  feeInterest: 1500,
  feeLiquidation: 0,
  liquidationPremium: 300,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 300,
  poolLimit: BigInt(20e6) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens: correlatedCollateralTokens,
  adapters: [
    correlatedUniV3Config,
    pendleConfig,
    balancerConfig,

    { contract: "CURVE_tBTC_WBTC_POOL" },
    { contract: "CURVE_TRIBTC_POOL" },
    { contract: "CURVE_LBTC_WBTC_POOL" },
    { contract: "CURVE_PUMPBTC_WBTC_POOL" },
    { contract: "CURVE_EBTC_WBTC_POOL" },
  ],
};

const tier1TradeCreditManager: CreditManagerV3DeployConfig = {
  name: "Trade tBTC Tier 1",
  degenNft: false,
  expirationDate: undefined,
  minDebt: (BigInt(3) * POOL_DECIMALS) / 10n,
  maxDebt: BigInt(6) * POOL_DECIMALS,
  feeInterest: 1500,
  feeLiquidation: 0,
  liquidationPremium: 400,
  feeLiquidationExpired: 0,
  liquidationPremiumExpired: 400,
  poolLimit: BigInt(20e6) * POOL_DECIMALS,
  maxEnabledTokens: 4,
  collateralTokens: [
    {
      token: "WETH",
      lt: 9000,
    },
    {
      token: "STETH",
      lt: 9000,
    },
    {
      token: "USDC",
      lt: 9000,
    },
    // COMPATIBILITY
    { token: "WBTC", lt: 0 },
    { token: "2BTC-f", lt: 0 },
    { token: "steCRV", lt: 0 },
  ],
  adapters: [
    tradeUniV3Config,
    { contract: "CURVE_tBTC_WBTC_POOL" },
    { contract: "CURVE_STETH_GATEWAY" },
  ],
};

export const tbtcConfigMainnet: PoolV3DeployConfig = {
  id: "mainnet-tbtc-v3",
  symbol: "dtBTCV3",
  name: "Trade tBTC v3",
  network: "Mainnet",
  underlying: "tBTC",
  accountAmount: BigInt(100_000) * POOL_DECIMALS,
  withdrawalFee: 0,
  totalDebtLimit: BigInt(1_000) * POOL_DECIMALS,
  irm: {
    U1: 7000,
    U2: 9000,
    Rbase: 0,
    Rslope1: 100,
    Rslope2: 150,
    Rslope3: 2000,
    isBorrowingMoreU2Forbidden: true,
  },
  ratesAndLimits: {
    eBTC: {
      minRate: 5,
      maxRate: 1000,
      quotaIncreaseFee: 0,
      limit: BigInt(55) * POOL_DECIMALS,
    },
    LBTC: {
      minRate: 5,
      maxRate: 2000,
      quotaIncreaseFee: 0,
      limit: BigInt(190) * POOL_DECIMALS,
    },
    PT_LBTC_27MAR2025: {
      minRate: 5,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(190) * POOL_DECIMALS,
    },
    PT_corn_eBTC_27MAR2025: {
      minRate: 5,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(65) * POOL_DECIMALS,
    },
    pumpBTC: {
      minRate: 5,
      maxRate: 2000,
      quotaIncreaseFee: 0,
      limit: BigInt(60) * POOL_DECIMALS,
    },
    WETH: {
      minRate: 5,
      maxRate: 1200,
      quotaIncreaseFee: 0,
      limit: BigInt(180) * POOL_DECIMALS,
    },
    STETH: {
      minRate: 5,
      maxRate: 1200,
      quotaIncreaseFee: 0,
      limit: BigInt(180) * POOL_DECIMALS,
    },
    USDC: {
      minRate: 5,
      maxRate: 1200,
      quotaIncreaseFee: 0,
      limit: BigInt(180) * POOL_DECIMALS,
    },

    // COMPATIBILITY
    WBTC: {
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
    "2BTC-f": {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    TriBTC: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    LBTCWBTC: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    pumpBTCWBTC: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    eBTCWBTC: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    pumpBTC_WBTC_BPT: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    eBTC_WBTC_BPT: {
      minRate: 1,
      maxRate: 1,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
  },
  creditManagers: [
    tier1CorrelatedCreditManager,
    tier2CorrelatedCreditManager,
    tier1TradeCreditManager,
  ],
  supportsQuotas: true,
};
