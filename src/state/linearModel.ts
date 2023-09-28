import { z } from "zod";

import { percentFmt } from "../utils/formatter";

export const linearModelSchema = z.object({
  address: z.string(),
  u1: z.number(),
  u2: z.number(),
  rBase: z.number(),
  rSlope1: z.number(),
  rSlope2: z.number(),
  rSlope3: z.number(),
  isBorrowingMoreU2Forbidden: z.boolean(),
});

export type LinearModel = z.infer<typeof linearModelSchema>;

export interface LinearModelHuman {
  address: string;
  u1: string;
  u2: string;
  rBase: string;
  rSlope1: string;
  rSlope2: string;
  rSlope3: string;
  isBorrowingMoreU2Forbidden: boolean;
}

export function linearModelHumanize(model: LinearModel): LinearModelHuman {
  return {
    address: model.address,
    u1: percentFmt(model.u1),
    u2: percentFmt(model.u2),
    rBase: percentFmt(model.rBase),
    rSlope1: percentFmt(model.rSlope1),
    rSlope2: percentFmt(model.rSlope2),
    rSlope3: percentFmt(model.rSlope3),
    isBorrowingMoreU2Forbidden: model.isBorrowingMoreU2Forbidden,
  };
}
