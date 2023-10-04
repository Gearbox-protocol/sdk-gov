import {
  HumanizeDuration,
  HumanizeDurationLanguage,
} from "humanize-duration-ts";
import { z } from "zod";

import { PriceFeedType } from "../oracles/pricefeedType";
import { SupportedToken, tokenSymbolByAddress } from "../tokens/token";
import { PartialRecord } from "../utils/types";

const priceFeedV3Param = z.object({
  address: z.string(),
  extraParams: z.any(),
  decimals: z.number(),
  stalenessPeriod: z.number(),
  skipCheck: z.boolean(),
});

const priceOracleV3Schema = z.object({
  address: z.string(),
  priceFeeds: z.record(z.string(), priceFeedV3Param),
});

interface PriceFeedV3Param {
  address: string;
  extraParams: any;
  decimals: number;
  stalenessPeriod: string;
  skipCheck: boolean;
}

type PriceOracleV3Payload = z.infer<typeof priceOracleV3Schema>;

export class PriceOracleV3State {
  address: string;
  priceFeeds: PartialRecord<SupportedToken, PriceFeedV3Param> = {};

  constructor(payload: PriceOracleV3Payload) {
    this.address = payload.address;

    const langService = new HumanizeDurationLanguage();
    const humanizer = new HumanizeDuration(langService);

    Object.entries(payload.priceFeeds)
      .sort((a, b) => {
        return tokenSymbolByAddress[a[0]] > tokenSymbolByAddress[b[0]] ? 1 : -1;
      })

      .forEach(([token, priceFeed]) => {
        this.priceFeeds[tokenSymbolByAddress[token] || token] = {
          address: priceFeed.address,
          extraParams: priceFeed.extraParams,
          decimals: priceFeed.decimals,
          stalenessPeriod: `${humanizer.humanize(
            priceFeed.stalenessPeriod * 1000,
          )} [${priceFeed.stalenessPeriod}]]`,
          skipCheck: priceFeed.skipCheck,
        };
      });
  }

  static fromJson(json: string): PriceOracleV3State {
    const payload = priceOracleV3Schema.parse(JSON.parse(json));
    return new PriceOracleV3State(payload);
  }
}
