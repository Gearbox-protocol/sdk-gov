import { z } from "zod";

import { fmtBinaryMask, getTokenSymbolOrAddress } from "../../utils/formatter";

const erc4626Schema = z.object({
  address: z.string(),
  asset: z.string().length(42),
  assetMask: z.coerce.bigint(),
  sharesMask: z.coerce.bigint(),
});

type ERC4626Payload = z.infer<typeof erc4626Schema>;

export class ERC4626AdapterState {
  address: string;
  asset: string;
  assetMask: string;
  sharesMask: string;

  constructor(payload: ERC4626Payload) {
    this.address = payload.address;
    this.asset = getTokenSymbolOrAddress(payload.asset);
    this.sharesMask = fmtBinaryMask(payload.sharesMask);
    this.assetMask = fmtBinaryMask(payload.assetMask);
  }

  static fromJson(json: string): ERC4626AdapterState {
    const parsed = erc4626Schema.parse(JSON.parse(json));
    return new ERC4626AdapterState(parsed);
  }
}
