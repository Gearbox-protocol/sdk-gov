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

const POOL_DECIMALS = BigInt(1e6);
const POOL_DIVIDER = BigInt(1);

const levUniV3Config: UniV3Config = {
  contract: "UNISWAP_V3_ROUTER",
  allowed: [
    { token0: "USDC", token1: "WETH", fee: 500 },
    { token0: "LDO", token1: "WETH", fee: 3000 },
  ],
};

const levBalancerConfig: BalancerVaultConfig = {
  contract: "BALANCER_VAULT",
  allowed: [
    {
      pool: "rsETH_WETH",
      status: 2,
    },
  ],
};

const levPendleConfig: PendleRouterConfig = {
  contract: "PENDLE_ROUTER",
  allowed: [
    {
      inputToken: "rsETH",
      pendleToken: "PT_rsETH_26SEP2024",
      market: "0x6b4740722e46048874d84306b2877600abcea3ae",
      status: PendlePairStatus.ALLOWED,
    },
  ],
};

const levSteakLRTVaultConfig: MellowVaultConfig = {
  contract: "MELLOW_STEAKHOUSE_VAULT",
  allowed: ["wstETH"],
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
      token: "USDe",
      lt: 9000,
    },
    {
      token: "WETH",
      lt: 9000,
    },
    {
      token: "LDO",
      lt: 8250,
    },
    {
      token: "GHO",
      lt: 9000,
    },
    {
      token: "crvUSD",
      lt: 9000,
    },
    {
      token: "stkcvxGHOcrvUSD",
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
    // Compatibility
    {
      token: "USDeUSDC",
      lt: 0,
    },
    {
      token: "GHOcrvUSD",
      lt: 0,
    },
    {
      token: "cvxGHOcrvUSD",
      lt: 0,
    },
    {
      token: "steCRV",
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
  ],
  adapters: [
    levUniV3Config,
    levPendleConfig,
    levBalancerConfig,
    levSteakLRTVaultConfig,
    { contract: "CURVE_USDE_USDC_POOL" },
    { contract: "CURVE_GHO_CRVUSD_POOL" },
    { contract: "CONVEX_BOOSTER" },
    { contract: "CONVEX_GHO_CRVUSD_POOL" },
    { contract: "LIDO_WSTETH" },
    { contract: "CURVE_STETH_GATEWAY" },
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
    USDe: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    WETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    LDO: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 1,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    USDeUSDC: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: BigInt(0),
    },
    GHO: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    crvUSD: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    GHOcrvUSD: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(0) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    steCRV: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(0) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    cvxGHOcrvUSD: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(0) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    stkcvxGHOcrvUSD: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    CRV: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(0) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    CVX: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(0) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    STETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    wstETH: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
    steakLRT: {
      minRate: 4,
      maxRate: 1500,
      quotaIncreaseFee: 0,
      limit: (BigInt(10e6) * POOL_DECIMALS) / POOL_DIVIDER,
    },
  },
  creditManagers: [levCreditManager],
  supportsQuotas: true,
};
