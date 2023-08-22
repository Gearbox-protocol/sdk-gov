import {
  decimals,
  NOT_DEPLOYED,
  safeEnum,
  SupportedContract,
  SupportedToken,
  supportedTokens,
} from "@gearbox-protocol/sdk";
import {
  BalancerLPToken,
  BalancerLpTokenData,
} from "@gearbox-protocol/sdk/lib/tokens/balancer";

import { CoreConfigurator } from "..";
import { bnToContractPercentage, bnToContractString } from "../base/convert";
import { IConfigurator, Message, ValidationResult } from "./iConfigurator";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";
import { UpdatedValue } from "./updatedValue";

interface CollateralTokenValue {
  token: SupportedToken;
  lt: UpdatedValue<number>;
}

interface BalancerPoolConfigValue {
  pool: BalancerLPToken;
  status: UpdatedValue<"NOT_ALLOWED" | "ALLOWED" | "SWAP_ONLY">;
}

interface UniswapV2PairConfigValue {
  token0: SupportedToken;
  token1: SupportedToken;
  whitelisted: UpdatedValue<boolean>;
}

interface UniswapV3PoolConfigValue {
  token0: SupportedToken;
  token1: SupportedToken;
  fee: 100 | 500 | 3000 | 10000;
  whitelisted: UpdatedValue<boolean>;
}

export interface CreditManagerV3State {
  degenNft: UpdatedValue<boolean>;
  expirable: UpdatedValue<boolean>;
  expiredAt: UpdatedValue<number>;
  minDebt: UpdatedValue<bigint>;
  maxDebt: UpdatedValue<bigint>;
  collateralTokens: Array<CollateralTokenValue>;
  adapters: Array<UpdatedValue<SupportedContract>>;
  poolLimit: UpdatedValue<bigint>;
  balancerPools: Array<BalancerPoolConfigValue>;
  uniswapV2Pairs: Array<UniswapV2PairConfigValue>;
  uniswapV3Pools: Array<UniswapV3PoolConfigValue>;
  sushiswapPairs: Array<UniswapV2PairConfigValue>;
}

export class CreditManagerV3Configurator implements IConfigurator {
  core?: CoreConfigurator;
  address: string;
  index?: number;
  underlying: SupportedToken;
  state: CreditManagerV3State;

  static new(
    poolConfig: PoolV3DeployConfig,
    index: number,
  ): CreditManagerV3Configurator {
    const config = poolConfig.creditManagers[index];
    const state: CreditManagerV3State = {
      degenNft: UpdatedValue.new(config.degenNft),
      expirable: UpdatedValue.new(config.expirationDate !== undefined),
      expiredAt: UpdatedValue.new(config.expirationDate ?? 0),
      minDebt: UpdatedValue.new(config.minDebt),
      maxDebt: UpdatedValue.new(config.maxDebt),
      poolLimit: UpdatedValue.new(config.poolLimit),
      collateralTokens: config.collateralTokens.map(t => ({
        token: t.token,
        lt: UpdatedValue.new(t.lt),
      })),
      adapters: config.adapters.map(a => UpdatedValue.new(a)),
      balancerPools: config.balancerPools.map(t => ({
        pool: t.pool,
        status: UpdatedValue.new(t.status),
      })),
      uniswapV2Pairs: config.uniswapV2Pairs.map(t => ({
        token0: t.token0,
        token1: t.token1,
        whitelisted: UpdatedValue.new(t.whitelisted),
      })),
      uniswapV3Pools: config.uniswapV3Pools.map(t => ({
        token0: t.token0,
        token1: t.token1,
        fee: t.fee,
        whitelisted: UpdatedValue.new(t.whitelisted),
      })),
      sushiswapPairs: config.sushiswapPairs.map(t => ({
        token0: t.token0,
        token1: t.token1,
        whitelisted: UpdatedValue.new(t.whitelisted),
      })),
    };

    return new CreditManagerV3Configurator({
      address: `${NOT_DEPLOYED}_${index}`,
      index,
      state,
      underlying: poolConfig.underlying,
    });
  }

  static async attach(
    address: string,
    index: number,
  ): Promise<CreditManagerV3Configurator> {
    const state: CreditManagerV3State = {
      degenNft: UpdatedValue.new(false),
      expirable: UpdatedValue.new(false),
      expiredAt: UpdatedValue.new(0),
      minDebt: UpdatedValue.new(BigInt(0)),
      maxDebt: UpdatedValue.new(BigInt(0)),
      poolLimit: UpdatedValue.new(BigInt(0)),
      collateralTokens: [],
      adapters: [],
      balancerPools: [],
      uniswapV2Pairs: [],
      uniswapV3Pools: [],
      sushiswapPairs: [],
    };

    return new CreditManagerV3Configurator({
      address,
      index,
      state,
      underlying: "DAI",
    });
  }

