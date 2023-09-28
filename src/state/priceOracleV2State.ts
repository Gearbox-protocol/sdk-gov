import { z } from "zod";

import { SupportedToken, tokenSymbolByAddress } from "../tokens/token";
import { PartialRecord } from "../utils/types";

const priceOracleV2Schema = z.object({
  address: z.string(),
  priceFeeds: z.record(z.string(), z.string()),
});

type PriceOracleV2Payload = z.infer<typeof priceOracleV2Schema>;

export class PriceOracleV2State {
  address: string;
  priceFeeds: PartialRecord<SupportedToken, string> = {};

  constructor(payload: PriceOracleV2Payload) {
    this.address = payload.address;
    Object.entries(payload.priceFeeds)
      .sort((a, b) => {
        return tokenSymbolByAddress[a[0]] > tokenSymbolByAddress[b[0]] ? 1 : -1;
      })

      .forEach(([token, priceFeed]) => {
        this.priceFeeds[tokenSymbolByAddress[token] || token] = priceFeed;
      });
  }

  static fromJson(json: string): PriceOracleV2State {
    const payload = priceOracleV2Schema.parse(JSON.parse(json));
    return new PriceOracleV2State(payload);
  }
}
