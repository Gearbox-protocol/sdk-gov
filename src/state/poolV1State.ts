import { z } from "zod";

import { TREASURY } from "../contracts/utilsContracts";
import { SupportedToken, tokenSymbolByAddress } from "../tokens/token";
import { percentFmt } from "../utils/formatter";
import { PartialRecord } from "../utils/types";
import {
  LinearModel,
  LinearModelHuman,
  linearModelHumanize,
  linearModelSchema,
} from "./linearModel";

//  "addr": "0x24946bcbbd028d5abb62ad9b635eb1b1a67af668",
// "baseInterestRate": 12057585241947195141176470,
// "interestRateModel": {
//   "addr": "0xa0bbc312dfe66a9a2cbf898c20ac34e50806873c",
//   "isBorrowingMoreU2Forbidden": false,
//   "rBase": 0,
//   "rSlope1": 0,
//   "rSlope2": 0,
//   "rSlope3": 0,
//   "u1": 8500,
//   "u2": 0
// },
// "totalDebt": 0,
// "treasury": "0x0000000000000000000000000000000000000000",
// "underlying": "0x6b175474e89094c44da98b954eedeac495271d0f",
// "withdrawFee": 0

const poolV1Schema = z.object({
  address: z.string(),
  symbol: z.string(),
  name: z.string(),
  baseInterestRate: z.coerce.bigint(),
  interestRateModel: linearModelSchema,
  totalBorrowed: z.coerce.bigint(),
  treasury: z.string().length(42),
  underlying: z.string().length(42),
  withdrawFee: z.number(),
  creditManagerAllowances: z.record(
    z.string().length(42),
    z.object({
      canBorrow: z.boolean(),
    }),
  ),
});

type PoolV1Payload = z.infer<typeof poolV1Schema>;

const poolsV1ArraySchema = z.array(poolV1Schema);

export class PoolV1State {
  symbol: string;
  name: string;
  address: string;
  baseInterestRate: string;
  interestRateModel: LinearModelHuman;
  totalBorrowed: string;
  treasury: string;
  underlying: SupportedToken;
  withdrawFee: string;
  creditManagerAllowances: PartialRecord<string, { canBorrow: boolean }> = {};

  constructor(payload: PoolV1Payload) {
    this.address = payload.address;
    this.baseInterestRate = `${(
      Number(payload.baseInterestRate / BigInt(1e23)) / 100
    ).toFixed(2)}% [${payload.baseInterestRate}]`;

    this.interestRateModel = linearModelHumanize(payload.interestRateModel);
    this.underlying =
      tokenSymbolByAddress[payload.underlying] || payload.underlying;

    this.symbol = payload.symbol;
    this.name = payload.name;
    this.totalBorrowed = payload.totalBorrowed.toString();
    this.treasury =
      payload.treasury === TREASURY.Mainnet
        ? `GEARBOX TREASURY: [${payload.treasury}]`
        : payload.treasury;

    this.withdrawFee = percentFmt(payload.withdrawFee);
    this.creditManagerAllowances = payload.creditManagerAllowances;
  }

  static fromJson(json: string): Array<PoolV1State> {
    const parsed = poolsV1ArraySchema.parse(JSON.parse(json));
    return parsed.map(p => new PoolV1State(p));
  }
}
