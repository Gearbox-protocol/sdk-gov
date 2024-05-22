import { Contract, Provider } from "ethers";

import { tokenDataByNetwork } from "../tokens/token";

export const MAINNET_NETWORK = 1;
export const GOERLI_NETWORK = 5;
export const OPTIMISM_NETWORK = 10;
export const LOCAL_NETWORK = 1337;
export const HARDHAT_NETWORK = 31337;
export const ARBITRUM_NETWORK = 42161;
export const BASE_NETWORK = 8453;

export const CHAINS = {
  Mainnet: MAINNET_NETWORK,
  Arbitrum: ARBITRUM_NETWORK,
  Local: LOCAL_NETWORK,
  Hardhat: HARDHAT_NETWORK,
  Optimism: OPTIMISM_NETWORK,
  Base: BASE_NETWORK,
} as const;

export const supportedChains = [
  "Mainnet",
  "Arbitrum",
  "Optimism",
  "Base",
] as const;
export type NetworkType = (typeof supportedChains)[number]; // "Polygon";

const SUPPORTED_CHAINS: Record<number, NetworkType> = {
  [CHAINS.Mainnet]: "Mainnet",
  [CHAINS.Arbitrum]: "Arbitrum",
  [CHAINS.Local]: "Mainnet",
  [CHAINS.Optimism]: "Optimism",
  // [CHAINS.Base]: "Polygon",
};

export const getNetworkType = (
  chainId: number,
  localAs: NetworkType = "Mainnet",
): NetworkType => {
  const chainType = SUPPORTED_CHAINS[chainId];

  if (chainId === CHAINS.Local) {
    return localAs;
  } else if (chainType) {
    return chainType;
  }

  throw new Error("Unsupported network");
};

export const isSupportedNetwork = (
  chainId: number | undefined,
): chainId is number => chainId !== undefined && !!SUPPORTED_CHAINS[chainId];

export const detectNetwork = async (
  provider: Provider,
): Promise<NetworkType> => {
  const usdcABI = ["function symbol() view returns (string)"];

  const mainnetUSDC = tokenDataByNetwork.Mainnet["USDC"];
  const arbitrumUSDC = tokenDataByNetwork.Arbitrum["USDC"];
  const optimismUSDC = tokenDataByNetwork.Optimism["USDC"];

  const mainnetUSDCContract = new Contract(mainnetUSDC, usdcABI, provider);

  const arbitrumUSDCContract = new Contract(arbitrumUSDC, usdcABI, provider);

  const optimismUSDCContract = new Contract(optimismUSDC, usdcABI, provider);

  try {
    await mainnetUSDCContract.symbol();
    return "Mainnet" as NetworkType;
  } catch {}

  try {
    await arbitrumUSDCContract.symbol();
    return "Arbitrum" as NetworkType;
  } catch {}

  try {
    await optimismUSDCContract.symbol();
    return "Optimism" as NetworkType;
  } catch {}

  throw new Error("Unsupported network");
};
