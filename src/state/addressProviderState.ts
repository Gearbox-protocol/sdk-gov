import { z } from "zod";

const apSchema = z.object({
  address: z.string(),
  addresses: z.record(z.string(), z.record(z.string(), z.string())),
});

type AddressProviderV3Payload = z.infer<typeof apSchema>;

export class AddressProviderV3State {
  address: string;
  addresses: Record<string, Record<number, string>>;

  constructor(payload: AddressProviderV3Payload) {
    this.address = payload.address;
    this.addresses = payload.addresses;
  }

  static fromJson(json: string): AddressProviderV3State {
    const payload = apSchema.parse(JSON.parse(json));
    return new AddressProviderV3State(payload);
  }
}
