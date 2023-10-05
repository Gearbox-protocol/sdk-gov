import { z } from "zod";

import { getTokenSymbolOrAddress } from "../../utils/formatter";

const coonvexV1BoosterSchema = z.object({
  address: z.string(),
  pidToPhantomToken: z.record(z.coerce.number(), z.string().length(42)),
});

type ConvexV1BoosterPayload = z.infer<typeof coonvexV1BoosterSchema>;

export class ConvexV1BoosterAdapterState {
  address: string;
  pidToPhantomToken: Record<number, string>;

  constructor(payload: ConvexV1BoosterPayload) {
    this.address = payload.address;
    this.pidToPhantomToken = Object.entries(payload.pidToPhantomToken)
      .map(([pid, phantomToken]) => ({
        pid: Number(pid),
        phantomToken: getTokenSymbolOrAddress(phantomToken),
      }))
      .reduce(
        (acc, { pid, phantomToken }) => ({ ...acc, [pid]: phantomToken }),
        {},
      );
  }

  static fromJson(json: string): ConvexV1BoosterAdapterState {
    const parsed = coonvexV1BoosterSchema.parse(JSON.parse(json));
    return new ConvexV1BoosterAdapterState(parsed);
  }
}
