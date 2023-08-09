import { NOT_DEPLOYED, SupportedToken } from "@gearbox-protocol/sdk";

import { UpdatedValue } from "./updatedValue";

export interface PriceOracleV3State {
  priceFeeds: Partial<Record<SupportedToken, UpdatedValue<string>>>;
}

export class PriceOracleV3Configurator {
  address: string;
  state: PriceOracleV3State;

  static new(): PriceOracleV3Configurator {
    const state: PriceOracleV3State = {
      priceFeeds: {},
    };
    return new PriceOracleV3Configurator(NOT_DEPLOYED, state);
  }

  static async attach(address: string): Promise<PriceOracleV3Configurator> {
    const state: PriceOracleV3State = {
      priceFeeds: {},
    };
    return new PriceOracleV3Configurator(address, state);
  }
  private constructor(address: string, state: PriceOracleV3State) {
    this.address = address;
    this.state = state;
  }
}
