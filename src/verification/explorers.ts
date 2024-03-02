import { NetworkType } from "../core/chains";

export const explorerUrl: Record<NetworkType, string> = {
  Mainnet: "https://etherscan.io",
  Arbitrum: "https://arbiscan.io",
  Optimism: "https://optimistic.etherscan.io",
};
