import { z } from "zod";

import { fmtBinaryMask, getTokenSymbolOrAddress } from "../../utils/formatter";

const curveV2BaseSchema = z.object({
  address: z.string(),
  lpToken: z.string().length(42),
  lpTokenMask: z.coerce.bigint(),
  metapoolBase: z.string().length(42),
  nCoins: z.number(),
  token: z.string().length(42),
  tokenMasks: z.array(z.coerce.bigint()),
  tokens: z.array(z.string().length(42)),
  underlyingMasks: z.array(z.coerce.bigint()),
  underlyings: z.array(z.string().length(42)),
  use256: z.boolean(),
});

type CurveV2Payload = z.infer<typeof curveV2BaseSchema>;

export class CurveV2AdapterState {
  address: string;
  lpToken: string;
  lpTokenMask: string;
  metapoolBase: string;
  nCoins: number;
  token: string;
  tokenMasks: Array<string>;
  tokens: Array<string>;
  underlyingMasks: Array<string>;
  underlyings: Array<string>;
  use256: boolean;

  constructor(payload: CurveV2Payload) {
    this.address = payload.address;
    this.lpToken = getTokenSymbolOrAddress(payload.lpToken);
    this.lpTokenMask = fmtBinaryMask(payload.lpTokenMask);
    this.metapoolBase = payload.metapoolBase;
    this.nCoins = payload.nCoins;
    this.token = getTokenSymbolOrAddress(payload.token);
    this.tokenMasks = payload.tokenMasks.map(fmtBinaryMask);
    this.tokens = payload.tokens.map(getTokenSymbolOrAddress);
    this.underlyingMasks = payload.underlyingMasks.map(fmtBinaryMask);
    this.underlyings = payload.underlyings.map(getTokenSymbolOrAddress);
    this.use256 = payload.use256;
  }

  static fromJson(json: string): CurveV2AdapterState {
    const parsed = curveV2BaseSchema.parse(JSON.parse(json));
    return new CurveV2AdapterState(parsed);
  }
}
