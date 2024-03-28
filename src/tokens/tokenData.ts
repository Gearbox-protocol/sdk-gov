import { NetworkType } from "../core/chains";
import { NOT_DEPLOYED } from "../core/constants";
import { Address } from "../utils/types";
import { SupportedToken, tokenDataByNetwork } from "./token";

export const connectors: Record<NetworkType, Array<SupportedToken>> = {
  Mainnet: ["WETH", "DAI", "USDC", "FRAX", "rETH", "ezETH", "GHO"],
  Arbitrum: ["WETH", "DAI", "USDC", "USDT", "rETH"],
  Optimism: ["WETH", "USDC", "USDT"],
  Base: ["WETH", "USDC", "USDT"],
};

export function getConnectors(networkType: NetworkType) {
  return connectors[networkType].map(e => {
    const result = tokenDataByNetwork[networkType][e];

    if (!result || result === NOT_DEPLOYED) {
      throw new Error(`connector token ${e} not found`);
    }

    return result.toLowerCase() as Address;
  });
}
