import { ContractsRegisterConfigurator } from "./contractsRegister";
import { PoolV3CoreConfigurator } from "./poolV3Core";

export class Core {
  pools: Array<PoolV3CoreConfigurator>;
  contractRegister: ContractsRegisterConfigurator;

  static async getGearboxInstance(addressProvider: string): Promise<Core> {
    const contractRegister: ContractsRegisterConfigurator =
      await ContractsRegisterConfigurator.attach(addressProvider);

    const pools = await Promise.all(
      contractRegister.state.pools.map(pool =>
        PoolV3CoreConfigurator.attach(pool.value),
      ),
    );

    return new Core({ contractRegister, pools });
  }
  private constructor(opts: {
    contractRegister: ContractsRegisterConfigurator;
    pools: Array<PoolV3CoreConfigurator>;
  }) {
    this.pools = opts.pools;
    this.contractRegister = opts.contractRegister;
  }
}
