import {
  decimals,
  NOT_DEPLOYED,
  safeEnum,
  SupportedContract,
  SupportedToken,
} from "@gearbox-protocol/sdk";

import { CoreConfigurator } from "..";
import { bnToContractPercentage, bnToContractString } from "../base/convert";
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
  adapters: Array<UpdatedValue<SupportedContract>>;
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
          this.state.adapters
            .map(a => `cs.push(Contracts.${safeEnum(a.value)});`)
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
