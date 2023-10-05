import { z } from "zod";

import { fmtBinaryMask, getTokenSymbolOrAddress } from "../../utils/formatter";

const coonvexV1BaseRewardPoolSchema = z.object({
  address: z.string(),
  curveLpToken: z.string().length(42),
  stakingToken: z.string().length(42),
  stakedPhantomToken: z.string().length(42),
  curveLpTokenMask: z.coerce.bigint(),
  stakedTokenMask: z.coerce.bigint(),
  rewardTokensMask: z.coerce.bigint(),
});

type ConvexV1BaseRewardPoolPayload = z.infer<
  typeof coonvexV1BaseRewardPoolSchema
>;

export class ConvexV1BaseRewardPoolAdapterState {
  address: string;
  curveLpToken: string;
  stakingToken: string;
  stakedPhantomToken: string;
  curveLpTokenMask: string;
  stakedTokenMask: string;
  rewardTokensMask: string;

  constructor(payload: ConvexV1BaseRewardPoolPayload) {
    this.address = payload.address;
    this.curveLpToken = getTokenSymbolOrAddress(payload.curveLpToken);
    this.stakingToken = getTokenSymbolOrAddress(payload.stakingToken);
    this.stakedPhantomToken = getTokenSymbolOrAddress(
      payload.stakedPhantomToken,
    );
    this.curveLpTokenMask = fmtBinaryMask(payload.curveLpTokenMask);
    this.stakedTokenMask = fmtBinaryMask(payload.stakedTokenMask);
    this.rewardTokensMask = fmtBinaryMask(payload.rewardTokensMask);
  }

  static fromJson(json: string): ConvexV1BaseRewardPoolAdapterState {
    const parsed = coonvexV1BaseRewardPoolSchema.parse(JSON.parse(json));
    return new ConvexV1BaseRewardPoolAdapterState(parsed);
  }
}
