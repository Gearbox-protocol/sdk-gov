import { NOT_DEPLOYED } from "../core/constants";
import { BalancerLpTokenData } from "../tokens/balancer";
import { decimals } from "../tokens/decimals";
import { SupportedToken, supportedTokens } from "../tokens/token";
import { formatBN, formatNumberToString_ } from "../utils/formatter";
import { safeEnum } from "../utils/safeEnum";
import {
  AdapterConfig,
  BalancerVaultConfig,
  GenericSwapConfig,
  MellowVaultConfig,
  PendleRouterConfig,
  UniswapV3Pair,
  UniV3Config,
  VelodromeCLConfig,
  VelodromeCLPool,
  VelodromeV2Config,
} from "./adapters";
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
  feeInterest: number;
  feeLiquidation: number;
  liquidationPremium: number;
  feeLiquidationExpired: number;
  liquidationPremiumExpired: number;
  collateralTokens: Array<CollateralTokenValue>;
  adapters: Array<AdapterConfig>;
  poolLimit: bigint;
  maxEnabledTokens: number;
  name: string;
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
      feeInterest: config.feeInterest,
      feeLiquidation: config.feeLiquidation,
      liquidationPremium: config.liquidationPremium,
      feeLiquidationExpired: config.feeLiquidationExpired,
      liquidationPremiumExpired: config.liquidationPremiumExpired,
      poolLimit: config.poolLimit,
      collateralTokens: config.collateralTokens.map(t => ({
        token: t.token,
        lt: t.lt,
      })),
      adapters: config.adapters,
      maxEnabledTokens: config.maxEnabledTokens,
      name: config.name,
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
feeInterest: ${this.state.feeInterest};
feeLiquidation: ${this.state.feeLiquidation};
liquidationPremium: ${this.state.liquidationPremium};
feeLiquidationExpired: ${this.state.feeLiquidationExpired};
liquidationPremiumExpired: ${this.state.liquidationPremiumExpired};
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
    cts.push(CollateralTokenHuman({token: TOKEN_${safeEnum(
      ct.token,
    )}, lt: ${formatNumberToString_(ct.lt)}}));`,
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

cp.minDebt = ${formatNumberToString_(this.state.minDebt)};
cp.maxDebt = ${formatNumberToString_(this.state.maxDebt)};
cp.feeInterest = ${this.state.feeInterest};
cp.feeLiquidation = ${this.state.feeLiquidation};
cp.liquidationPremium = ${this.state.liquidationPremium};
cp.feeLiquidationExpired = ${this.state.feeLiquidationExpired};
cp.liquidationPremiumExpired = ${this.state.liquidationPremiumExpired};
cp.whitelisted = ${this.state.degenNft};
cp.expirable = ${this.state.expirable};
cp.skipInit = false;
cp.poolLimit = ${formatNumberToString_(this.state.poolLimit)};
cp.maxEnabledTokens = ${this.state.maxEnabledTokens};
cp.name = "${this.state.name}";

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
        BalancerPool[] storage bp = cp.adapterConfig.balancerPools;
        ${balancerConfig}`;
      }

      case "UNISWAP_V2_ROUTER":
      case "SUSHISWAP_ROUTER":
      case "FRAXSWAP_ROUTER":
      case "CAMELOT_V3_ROUTER": {
        const pairs = ((a as GenericSwapConfig).allowed || [])
          .map(
            pair => `gsp.push(GenericSwapPair({
          router: Contracts.${a.contract},
          token0: TOKEN_${safeEnum(pair.token0)},
          token1: TOKEN_${safeEnum(pair.token1)}
        }));`,
          )
          .join("\n");

        return `${contractLine}{
        GenericSwapPair[] storage gsp = cp.adapterConfig.genericSwapPairs;
        ${pairs}}`;
      }

      case "UNISWAP_V3_ROUTER":
      case "PANCAKESWAP_V3_ROUTER":
      case "VELODROME_CL_ROUTER": {
        const pairs = ((a as UniV3Config | VelodromeCLConfig).allowed || [])
          .map(
            pair => `uv3p.push(UniswapV3Pair({
          router: Contracts.${a.contract},
          token0: TOKEN_${safeEnum(pair.token0)},
          token1: TOKEN_${safeEnum(pair.token1)},
          fee: ${
            a.contract === "VELODROME_CL_ROUTER"
              ? (pair as VelodromeCLPool).tickSpacing
              : (pair as UniswapV3Pair).fee
          }
        }));`,
          )
          .join("\n");

        return `${contractLine}{
        UniswapV3Pair[] storage uv3p = cp.adapterConfig.uniswapV3Pairs;
        ${pairs}}`;
      }
      case "VELODROME_V2_ROUTER": {
        const pools = ((a as VelodromeV2Config).allowed || [])
          .map(
            pool => `vv2p.push(VelodromeV2Pool({
            token0: TOKEN_${safeEnum(pool.token0)},
            token1: TOKEN_${safeEnum(pool.token1)},
            stable: ${pool.stable},
            factory: ${pool.factory}
          }));`,
          )
          .join("\n");

        return `${contractLine}
          VelodromeV2Pool[] storage vv2p = cp.adapterConfig.velodromeV2Pools;
          ${pools}`;
      }
      case "PENDLE_ROUTER": {
        const pairs = ((a as PendleRouterConfig).allowed || [])
          .map(
            pair => `pendp.push(PendlePair({
          market: ${pair.market},
          inputToken: TOKEN_${safeEnum(pair.inputToken)},
          pendleToken: TOKEN_${safeEnum(pair.pendleToken)},
          status: ${pair.status.toFixed()}
        }));`,
          )
          .join("\n");

        return `${contractLine}
        PendlePair[] storage pendp = cp.adapterConfig.pendlePairs;
        ${pairs}`;
      }

      case "MELLOW_STEAKHOUSE_VAULT": {
        const underlyings = ((a as MellowVaultConfig).allowed || [])
          .map(
            underlying => `mu.push(MellowUnderlyingConfig({
          vault: Contracts.${a.contract},
          underlying: TOKEN_${safeEnum(underlying)}
        }));`,
          )
          .join("\n");

        return `${contractLine}{
        MellowUnderlyingConfig[] storage mu = cp.adapterConfig.mellowUnderlyings;
        ${underlyings}}`;
      }

      default:
        return contractLine;
    }
  }
}
