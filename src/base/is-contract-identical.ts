import axios from "axios";

import { FullContractAndImportsResult } from "./github-checker";

export type IdentityCheckResult =
  | {
      identical: true;
    }
  | {
      identical: false;
      error: string;
    };

export type CachedIdentityCheckResult = FullContractAndImportsResult & {
  found: boolean;
};

// Names of contracts with known identity problems
export const IdentityExclusions = [
  "AddressProvider.sol",
  "IAdapter.sol",
  "Constants.sol",
];

export const isInExclusion = (contractName: string) => {
  return IdentityExclusions.includes(contractName);
};

export const checkCachedResult = async (
  result: CachedIdentityCheckResult,
): Promise<IdentityCheckResult> => {
  for (const report of result.sources) {
    if (report.reportsVerificationResult.length === 0) {
      if (isInExclusion(report.contract)) continue;
      return {
        identical: false,
        error: `Contract ${report.contract} is not identical to Github repo`,
      };
    }

    if (report.reportsVerificationResult.some(r => r.identical === false)) {
      return {
        identical: false,
        error: `Contract ${report.contract} is not identical to Github repo`,
      };
    }
  }
  return {
    identical: true,
  };
};

export const isContractIdentical = async (
  address: string,
): Promise<IdentityCheckResult> => {
  try {
    const cachedVerificationResult = await axios.get<CachedIdentityCheckResult>(
      `https://risk.gearbox.foundation/api/contracts/github?address=${address}`,
    );

    if (!cachedVerificationResult.data.found) {
      return {
        identical: false,
        error: "Contract not found in Gearbox github repos",
      };
    }

    return checkCachedResult(cachedVerificationResult.data);
  } catch (e: any) {
    return {
      identical: false,
      error: e.response.data,
    };
  }
};
