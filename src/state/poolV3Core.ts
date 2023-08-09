import { NetworkType, SupportedToken } from "@gearbox-protocol/sdk";

import { CreditManagerV3Configurator } from "./creditManagerV3Config";
import { GaugeV3Configurator } from "./gaugeV3";
import { LinearIRM } from "./linearIRM";
import { PoolQuotaKeeperV3Configurator } from "./poolQuotaKeeperV3";
import { PoolV3Configurator } from "./poolV3";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";

export class PoolV3CoreConfigurator {
  network: NetworkType;
  underlying: SupportedToken;
  irm: LinearIRM;
  gauge: GaugeV3Configurator;
  poolQuotaKeeper: PoolQuotaKeeperV3Configurator;
  pool: PoolV3Configurator;
  creditManagers: Array<CreditManagerV3Configurator>;

  static new(config: PoolV3DeployConfig): PoolV3CoreConfigurator {
    const network = config.network;
    const underlying = config.underlying;
    const poolQuotaKeeper = PoolQuotaKeeperV3Configurator.new(config);
    const gauge = GaugeV3Configurator.new(config);
    const pool = PoolV3Configurator.new(config);
    const irm = LinearIRM.new(config);
    const creditManagers = config.creditManagers.map(c =>
      CreditManagerV3Configurator.new(c),
    );

    return new PoolV3CoreConfigurator({
      network,
      underlying,
      irm,
      gauge,
      poolQuotaKeeper,
      pool,
      creditManagers,
    });
  }

  static async attach(address: string): Promise<PoolV3CoreConfigurator> {
    const irm = await LinearIRM.attach(address);
    const gauge = await GaugeV3Configurator.attach(address);
    const poolQuotaKeeper = await PoolQuotaKeeperV3Configurator.attach(address);
    const pool = await PoolV3Configurator.attach(address);
    return new PoolV3CoreConfigurator({
      network: "Mainnet",
      underlying: "USDC",
      irm,
      gauge,
      poolQuotaKeeper,
      pool,
      creditManagers: [],
    });
  }

  private constructor(opts: {
    network: NetworkType;
    underlying: SupportedToken;
    irm: LinearIRM;
    gauge: GaugeV3Configurator;
    poolQuotaKeeper: PoolQuotaKeeperV3Configurator;
    pool: PoolV3Configurator;
    creditManagers: Array<CreditManagerV3Configurator>;
  }) {
    this.network = opts.network;
    this.underlying = opts.underlying;
    this.poolQuotaKeeper = opts.poolQuotaKeeper;
    this.gauge = opts.gauge;
    this.pool = opts.pool;
    this.irm = opts.irm;
    this.creditManagers = opts.creditManagers;
  }

  toString(): string {
    return `Pool:  ${this.underlying} on ${this.network}
address: ${this.pool.address}

Pool parameters:
${this.pool.toString()}

Gauge parameters:
${this.gauge.toString()}

Linear IRM parameters:
${this.irm.toString()}

Pool quota keeper parameters:
${this.poolQuotaKeeper.toString()}`;
  }
}
