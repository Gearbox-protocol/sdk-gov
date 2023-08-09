import { PoolV3CoreConfigurator } from "./poolV3Core";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";

export const config: PoolV3DeployConfig = {
  symbol: "dUSDCV3",
  name: "Diesel USDC V3 pool",
  network: "Mainnet",
  underlying: "USDC",
  withdrawalFee: 0,
  expectedLiquidityLimit: BigInt(0),
  irm: {
    U1: 80_00,
    U2: 90_00,
    Rbase: 0,
    Rslope1: 1_00,
    Rslope2: 10_00,
    Rslope3: 100_00,
    isBorrowingMoreU2Forbidden: true,
  },
  ratesAndLimits: {
    CVX: {
      minRate: 10,
      maxRate: 3_00,
      quotaIncreaseFee: 0,
      limit: BigInt(5000000000000),
    },
    FXS: {
      minRate: 10,
      maxRate: 300,
      quotaIncreaseFee: 0,
      limit: BigInt(5000000000000),
    },
    LQTY: {
      minRate: 10,
      maxRate: 300,
      quotaIncreaseFee: 0,
      limit: BigInt(5000000000000),
    },
  },
  creditManagers: [
    {
      degenNft: false,
      minDebt: BigInt(0),
      maxDebt: BigInt(0),
      poolLimit: BigInt(0),
      collateralTokens: [
        {
          token: "CVX",
          lt: 25_00,
        },
        {
          token: "FXS",
          lt: 20_00,
        },
      ],
      adapters: ["UNISWAP_V3_ROUTER"],
    },
  ],
};

const poolCfg = PoolV3CoreConfigurator.new(config);
console.log(poolCfg.toString());
