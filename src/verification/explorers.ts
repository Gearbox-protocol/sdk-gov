import { NetworkType } from "../core/chains";

export const explorerUrls: Record<NetworkType, string> = {
  Mainnet: "https://etherscan.io",
  Arbitrum: "https://arbiscan.io",
  Optimism: "https://optimistic.etherscan.io",
  Base: "https://basescan.org",
};

export const explorerApiUrls: Record<NetworkType, string> = {
  Mainnet: "https://api.etherscan.io/api",
  Arbitrum: "https://api.arbiscan.io/api",
  Optimism: "https://api-optimistic.etherscan.io/api",
  Base: "https://api.basescan.org/api",
};
