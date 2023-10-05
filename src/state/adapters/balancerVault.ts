import { z } from "zod";

const balancerVaultSchema = z.object({
  address: z.string(),
  poolStatus: z.record(z.string(), z.string()),
});

type BalancerVaultPayload = z.infer<typeof balancerVaultSchema>;

export class BalancerVaultAdapterState {
  address: string;
  poolStatus: Record<string, string>;

  constructor(payload: BalancerVaultPayload) {
    this.address = payload.address;
    this.poolStatus = payload.poolStatus;
  }

  static fromJson(json: string): BalancerVaultAdapterState {
    const parsed = balancerVaultSchema.parse(JSON.parse(json));
    return new BalancerVaultAdapterState(parsed);
  }
}
