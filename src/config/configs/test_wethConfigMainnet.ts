import {
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

const POOL_DECIMALS = BigInt(1e18);

const levBalancerV3Config: BalancerVaultConfig = {
  contract: "BALANCER_V3_ROUTER",
  allowed: [
    {
      pool: "rsETH_WETH",
      status: 2,
    },
    {
      pool: "trenSTETH",
      status: 2,
    },
  ],
};

const levCreditManager: CreditManagerV3DeployConfig = {
  name: "Test Credit Manager",
  degenNft: false,
  expirationDate: undefined,
  minDebt: BigInt(20) * POOL_DECIMALS,
  maxDebt: BigInt(400) * POOL_DECIMALS,
  feeInterest: 2500,
  feeLiquidation: 150,
  liquidationPremium: 400,
  feeLiquidationExpired: 100,
  liquidationPremiumExpired: 200,
  poolLimit: BigInt(5000) * POOL_DECIMALS,
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
      token: "STETH",
      lt: 9000,
    },
    {
      token: "wstETH",
      lt: 9000,
    },
    {
      token: "steakLRT",
      lt: 9000,
    },
    {
      token: "rsETH",
      lt: 9000,
    },
    {
      token: "PT_rsETH_26SEP2024",
      lt: 9000,
    },
    {
      token: "stkcvxsteCRV",
      lt: 9000,
    },
    {
      token: "pufETH",
      lt: 9000,
    },
    {
      token: "zpufETH",
      lt: 9000,
    },
    // Compatibility
    {
      token: "steCRV",
      lt: 0,
    },
  ],
  adapters: [
    levBalancerConfig,
    { contract: "LIDO_WSTETH" },
    { contract: "CURVE_STETH_GATEWAY" },
  ],
};

export const testWethConfigMainnet: PoolV3DeployConfig = {
  id: "mainnet-weth-test-v3",
  symbol: "dWETH-test-V3",
  name: "Test WETH v3",
  network: "Mainnet",
  underlying: "WETH",
  accountAmount: BigInt(50) * POOL_DECIMALS,
  withdrawalFee: 0,
  totalDebtLimit: BigInt(100000) * POOL_DECIMALS,
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
    LDO: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    CRV: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    CVX: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    steCRV: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    cvxsteCRV: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    rsETH_WETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    trenSTETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    Re7LRT: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    rstETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    amphrETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    STETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(4000) * POOL_DECIMALS,
    },
    stkcvxsteCRV: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(4000) * POOL_DECIMALS,
    },
    wstETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(4000) * POOL_DECIMALS,
    },
    steakLRT: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(4000) * POOL_DECIMALS,
    },
    rsETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(4000) * POOL_DECIMALS,
    },
    PT_rsETH_26SEP2024: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(4000) * POOL_DECIMALS,
    },
    USDC: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(4000) * POOL_DECIMALS,
    },
    WBTC: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(4000) * POOL_DECIMALS,
    },
    pufETHwstE: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0) * POOL_DECIMALS,
    },
    pufETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(4000) * POOL_DECIMALS,
    },
    zpufETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(4000) * POOL_DECIMALS,
    },
  },
  creditManagers: [levCreditManager],
  supportsQuotas: true,
};
