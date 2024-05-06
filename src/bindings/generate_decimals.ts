import { Contract, getDefaultProvider } from "ethers";
import * as fs from "fs";

import {
  SupportedToken,
  supportedTokens,
  tokenDataByNetwork,
} from "../tokens/token";
import { erc20Interface } from "../tokens/tokens.spec";

async function generateTokens() {
  const deployer = await getDefaultProvider();

  const tokenList: Array<string> = [];
  for (let token of Object.keys(supportedTokens)) {
    const address = tokenDataByNetwork.Mainnet[token as SupportedToken];
    const decimals = await new Contract(
      address,
      erc20Interface,
      deployer,
    ).decimals();
    tokenList.push(`"${token}": ${decimals.toString()}`);
  }

  const file = `import { SupportedToken } from "./token";

  export const decimals: Record<SupportedToken, number> = {
    ${tokenList.join(",\n")}
   } `;

  fs.writeFileSync("./decimals.ts", file);
}

generateTokens()
  .then(() => {
    process.exit(0);
  })
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
