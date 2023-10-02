import {
  HumanizeDuration,
  HumanizeDurationLanguage,
} from "humanize-duration-ts";
import { z } from "zod";

import { SupportedToken, tokenSymbolByAddress } from "../tokens/token";
import { percentFmt } from "../utils/formatter";
import { PartialRecord } from "../utils/types";

const ltParamsSchema = z.object({
  ltNow: z.number(),
  ltFinal: z.number(),
  ltInitial: z.number(),
  rampDuration: z.number(),
  timestampRampStart: z.number(),
});

interface LtParamsHuman {
  ltNow: string;
  ltFinal: string;
  ltInitial: string;
  rampDuration: string;
  timestampRampStart: string;
}

const creditManagerV3Schema = z.object({
  address: z.string(),
  name: z.string(),

  ccVersion: z.number(),
  cfVersion: z.number(),
  cmVersion: z.number(),

  creditConfigurator: z.string().length(42),
  creditFacade: z.string().length(42),
  degenNft: z.string().length(42),
  feeInterest: z.number(),
  feeLiquidation: z.number(),
  forbiddenTokenMask: z.coerce.bigint(),
  isDegenMode: z.boolean(),
  liquidationDiscount: z.number(),
  liquidationThresholds: z.record(z.string().length(42), ltParamsSchema),
  minDebt: z.coerce.bigint(),
  maxDebt: z.coerce.bigint(),
  maxEnabledTokensLength: z.number(),
  pool: z.string().length(42),
  underlying: z.string().length(42),
});

type CreditManagerV3Payload = z.infer<typeof creditManagerV3Schema>;

const poolsV1ArraySchema = z.array(creditManagerV3Schema);

export class CreditManagerV3State {
  address: string;
  name: string;
  underlying: SupportedToken;

  ccVersion: number;
  cfVersion: number;
  cmVersion: number;

  creditConfigurator: string;
  creditFacade: string;
  degenNft: string;
  feeInterest: string;
  feeLiquidation: string;
  forbiddenTokenMask: string;
  isDegenMode: boolean;
  liquidationDiscount: string;
  liquidationThresholds: PartialRecord<SupportedToken, LtParamsHuman>;
  minDebt: string;
  maxDebt: string;
  maxEnabledTokensLength: number;
  pool: string;

  constructor(payload: CreditManagerV3Payload) {
    this.address = payload.address;
    this.name = payload.name;

    this.underlying = tokenSymbolByAddress[payload.underlying];

    this.ccVersion = payload.ccVersion;
    this.cfVersion = payload.cfVersion;
    this.cmVersion = payload.cmVersion;

    this.creditConfigurator = payload.creditConfigurator;
    this.creditFacade = payload.creditFacade;
    this.degenNft = payload.degenNft;

    this.feeInterest = percentFmt(payload.feeInterest);
    this.feeLiquidation = percentFmt(payload.feeLiquidation);
    this.forbiddenTokenMask = payload.forbiddenTokenMask.toString();
    this.isDegenMode = payload.isDegenMode;
    this.liquidationDiscount = percentFmt(payload.liquidationDiscount);

    const langService = new HumanizeDurationLanguage();
    const humanizer = new HumanizeDuration(langService);

    this.liquidationThresholds = Object.entries(payload.liquidationThresholds)
      .sort((a, b) => {
        return tokenSymbolByAddress[a[0]] > tokenSymbolByAddress[b[0]] ? 1 : -1;
      })
      .map(([token, ltParams]) => ({
        token: tokenSymbolByAddress[token],
        ltParams: {
          ltNow: percentFmt(ltParams.ltNow),
          ltInitial: percentFmt(ltParams.ltInitial),
          ltFinal: percentFmt(ltParams.ltFinal),

          rampDuration: `${humanizer.humanize(
            ltParams.rampDuration,
          )} [ ${ltParams.rampDuration.toString()}]`,
          timestampRampStart: new Date(ltParams.timestampRampStart * 1000),
        },
      }))
      .reduce(
        (acc, { token, ltParams: liquidationThresholds }) => ({
          ...acc,
          [token]: liquidationThresholds,
        }),
        {},
      );

    this.minDebt = payload.minDebt.toString();
    this.maxDebt = payload.maxDebt.toString();
    this.maxEnabledTokensLength = payload.maxEnabledTokensLength;
    this.pool = payload.pool;
  }

  static fromJson(json: string): Array<CreditManagerV3State> {
    const payload = poolsV1ArraySchema.parse(JSON.parse(json));
    return payload.map(p => new CreditManagerV3State(p));
  }
}
