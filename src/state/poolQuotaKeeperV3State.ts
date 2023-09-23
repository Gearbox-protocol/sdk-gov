import { z } from "zod";

import { percentFmt } from "../utils/formatter";

// "poolQuotaKeeper": {
//   "addr": "0x8bd8403e6b63c43c6c9384886ed6d99499e4c13d",
//   "quota_params": {
//     "0x056fd409e1d7a124bd7017459dfea2f387b6d5cd": {
//       "isActive": false,
//       "limit": 10000000000000,
//       "quotaIncreaseFee": 0,
//       "rate": 0,
//       "totalQuoted": 0
//     },
//     "0x06325440d014e39736583c165c2963ba99faf14e": {
//       "isActive": false,
//       "limit": 10000000000000,
//       "quotaIncreaseFee": 0,
//       "rate": 0,
//       "totalQuoted": 0
//     },

export const quotaParamsSchema = z.object({
  isActive: z.boolean(),
  limit: z.coerce.bigint(),
  quotaIncreaseFee: z.number(),
  rate: z.number(),
  totalQuoted: z.coerce.bigint(),
});

export const poolQuotaKeeperV3Schema = z.object({
  address: z.string(),
  quotaParams: z.record(z.string(), quotaParamsSchema),
});

export type PoolQuotaKeeperV3Payload = z.infer<typeof poolQuotaKeeperV3Schema>;

export interface PoolQuotaKeeperV3Human {
  address: string;
  quotaParams: Record<
    string,
    {
      isActive: boolean;
      quotaIncreaseFee: string;
      rate: string;
      limit: string;
      totalQuoted: string;
    }
  >;
}

export function poolQuotaKeeperV3Humanize(
  payload: PoolQuotaKeeperV3Payload,
): PoolQuotaKeeperV3Human {
  return {
    address: payload.address,
    quotaParams: Object.entries(payload.quotaParams).reduce(
      (acc, [addr, quota]) => {
        return {
          ...acc,
          [addr]: {
            isActive: quota.isActive,
            quotaIncreaseFee: percentFmt(quota.quotaIncreaseFee),
            rate: percentFmt(quota.rate),
            limit: quota.limit.toString(),
            totalQuoted: quota.totalQuoted.toString(),
          },
        };
      },
      {},
    ),
  };
}
