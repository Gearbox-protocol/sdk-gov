import { NetworkType } from "../core/chains";

export const explorerUrl: Record<NetworkType, string> = {
  Mainnet: "https://etherscan.io/api",
  Arbitrum: "https://arbiscan.io/api",
  Optimism: "https://optimistic.etherscan.io/api",
};
