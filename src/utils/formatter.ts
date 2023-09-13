import { BigNumberish } from "ethers";

export const toBigInt = (v: BigNumberish): bigint => {
  const value =
    typeof v === "object" && (v as any).type === "BigNumber"
      ? (v as any).hex
      : v.toString();
  return BigInt(value);
};
