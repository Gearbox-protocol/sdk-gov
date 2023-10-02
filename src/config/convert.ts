export function bnToContractString(value: bigint): string {
  let thousand = BigInt(1000);
  let result = "";
  let prevThousands = BigInt(1);

  let theLastLoop = false;

  while (!theLastLoop) {
    const remainder = (value % thousand) / prevThousands;

    theLastLoop = thousand > value;
    let remainderStr = "";
    if (theLastLoop) {
      remainderStr = `${remainder}`;
    } else {
      remainderStr =
        remainder >= 100
          ? `_${remainder}`
          : remainder >= 10
          ? `_0${remainder}`
          : `_00${remainder}`;
    }

    result = `${remainderStr}${result}`;
    prevThousands = thousand;

    thousand *= BigInt(1000);
  }
  return result;
}

export function bnToContractPercentage(value: number): string {
  if (value < 99) {
    return value.toString();
  }

  const remainder = value % 100;

  return `${Math.floor(value / 100)}_${
    remainder >= 10 ? remainder : `0${remainder}`
  }`;
}
