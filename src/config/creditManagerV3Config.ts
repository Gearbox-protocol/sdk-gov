import { NOT_DEPLOYED } from "../core/constants";
import { BalancerLpTokenData } from "../tokens/balancer";
import { decimals } from "../tokens/decimals";
import { SupportedToken, supportedTokens } from "../tokens/token";
import { formatBN } from "../utils/formatter";
import { safeEnum } from "../utils/safeEnum";
import {
  AdapterConfig,
  BalancerVaultConfig,
  UniV2Config,
  UniV3Config,
} from "./adapters";
import { bnToContractPercentage, bnToContractString } from "./convert";
import { IConfigurator, Message, ValidationResult } from "./iConfigurator";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";

interface CollateralTokenValue {
  token: SupportedToken;
  lt: number;
}

export interface CreditManagerV3State {
  degenNft: boolean;
  expirable: boolean;
  expiredAt: number;
  minDebt: bigint;
  maxDebt: bigint;
  collateralTokens: Array<CollateralTokenValue>;
  adapters: Array<AdapterConfig>;
  poolLimit: bigint;
}

export class CreditManagerV3Configurator implements IConfigurator {
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
      degenNft: config.degenNft,
      expirable: config.expirationDate !== undefined,
      expiredAt: config.expirationDate ?? 0,
      minDebt: config.minDebt,
      maxDebt: config.maxDebt,
      poolLimit: config.poolLimit,
      collateralTokens: config.collateralTokens.map(t => ({
        token: t.token,
        lt: t.lt,
      })),
      adapters: config.adapters,
    };

    return new CreditManagerV3Configurator({
      address: `${NOT_DEPLOYED}_${index}`,
      index,
      state,
      underlying: poolConfig.underlying,
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
      .map(ct => `{ token: ${ct.token}, lt: ${ct.lt}}`)
      .join("\n");

    const adapters = this.state.adapters.map(a => a.toString()).join("\n");

    return `CREDIT MANAGER: ${this.address}
degenNft: ${this.state.degenNft.toString()};
minDebt: ${formatBN(this.state.minDebt, decimals[this.underlying])})};
maxDebt: ${formatBN(this.state.maxDebt, decimals[this.underlying])})};
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
    )}, lt: ${bnToContractPercentage(ct.lt)}}));`,
            )
            .join("\n");

    const contracts =
      this.state.adapters.length === 0
        ? ""
        : `Contracts[] storage cs = cp.contracts;` +
          this.state.adapters.map(a => this.adapterConfig(a)).join("\n");

    return `
/// CREDIT_MANAGER_${this.index}
CreditManagerV3DeployParams storage cp = _creditManagers.push();

cp.minDebt = ${bnToContractString(this.state.minDebt)};
cp.maxDebt = ${bnToContractString(this.state.maxDebt)};
cp.whitelisted = ${this.state.degenNft};
cp.expirable = ${this.state.expirable};
cp.skipInit = false;
cp.poolLimit = ${bnToContractString(this.state.poolLimit)};

${collateralTokens}
${contracts}

`;
  }

  addToken(token: SupportedToken, lt: number): void {
    this.state.collateralTokens.push({
      token,
      lt: lt,
    });
  }

  async validate(): Promise<ValidationResult> {
    const warnings: Array<Message> = [];
    const errors: Array<Message> = [];

    // for (const ct of this.state.collateralTokens) {
    //    if (priceOracleV23.state.pricefeeds[ct.token] === undefinded) {
    //      errors.push({
    //        message: `Collateral token ${ct.token} is not supported by the price oracle`,
    //      });
    //    }
    // }

    return { warnings, errors };
  }

  adapterConfig(a: AdapterConfig): string {
    const contractLine = `cs.push(Contracts.${safeEnum(a.contract)});`;

    switch (a.contract) {
      case "BALANCER_VAULT": {
        const balancerConfig = ((a as BalancerVaultConfig).allowed || [])
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
      case "SUSHISWAP_ROUTER":
      case "FRAXSWAP_ROUTER": {
        const pairs = ((a as UniV2Config).allowed || [])
          .map(
            pair => `uv2p.push(UniswapV2Pair({
          router: Contracts.${a.contract},
          token0: Tokens.${safeEnum(pair.token0)},
          token1: Tokens.${safeEnum(pair.token1)}
        }));`,
          )
          .join("\n");

        return `${contractLine}{
        UniswapV2Pair[] storage uv2p = cp.uniswapV2Pairs;
        ${pairs}}`;
      }

      case "UNISWAP_V3_ROUTER": {
        const pairs = ((a as UniV3Config).allowed || [])
          .map(
            pair => `uv3p.push(UniswapV3Pair({
          token0: Tokens.${safeEnum(pair.token0)},
          token1: Tokens.${safeEnum(pair.token1)},
          fee: ${pair.fee}
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
