import { SupportedContract } from "@gearbox-protocol/sdk";

import {
  CollateralToken,
  CreditManagerV3DeployConfig,
} from "./poolV3DeployConfig";
import { UpdatedValue } from "./updatedValue";

export interface CreditManagerV3State {
  degenNft: UpdatedValue<boolean>;
  minDebt: UpdatedValue<bigint>;
  maxDebt: UpdatedValue<bigint>;
  collateralTokens: Array<UpdatedValue<CollateralToken>>;
  adapters: Array<UpdatedValue<SupportedContract>>;
}

export class CreditManagerV3Configurator {
  state: CreditManagerV3State;

  static new(config: CreditManagerV3DeployConfig): CreditManagerV3Configurator {
    const state: CreditManagerV3State = {
      degenNft: UpdatedValue.new(config.degenNft),
      minDebt: UpdatedValue.new(config.minDebt),
      maxDebt: UpdatedValue.new(config.maxDebt),
      collateralTokens: config.collateralTokens.map(t => UpdatedValue.new(t)),
      adapters: config.adapters.map(a => UpdatedValue.new(a)),
    };

    return new CreditManagerV3Configurator(state);
  }

  private constructor(state: CreditManagerV3State) {
    this.state = state;
  }
}
