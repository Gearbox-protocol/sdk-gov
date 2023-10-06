import { BigNumberish } from "ethers";

import { contractsByAddress } from "../contracts/contracts";
import { TREASURY } from "../contracts/utilsContracts";
import { tokenSymbolByAddress } from "../tokens/token";

export const toBigInt = (v: BigNumberish): bigint => {
  const value =
    typeof v === "object" && (v as any).type === "BigNumber"
      ? (v as any).hex
      : v.toString();
  return BigInt(value);
};

export const percentFmt = (v: number): string =>
  `${(v / 100).toFixed(2)}% [ ${v} ]`;

export function formatBN(
  num: BigNumberish | undefined,
  decimals: number,
  precision?: number,
): string {
  if (num === undefined) return "-";
  const numBInt = toBigInt(num);
  // GUSD: 2 decimals
  const limitedNum = limitNum(numBInt, decimals);
  const limitedPrecision = limitPrecision(limitedNum, precision);
  return toHumanFormat(limitedNum, limitedPrecision);
}

const limitPrecision = (n: bigint, p?: number) => {
  const notZero = n !== 0n;
  if (n <= 10n && notZero) {
    return 6;
  }
  if (n <= 100n && notZero) {
    return 5;
  }
  if (n <= 1000n && notZero) {
    return 4;
  }
  if (n <= 10000n && notZero) {
    return 3;
  }
  if (p === undefined && n > 10n ** 21n) {
    return 2;
  }
  if (p === undefined && n > 10n ** 24n) {
    return 0;
  }

  return p;
};

const limitNum = (n: bigint, d = 18): bigint => {
  let limited = n <= 2n ? 0n : n;
  if (d <= 6) {
    return limited * 10n ** BigInt(6 - d);
  } else {
    return limited / 10n ** BigInt(d - 6);
  }
};

export function toHumanFormat(num: bigint, precision = 2): string {
  if (num >= BigInt(1e15)) {
    return `${formatBn4dig(num / BigInt(1e9), precision)}Bn`;
  }

  if (num >= BigInt(1e12)) {
    return `${formatBn4dig(num / BigInt(1e6), precision)}M`;
  }

  if (num >= BigInt(1e9)) {
    return `${formatBn4dig(num / BigInt(1e3), precision)}K`;
  }

  return formatBn4dig(num, precision);
}

export function formatBn4dig(num: bigint, precision = 2): string {
  if (precision > 6) {
    throw new Error("Precision is too high, try <= 6");
  }

  const numStr = num.toString();
  if (numStr.length <= 6) {
    const completed = "0".repeat(6 - numStr.length) + numStr;
    return `0.${completed.slice(0, precision)}`;
  }
  return `${numStr.slice(0, numStr.length - 6)}.${numStr.slice(
    numStr.length - 6,
    numStr.length - 6 + precision,
  )}`;
}

export function getTokenSymbolOrAddress(address: string): string {
  return tokenSymbolByAddress[address] || address;
}

export function fmtBinaryMask(mask: bigint): string {
  return mask.toString(2).padStart(64, "0");
}

export function fmtTreasury(treasury: string): string {
  return treasury === TREASURY.Mainnet
    ? `GEARBOX TREASURY: [${treasury}]`
    : treasury;
}

export function fmtContract(address: string): string {
  return contractsByAddress[address.toLocaleLowerCase()]
    ? `[${contractsByAddress[address.toLowerCase()]}]`
    : address;
}
