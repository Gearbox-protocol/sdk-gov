import { ethers } from "ethers";

export const IsContract = async (
  address: string,
  provider: ethers.providers.Provider,
): Promise<boolean> => {
  const code = await provider.getCode(address);
  return code !== "0x";
};
