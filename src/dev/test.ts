import fs from "fs";

import { TxBatcher } from "../base/TxBatcher";
import { CreditConfiguratorV2TxBuilder } from "../tx-builders/credit-configurator/credit-configurator-v2";

const main = async () => {
  const cc = new CreditConfiguratorV2TxBuilder(
    "0x5f3b5DfEb7B28CDbD7FAba78963EE202a494e2A2"
  );

  const tx = await cc.setMaxEnabledTokens(12);

  const txBatcher = new TxBatcher();

  txBatcher.addTx(tx).setChainId(1).setDescription("description").setEta(123);

  const queueBatch = txBatcher.exportQueueBatch();

  console.log("queueBatch", JSON.stringify(queueBatch, null, 2));

  fs.writeFileSync("queueBatch.json", JSON.stringify(queueBatch, null, 2));
};

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
