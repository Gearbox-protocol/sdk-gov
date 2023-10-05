import { z } from "zod";

import { getTokenSymbolOrAddress } from "../..";

const uniswapV2Schema = z.object({
  address: z.string(),
  allowedPairs: z.array(
    z.object({
      token0: z.string().length(42),
      token1: z.string().length(42),
    }),
  ),
});

type UniswapV2Payload = z.infer<typeof uniswapV2Schema>;

export class UniswapV2AdapterState {
  address: string;
  allowedPairs: Array<string>;

  constructor(payload: UniswapV2Payload) {
    this.address = payload.address;
    this.allowedPairs = payload.allowedPairs.map(pair => {
      return `${getTokenSymbolOrAddress(
        pair.token0,
      )} <> ${getTokenSymbolOrAddress(pair.token1)}`;
    });
  }

  static fromJson(json: string): UniswapV2AdapterState {
    const parsed = uniswapV2Schema.parse(JSON.parse(json));
    return new UniswapV2AdapterState(parsed);
  }
}
