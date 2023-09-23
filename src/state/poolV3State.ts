import { z } from "zod";

import { TREASURY } from "../contracts/utilsContracts";
import { SupportedToken, tokenSymbolByAddress } from "../tokens/token";
import { percentFmt } from "../utils/formatter";
import {
  LinearModelHuman,
  linearModelHumanize,
  linearModelSchema,
} from "./linearModel";
import {
  PoolQuotaKeeperV3Human,
  poolQuotaKeeperV3Humanize,
  poolQuotaKeeperV3Schema,
} from "./poolQuotaKeeperV3State";

//   "addr": "0x7c87164ec88d058e504cbc6bf8a9d38edc976901",
// "baseInterestRate": "0x16afd4de942a80f555f49",
// "gauge": "0xb0197be6f8af842e1687974c6ed3f0820468df67",
// "interestRateModel": {
//   "addr": "0x78149c844213a9ccfed6c58fdd4f28dde841ce42",
//   "isBorrowingMoreU2Forbidden": true,
//   "rBase": 0,
//   "rSlope1": 150,
//   "rSlope2": 400,
//   "rSlope3": 10000,
//   "u1": 7000,
//   "u2": 9000
// },

// },
// "totalBorrowed": "0x12a05f2000",
// "totalDebtLimit": "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
// "treasury": "0x7b065fcb0760df0cea8cfd144e08554f3cea73d1",
// "underlying": "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48",
// "withdrawFee": 0

//  "creditManagerLimits": {
//   "0xda01555d2d76818b5b2279d35d5e66addc897595": {
//     "borrowed": "0x0",
//     "limit": "0x9184e72a000"
// }

const poolV3Schema = z.object({
  address: z.string(),
  symbol: z.string(),
  name: z.string(),
  baseInterestRate: z.coerce.bigint(),
  interestRateModel: linearModelSchema,
  poolQuotaKeeper: poolQuotaKeeperV3Schema,
  totalBorrowed: z.coerce.bigint(),
  totalDebtLimit: z.coerce.bigint(),
  treasury: z.string().length(42),
  underlying: z.string().length(42),
  withdrawFee: z.number(),
  creditManagerLimits: z.record(
    z.string().length(42),
    z.object({
      borrowed: z.coerce.bigint(),
      limit: z.coerce.bigint(),
    }),
  ),
});

type PoolV3Payload = z.infer<typeof poolV3Schema>;

const poolsV3ArraySchema = z.array(poolV3Schema);

export class PoolV3State {
  symbol: string;
  name: string;
  address: string;
  baseInterestRate: string;
  interestRateModel: LinearModelHuman;
  poolQuotaKeeper: PoolQuotaKeeperV3Human;
  totalBorrowed: string;
  totalDebtLimit: string;
  treasury: string;
  underlying: SupportedToken;
  withdrawFee: string;
  creditManagerLimits: Record<string, { borrowed: string; limit: string }>;

  constructor(payload: PoolV3Payload) {
    this.address = payload.address;
    this.baseInterestRate = `${(
      Number(payload.baseInterestRate / BigInt(1e23)) / 100
    ).toFixed(2)}% [${payload.baseInterestRate}]`;

    this.interestRateModel = linearModelHumanize(payload.interestRateModel);

    this.poolQuotaKeeper = poolQuotaKeeperV3Humanize(payload.poolQuotaKeeper);

    this.underlying =
      tokenSymbolByAddress[payload.underlying] || payload.underlying;

    this.symbol = payload.symbol;
    this.name = payload.name;
    this.totalBorrowed = payload.totalBorrowed.toString();
    this.totalDebtLimit = payload.totalDebtLimit.toString();
    this.treasury =
      payload.treasury === TREASURY.Mainnet
        ? `GEARBOX TREASURY: [${payload.treasury}]`
        : payload.treasury;

    this.withdrawFee = percentFmt(payload.withdrawFee);
    this.creditManagerLimits = Object.entries(payload.creditManagerLimits)
      .map(([cm, limit]) => ({
        creditManager: cm,
        limit: limit.limit.toString(),
        borrowed: limit.borrowed.toString(),
      }))
      .reduce((acc, cm) => {
        return {
          ...acc,
          [cm.creditManager]: {
            limit: cm.limit,
            borrowed: cm.borrowed,
          },
        };
      }, {});
  }

  static fromJson(json: string): Array<PoolV3State> {
    const payload = poolsV3ArraySchema.parse(JSON.parse(json));
    return payload.map(p => new PoolV3State(p));
  }
}
