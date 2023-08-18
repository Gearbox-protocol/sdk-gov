import { ethers } from "ethers";

import { CoreConfigurator } from "./state/core";

export async function deploy() {
  // const txBatcher= new TxBatcher({});

  const core = await CoreConfigurator.attach(
    "0x0000000",
    new ethers.providers.JsonRpcProvider(),
  );

  await core.addressProvider.setAddress("AP_ACL", "0x0000000", 0);

  const vr = await core.addressProvider.validate();
  console.error(vr.errors);
  console.error(vr.warnings);
}

deploy();
