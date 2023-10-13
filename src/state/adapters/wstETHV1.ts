import { z } from "zod";

import { fmtBinaryMask, getTokenSymbolOrAddress } from "../../utils/formatter";

const wstETHV1Schema = z.object({
  address: z.string(),
  stEth: z.string().length(42),
  stEthMask: z.coerce.bigint(),
  wstEthMask: z.coerce.bigint(),
});

type WstETHV1Payload = z.infer<typeof wstETHV1Schema>;

export class WstETHV1AdapterState {
  address: string;
  stEth: string;
  stEthMask: string;
  wsEthMask: string;
  constructor(payload: WstETHV1Payload) {
    this.address = payload.address;
    this.stEth = getTokenSymbolOrAddress(payload.stEth);
    this.stEthMask = fmtBinaryMask(payload.stEthMask);
    this.wsEthMask = fmtBinaryMask(payload.wstEthMask);
  }

  static fromJson(json: string): WstETHV1AdapterState {
    const parsed = wstETHV1Schema.parse(JSON.parse(json));
    return new WstETHV1AdapterState(parsed);
  }
}
