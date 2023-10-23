import { CHAINS, NetworkType, safeEnum, SupportedToken } from "..";
import { bnToContractString } from "./convert";
import { CreditManagerV3Configurator } from "./creditManagerV3Config";
import { GaugeV3Configurator } from "./gaugeV3";
import { IConfigurator, ValidationResult } from "./iConfigurator";
import { LinearIRM } from "./linearIRM";
import { PoolQuotaKeeperV3Configurator } from "./poolQuotaKeeperV3";
import { PoolV3Configurator } from "./poolV3";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";

export class PoolV3CoreConfigurator implements IConfigurator {
  id: string;
  network: NetworkType;
  underlying: SupportedToken;
  supportsQuotas: boolean;
  irm: LinearIRM;
  accountAmount: bigint;
  gauge: GaugeV3Configurator;
  poolQuotaKeeper: PoolQuotaKeeperV3Configurator;
  pool: PoolV3Configurator;
  creditManagers: Array<CreditManagerV3Configurator>;

  static new(config: PoolV3DeployConfig): PoolV3CoreConfigurator {
    const id = config.id;
    const network = config.network;
    const underlying = config.underlying;
    const supportsQuotas = config.supportsQuotas;
    const accountAmount = config.accountAmount;
    const poolQuotaKeeper = PoolQuotaKeeperV3Configurator.new(config);
    const gauge = GaugeV3Configurator.new(config);
    const pool = PoolV3Configurator.new(config);
    const irm = LinearIRM.new(config);
    const creditManagers = config.creditManagers.map((_, num) =>
      CreditManagerV3Configurator.new(config, num),
    );

    return new PoolV3CoreConfigurator({
      id,
      network,
      underlying,
      supportsQuotas,
      accountAmount,
      irm,
      gauge,
      poolQuotaKeeper,
      pool,
      creditManagers,
    });
  }

  private constructor(opts: {
    id: string;
    network: NetworkType;
    supportsQuotas: boolean;
    underlying: SupportedToken;
    accountAmount: bigint;
    irm: LinearIRM;
    gauge: GaugeV3Configurator;
    poolQuotaKeeper: PoolQuotaKeeperV3Configurator;
    pool: PoolV3Configurator;
    creditManagers: Array<CreditManagerV3Configurator>;
  }) {
    this.id = opts.id;
    this.network = opts.network;
    this.underlying = opts.underlying;
    this.accountAmount = opts.accountAmount;
    this.supportsQuotas = opts.supportsQuotas;
    this.poolQuotaKeeper = opts.poolQuotaKeeper;
    this.gauge = opts.gauge;
    this.pool = opts.pool;
    this.irm = opts.irm;
    this.creditManagers = opts.creditManagers;
  }

  toString(): string {
    const creditManagers = this.creditManagers
      .map(cm => cm.toString())
      .join("\n");

    return `Pool:  ${this.underlying} on ${this.network}
address: ${this.pool.address}

Pool parameters:
${this.pool.toString()}

Gauge parameters:
${this.gauge.toString()}

Linear IRM parameters:
${this.irm.toString()}

Pool quota keeper parameters:
${this.poolQuotaKeeper.toString()}

Credit Managers:
================
${creditManagers}`;
  }

  async validate(): Promise<ValidationResult> {
    const pool = await this.pool.validate();
    const gauge = await this.gauge.validate();
    const irm = await this.irm.validate();
    const poolQuotaKeeper = await this.poolQuotaKeeper.validate();
    const creditManagers = await Promise.all(
      this.creditManagers.map(cm => cm.validate()),
    );

    return {
      warnings: [
        ...pool.warnings,
        ...gauge.warnings,
        ...irm.warnings,
        ...poolQuotaKeeper.warnings,
        ...creditManagers.map(v => v.warnings).flat(),
      ],
      errors: [
        ...pool.errors,
        ...gauge.errors,
        ...irm.errors,
        ...poolQuotaKeeper.errors,
        ...creditManagers.map(v => v.warnings).flat(),
      ],
    };
  }

  deployConfig(): string {
    const creditManagers = this.creditManagers
      .map(
        cm => `{
        ${cm.deployConfig()}
      }`,
      )
      .join("\n");

    return `// SPDX-License-Identifier: UNLICENSED
    // Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
    // (c) Gearbox Holdings, 2022
    pragma solidity ^0.8.17;
    
    import {Tokens} from "@gearbox-protocol/sdk-gov/contracts/Tokens.sol";
    import {Contracts} from "@gearbox-protocol/sdk-gov/contracts/SupportedContracts.sol";
    import {
        LinearIRMV3DeployParams,
        PoolV3DeployParams,
        CreditManagerV3DeployParams,
        GaugeRate,
        PoolQuotaLimit,
        CollateralToken,
        IPoolV3DeployConfig,
        CollateralTokenHuman,
        UniswapV2Pair,
        UniswapV3Pair,
        BalancerPool
    } from "@gearbox-protocol/core-v3/contracts/test/interfaces/ICreditConfig.sol";
    
    contract CONFIG_${this.id
      .replaceAll("-", "_")
      .toUpperCase()} is IPoolV3DeployConfig {
        string public constant id = "${this.id}";
        uint256 public constant chainId = ${CHAINS[this.network]};
        Tokens public constant underlying = Tokens.${safeEnum(this.underlying)};
        bool public constant supportsQuotas = ${this.supportsQuotas};
        uint256 public constant getAccountAmount = ${bnToContractString(
          this.accountAmount,
        )};
    
        // POOL
        ${this.pool.deployConfig()}

        ${this.irm.deployConfig()}
    
        GaugeRate[] _gaugeRates;
        PoolQuotaLimit[] _quotaLimits;
    
        CreditManagerV3DeployParams[] _creditManagers;
    
        constructor() {
            ${this.gauge.deployConfig()}
            ${this.poolQuotaKeeper.deployConfig()}
    
            ${creditManagers}
        }
    
        // GETTERS
    
        function poolParams() external view override returns (PoolV3DeployParams memory) {
            return _poolParams;
        }
    
        function irm() external view override returns (LinearIRMV3DeployParams memory) {
            return _irm;
        }
    
        function gaugeRates() external view override returns (GaugeRate[] memory) {
            return _gaugeRates;
        }
    
        function quotaLimits() external view override returns (PoolQuotaLimit[] memory) {
            return _quotaLimits;
        }
    
        function creditManagers() external view override returns (CreditManagerV3DeployParams[] memory) {
            return _creditManagers;
        }
    }
     `;
  }
}
