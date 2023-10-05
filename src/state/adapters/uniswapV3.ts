import { z } from "zod";

import { fmtContract, getTokenSymbolOrAddress } from "../..";

const uniswapV3Schema = z.object({
  address: z.string(),
  allowedPairs: z.array(
    z.object({
      token0: z.string().length(42),
      token1: z.string().length(42),
      fee: z.number(),
    }),
  ),
});

type UniswapV3Payload = z.infer<typeof uniswapV3Schema>;

export class UniswapV3AdapterState {
  address: string;
  allowedPairs: Array<string>;

  constructor(payload: UniswapV3Payload) {
    this.address = payload.address;
    this.allowedPairs = payload.allowedPairs.map(pair => {
      return `${getTokenSymbolOrAddress(
        pair.token0,
      )} <> ${getTokenSymbolOrAddress(pair.token1)} @ fee: ${pair.fee}`;
    });
  }

  static fromJson(json: string): UniswapV3AdapterState {
    const parsed = uniswapV3Schema.parse(JSON.parse(json));
    return new UniswapV3AdapterState(parsed);
  }
}
