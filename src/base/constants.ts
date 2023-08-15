import { SupportedToken } from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

export const PERCENTAGE_FACTOR = 10000;
export const maxGasPerEnabledToken = 1_000_000;
export const maxGasPrice = ethers.utils.parseUnits("600", "gwei");

export const maxETHPice = 2000;

export type Underlying = Extract<
  SupportedToken,
  "DAI" | "USDC" | "WETH" | "WBTC" | "wstETH" | "FRAX"
>;

export const minTokenPriceUSD = (token: SupportedToken) => {
  switch (token) {
    case "DAI":
      return 1;
    case "USDC":
      return 1;
    case "WETH":
      return maxETHPice;
    case "WBTC":
      return 20000;
    case "wstETH":
      return maxETHPice;
    case "FRAX":
      return 1;
    default:
      throw new Error(`Invalid token: ${token}`);
  }
};

export const MAX_WITHDRAW_FEE = 100;
export const UNIVERSAL_CONTRACT = "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC";
