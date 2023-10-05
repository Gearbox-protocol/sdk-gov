import { z } from "zod";

import {
  fmtBinaryMask,
  fmtTreasury,
  getTokenSymbolOrAddress,
} from "../../utils/formatter";

const lidoV1Schema = z.object({
  address: z.string(),
  steth: z.string().length(42),
  weth: z.string().length(42),
  stethMask: z.coerce.bigint(),
  wethMask: z.coerce.bigint(),
  treasury: z.string().length(42),
});

type LidoV1Payload = z.infer<typeof lidoV1Schema>;

export class LidoV1AdapterState {
  address: string;
  steth: string;
  weth: string;
  stethMask: string;
  wethMask: string;
  treasury: string;

  constructor(payload: LidoV1Payload) {
    this.address = payload.address;
    this.steth = getTokenSymbolOrAddress(payload.steth);
    this.weth = getTokenSymbolOrAddress(payload.weth);
    this.stethMask = fmtBinaryMask(payload.stethMask);
    this.wethMask = fmtBinaryMask(payload.wethMask);
    this.treasury = fmtTreasury(payload.treasury);
  }

  static fromJson(json: string): LidoV1AdapterState {
    const parsed = lidoV1Schema.parse(JSON.parse(json));
    return new LidoV1AdapterState(parsed);
  }
}
