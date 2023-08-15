import { formatBN } from "@gearbox-protocol/sdk";
import { BigNumber } from "ethers";

import {
  maxETHPice,
  maxGasPerEnabledToken,
  maxGasPrice,
  minTokenPriceUSD,
  PERCENTAGE_FACTOR,
} from "./constants";
import { UnderlyingToken } from "./types";

export const calculateLiquidationCoverage = (args: {
  maxEnabledTokens: number;
  minBorrowedAmount: BigNumber;
  liquidationFee: number;
  liquidationDiscount: number;
  underlyingToken: UnderlyingToken;
}) => {
  const {
    maxEnabledTokens,
    minBorrowedAmount,
    liquidationFee,
    liquidationDiscount,
    underlyingToken,
  } = args;

  // calculate liquidation premium
  const ltUnderlying = liquidationDiscount - liquidationFee;

  const minAmountOnAccount = minBorrowedAmount
    .mul(PERCENTAGE_FACTOR)
    .div(BigNumber.from(ltUnderlying));

  console.log(`minAmountOnAccount ${formatBN(minAmountOnAccount, 18)} ETH`);

  const liquidationPremium = minAmountOnAccount
    .mul(PERCENTAGE_FACTOR - liquidationDiscount)
    .div(PERCENTAGE_FACTOR);

  const liquidationPremiumInUSD = liquidationPremium
    .mul(minTokenPriceUSD(underlyingToken.token!))
    .mul(BigNumber.from(10).pow(18))
    .div(BigNumber.from(10).pow(underlyingToken.decimals!));

  const liquidationPremiumInETH = liquidationPremiumInUSD.div(maxETHPice);

  console.log(
    `liquidationPremiumInETH ${formatBN(liquidationPremiumInETH, 18)} ETH`,
  );

  // get liquidation cost
  const liquidationCostETH = maxGasPrice
    .mul(maxGasPerEnabledToken)
    .mul(maxEnabledTokens);

  return {
    isCovered: liquidationCostETH >= liquidationPremiumInETH,
    liquidationCostETH,
    liquidationPremiumInETH,
  };
};
