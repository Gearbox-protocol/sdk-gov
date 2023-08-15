import { NetworkType, tokenDataByNetwork } from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

const usdcABI = ["function symbol() view returns (string)"];

export const detectNetwork = async (
  provider: ethers.providers.Provider,
): Promise<NetworkType> => {
  const mainnetUSDC = tokenDataByNetwork.Mainnet["USDC"];
  const arbitrumUSDC = tokenDataByNetwork.Arbitrum["USDC"];

  const mainnetUSDCContract = new ethers.Contract(
    mainnetUSDC,
    usdcABI,
    provider,
  );

  const arbitrumUSDCContract = new ethers.Contract(
    arbitrumUSDC,
    usdcABI,
    provider,
  );

  try {
    await mainnetUSDCContract.symbol();
    return "Mainnet" as NetworkType;
  } catch {}

  try {
    await arbitrumUSDCContract.symbol();
    return "Arbitrum" as NetworkType;
  } catch {}

  throw new Error("Unsupported network");
};
