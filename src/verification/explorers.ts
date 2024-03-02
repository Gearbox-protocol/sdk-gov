import { NetworkType } from "../core/chains";

export const explorerUrl: Record<NetworkType, string> = {
  Mainnet: "https://api.etherscan.io/api",
  Arbitrum: "https://api.arbiscan.io/api",
  Optimism: "https://api.optimistic.etherscan.io/api",
};
