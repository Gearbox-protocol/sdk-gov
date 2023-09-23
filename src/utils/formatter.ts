import { BigNumberish } from "ethers";

export const toBigInt = (v: BigNumberish): bigint => {
  const value =
    typeof v === "object" && (v as any).type === "BigNumber"
      ? (v as any).hex
      : v.toString();
  return BigInt(value);
};

export const percentFmt = (v: number): string =>
  `${(v / 100).toFixed(2)}% [ ${v} ]`;
