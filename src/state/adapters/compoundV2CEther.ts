import { z } from "zod";

import { fmtBinaryMask, getTokenSymbolOrAddress } from "../../utils/formatter";

const compoundV2CEtherSchema = z.object({
  address: z.string(),
  ctoken: z.string().length(42),
  underlying: z.string().length(42),
  token: z.string().length(42),
  tokenMask: z.coerce.bigint(),
  cTokenMask: z.coerce.bigint(),
});

type CompoundV2CEtherPayload = z.infer<typeof compoundV2CEtherSchema>;

export class CompoundV2CEtherAdapterState {
  address: string;
  underlying: string;
  token: string;
  tokenMask: string;
  cTokenMask: string;

  constructor(payload: CompoundV2CEtherPayload) {
    this.address = payload.address;
    this.underlying = getTokenSymbolOrAddress(payload.underlying);
    this.token = getTokenSymbolOrAddress(payload.token);
    this.cTokenMask = fmtBinaryMask(payload.cTokenMask);
    this.tokenMask = fmtBinaryMask(payload.tokenMask);
  }

  static fromJson(json: string): CompoundV2CEtherAdapterState {
    const parsed = compoundV2CEtherSchema.parse(JSON.parse(json));
    return new CompoundV2CEtherAdapterState(parsed);
  }
}
