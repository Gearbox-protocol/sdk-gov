import { NetworkType } from "../core/chains";
import { NOT_DEPLOYED } from "../core/constants";
import { Address } from "../utils/types";
import { SupportedToken, tokenDataByNetwork } from "./token";

export const connectors: Record<NetworkType, Array<SupportedToken>> = {
  Mainnet: [
    "WETH",
    "DAI",
    "USDC",
    "USDe",
    "FRAX",
    "rETH",
    "ezETH",
    "GHO",
    "weETH",
    "wstETH",
    "STETH",
    "WBTC",
    "USDS",
    "eBTC",
    "LBTC",
    "solvBTC",
    "pumpBTC",
  ],
  Arbitrum: ["WETH", "DAI", "USDC", "USDT", "rETH", "USDC_e", "wstETH"],
  Optimism: ["WETH", "USDC", "USDT", "USDC_e", "wstETH"],
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
