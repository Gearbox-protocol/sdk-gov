import {
  decimals,
  NOT_DEPLOYED,
  SupportedToken,
  supportedTokens,
} from "@gearbox-protocol/sdk";
import {
  BalancerLPToken,
  BalancerLpTokenData,
} from "@gearbox-protocol/sdk/lib/tokens/balancer";

import { CoreConfigurator, safeEnum } from "..";
import { bnToContractPercentage, bnToContractString } from "../base/convert";
import {
  AdapterConfig,
  BalancerPoolConfig,
  BalancerVaultConfig,
  UniV2Config,
  UniV3Config,
} from "./adapters";
import { IConfigurator, Message, ValidationResult } from "./iConfigurator";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";
import { UpdatedValue } from "./updatedValue";

interface CollateralTokenValue {
  token: SupportedToken;
  lt: UpdatedValue<number>;
}

export interface CreditManagerV3State {
  degenNft: UpdatedValue<boolean>;
  expirable: UpdatedValue<boolean>;
  expiredAt: UpdatedValue<number>;
  minDebt: UpdatedValue<bigint>;
  maxDebt: UpdatedValue<bigint>;
  collateralTokens: Array<CollateralTokenValue>;
  adapters: Array<UpdatedValue<AdapterConfig>>;
  poolLimit: UpdatedValue<bigint>;
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
          this.state.adapters.map(a => this.adapterConfig(a.value)).join("\n");

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

  adapterConfig(a: AdapterConfig): string {
    const contractLine = `cs.push(Contracts.${safeEnum(a.contract)});`;

    switch (a.contract) {
      case "BALANCER_V2_VAULT": {
        const balancerConfig = (a as BalancerVaultConfig).allowed
          .map(
            pool => `
    bp.push(BalancerPool({
      poolId: ${(supportedTokens[pool.pool] as BalancerLpTokenData).poolId},
      status: ${pool.status.toFixed()}}));`,
          )
          .join("\n");
        return `${contractLine}
        BalancerPool[] storage bp = cp.balancerPools;
        ${balancerConfig}`;
      }

      case "UNISWAP_V2_ROUTER":
      case "SUSHISWAP_ROUTER": {
        const pairs = (a as UniV2Config).allowed
          .map(
            pair => `uv2p.push(UniswapV2Pair({
          token0: Tokens.${safeEnum(pair.token0)},
          token1: Tokens.${safeEnum(pair.token1)}
        }));`,
          )
          .join("\n");

        return `${contractLine}{
        UniswapV2Pair[] storage uv2p = cp.uniswapV2Pairs[${a.contract}];
        ${pairs}}`;
      }

      case "UNISWAP_V3_ROUTER": {
        const pairs = (a as UniV3Config).allowed
          .map(
            pair => `uv3p.push(UniswapV2Pair({
          token0: Tokens.${safeEnum(pair.token0)},
          token1: Tokens.${safeEnum(pair.token1)},
          fee: ${pair.fee}"
        }));`,
          )
          .join("\n");

        return `${contractLine}
        UniswapV3Pair[] storage uv3p = cp.uniswapV3Pairs;
        ${pairs}`;
      }
      default:
        return contractLine;
    }
  }
}
