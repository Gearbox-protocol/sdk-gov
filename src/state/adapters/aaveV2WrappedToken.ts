import { z } from "zod";

import { fmtBinaryMask, getTokenSymbolOrAddress } from "../../utils/formatter";

const aaveV2WrappedTokenSchema = z.object({
  address: z.string(),
  aToken: z.string().length(42),
  aTokenMask: z.coerce.bigint(),
  underlying: z.string().length(42),
  waTokenMask: z.coerce.bigint(),
  token: z.string().length(42),
  tokenMask: z.coerce.bigint(),
});

type AaveV2WrappedTokenPayload = z.infer<typeof aaveV2WrappedTokenSchema>;

export class AaveV2WrappedTokenAdapterState {
  address: string;
  aToken: string;
  aTokenMask: string;
  underlying: string;
  waTokenMask: string;
  token: string;
  tokenMask: string;

  constructor(payload: AaveV2WrappedTokenPayload) {
    this.address = payload.address;
    this.aToken = getTokenSymbolOrAddress(payload.aToken);
    this.aTokenMask = fmtBinaryMask(payload.aTokenMask);
    this.underlying = getTokenSymbolOrAddress(payload.underlying);
    this.token = getTokenSymbolOrAddress(payload.token);

    this.waTokenMask = fmtBinaryMask(payload.waTokenMask);
    this.tokenMask = fmtBinaryMask(payload.tokenMask);
  }

  static fromJson(json: string): AaveV2WrappedTokenAdapterState {
    const parsed = aaveV2WrappedTokenSchema.parse(JSON.parse(json));
    return new AaveV2WrappedTokenAdapterState(parsed);
  }
}
