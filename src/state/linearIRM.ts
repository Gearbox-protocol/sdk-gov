import { NOT_DEPLOYED } from "@gearbox-protocol/sdk";

import { IConfigurator, Warning } from "./iConfigurator";
import { PoolV3DeployConfig } from "./poolV3DeployConfig";

export interface LinearIRMParams {
  U1: number;
  U2: number;
  Rbase: number;
  Rslope1: number;
  Rslope2: number;
  Rslope3: number;
  isBorrowingMoreU2Forbidden: boolean;
}

export class LinearIRM implements IConfigurator {
  address: string;
  params: LinearIRMParams;

  static new(config: PoolV3DeployConfig): LinearIRM {
    return new LinearIRM(NOT_DEPLOYED, config.irm);
  }

  static async attach(address: string): Promise<LinearIRM> {
    return new LinearIRM(address, {
      U1: 0,
      U2: 0,
      Rbase: 0,
      Rslope1: 0,
      Rslope2: 0,
      Rslope3: 0,
      isBorrowingMoreU2Forbidden: false,
    });
  }

  private constructor(address: string, params: LinearIRMParams) {
    this.address = address;
    this.params = params;
  }

  validate(): Array<Warning> {
    if (this.address === NOT_DEPLOYED) {
      return [];
    }

    const warnings: Array<Warning> = [];

    if (this.params.U1 < 0) {
      warnings.push({ address: "LinearIRM", message: "U1 < 0" });
    }

    return warnings;
  }
}
