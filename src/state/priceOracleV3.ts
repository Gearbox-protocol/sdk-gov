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

  addPriceFeed(token: SupportedToken, address: string): void {
    if (this.state.priceFeeds[token] === undefined) {
      this.state.priceFeeds[token] = UpdatedValue.new(address);
    } else {
      this.state.priceFeeds[token]!.value = address;
    }
  }

  // priceOracle.add(Token.USDC, "0x000000000")
  // priceOracle.add(Token.USDC, "0xba66FF")
}
