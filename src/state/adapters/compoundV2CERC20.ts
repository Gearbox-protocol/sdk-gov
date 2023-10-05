import { z } from "zod";

import { fmtBinaryMask, getTokenSymbolOrAddress } from "../../utils/formatter";

const compoundV2CERC20Schema = z.object({
  address: z.string(),
  underlying: z.string().length(42),
  token: z.string().length(42),
  tokenMask: z.coerce.bigint(),
  cTokenMask: z.coerce.bigint(),
});

type CompoundV2CERC20Payload = z.infer<typeof compoundV2CERC20Schema>;

export class CompoundV2CERC20AdapterState {
  address: string;
  underlying: string;
  token: string;
  tokenMask: string;
  cTokenMask: string;

  constructor(payload: CompoundV2CERC20Payload) {
    this.address = payload.address;
    this.underlying = getTokenSymbolOrAddress(payload.underlying);
    this.token = getTokenSymbolOrAddress(payload.token);
    this.cTokenMask = fmtBinaryMask(payload.cTokenMask);
    this.tokenMask = fmtBinaryMask(payload.tokenMask);
  }

  static fromJson(json: string): CompoundV2CERC20AdapterState {
    const parsed = compoundV2CERC20Schema.parse(JSON.parse(json));
    return new CompoundV2CERC20AdapterState(parsed);
  }
}