  private constructor(opts: {
    address: string;
    index?: number;
    underlying: SupportedToken;
    state: CreditManagerV3State;
  }) {
    this.state = opts.state;
    this.underlying = opts.underlying;
    this.address = opts.address;
    this.index = opts.index;
  }

  toString(): string {
    const collateralTokens = this.state.collateralTokens
      .map(
        ct => `{ token: ${ct.token}, lt: ${ct.lt.toString({ decimals: 2 })}}`,
      )
      .join("\n");

    const adapters = this.state.adapters.map(a => a.toString()).join("\n");

    return `CREDIT MANAGER: ${this.address}
degenNft: ${this.state.degenNft.toString()};
minDebt: ${this.state.minDebt.toString({
      decimals: decimals[this.underlying],
    })};
maxDebt: ${this.state.maxDebt.toString({
      decimals: decimals[this.underlying],
    })};
collateralTokens: 
${collateralTokens};
adapters: 
${adapters};`;
  }

  deployConfig(): string {
    const collateralTokens =
      this.state.collateralTokens.length === 0
        ? ""
        : `CollateralTokenHuman[] storage cts = cp.collateralTokens;` +
          this.state.collateralTokens
            .map(
              ct => `
    cts.push(CollateralTokenHuman({token: Tokens.${safeEnum(
      ct.token,
    )}, lt: ${bnToContractPercentage(ct.lt.value)}}));`,
            )
            .join("\n");

    const contracts =
      this.state.adapters.length === 0
        ? ""
        : `Contracts[] storage cs = cp.contracts;` +
          this.state.adapters
            .map(a => `cs.push(Contracts.${safeEnum(a.value)});`)
            .join("\n");

    const balancerPools =
      this.state.balancerPools.length === 0
        ? ""
        : `BalancerPool[] storage bp = cp.balancerPools;` +
          this.state.balancerPools
            .map(
              poolConfig => `bp.push(BalancerPool({
        poolId: ${
          (supportedTokens[poolConfig.pool] as BalancerLpTokenData).poolId
        },
        status: ${
          poolConfig.status.value === "NOT_ALLOWED"
            ? 0
            : poolConfig.status.value === "ALLOWED"
            ? 1
            : 2
        }
      }));`,
            )
            .join("\n");

    const uniswapV2Pairs =
      this.state.uniswapV2Pairs.length === 0
        ? ""
        : `UniswapV2Pair[] storage uv2p = cp.uniswapV2Pairs;` +
          this.state.uniswapV2Pairs
            .map(
              pairConfig => `uv2p.push(UniswapV2Pair({
        token0: Tokens.${pairConfig.token0},
        token1: Tokens.${pairConfig.token1},
        whitelisted: ${pairConfig.whitelisted}
      }));`,
            )
            .join("\n");

    const sushiswapPairs =
      this.state.sushiswapPairs.length === 0
        ? ""
        : `UniswapV2Pair[] storage ssp = cp.sushiswapPairs;` +
          this.state.sushiswapPairs
            .map(
              pairConfig => `ssp.push(UniswapV2Pair({
    token0: Tokens.${pairConfig.token0},
    token1: Tokens.${pairConfig.token1},
    whitelisted: ${pairConfig.whitelisted}
  }));`,
            )
            .join("\n");

    const uniswapV3Pools =
      this.state.uniswapV3Pools.length === 0
        ? ""
        : `UniswapV3Pools[] storage uv3p = cp.uniswapV3Pools;` +
          this.state.uniswapV3Pools
            .map(
              poolConfig => `uv3p.push(UniswapV3Pool({
      token0: Tokens.${poolConfig.token0},
      token1: Tokens.${poolConfig.token1},
      fee: ${poolConfig.fee},
      whitelisted: ${poolConfig.whitelisted}
    }));`,
            )
            .join("\n");

    return `
/// CREDIT_MANAGER_${this.index}
CreditManagerV3DeployParams storage cp = _creditManagers.push();

cp.minDebt = ${bnToContractString(this.state.minDebt.value)};
cp.maxDebt = ${bnToContractString(this.state.maxDebt.value)};
cp.whitelisted = ${this.state.degenNft.value};
cp.expirable = ${this.state.expirable.value};
cp.skipInit = false;
cp.poolLimit = ${bnToContractString(this.state.poolLimit.value)};

${collateralTokens}
${contracts}
${balancerPools}
${uniswapV2Pairs}
${uniswapV3Pools}
${sushiswapPairs}
`;
  }

  addToken(token: SupportedToken, lt: number): void {
    this.state.collateralTokens.push({
      token,
      lt: UpdatedValue.new(lt),
    });
  }

  async validate(): Promise<ValidationResult> {
    const warnings: Array<Message> = [];
    const errors: Array<Message> = [];

    for (const ct of this.state.collateralTokens) {
      // if (priceOracleV23.state.pricefeeds[ct.token] === undefinded) {
      //   errors.push({
      //     message: `Collateral token ${ct.token} is not supported by the price oracle`,
      //   });
      // }
    }

    return { warnings, errors };
  }
}
