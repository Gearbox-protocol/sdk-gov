import { z } from "zod";

const coonvexV1BoosterSchema = z.object({
  address: z.string(),
  pidToPhantomToken: z.record(z.number(), z.string().length(42)),
});

type ConvexV1BoosterPayload = z.infer<typeof coonvexV1BoosterSchema>;

export class ConvexV1BoosterAdapterState {
  address: string;
  pidToPhantomToken: Record<number, string>;

  constructor(payload: ConvexV1BoosterPayload) {
    this.address = payload.address;
    this.pidToPhantomToken = payload.pidToPhantomToken;
  }

  static fromJson(json: string): ConvexV1BoosterAdapterState {
    console.error(json);
    const parsed = coonvexV1BoosterSchema.parse(JSON.parse(json));
    return new ConvexV1BoosterAdapterState(parsed);
  }
}
