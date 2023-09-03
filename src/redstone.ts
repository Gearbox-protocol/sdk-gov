import { DataServiceWrapper } from "@redstone-finance/evm-connector/dist/src/wrappers/DataServiceWrapper";

async function getRedstonePayloadForManualUsage() {
  const redstonePayload = await new DataServiceWrapper({
    dataServiceId: "redstone-main-demo",
    dataFeeds: ["SHIB"],
    uniqueSignersCount: 1,
  }).prepareRedstonePayload(true);

  console.log(redstonePayload);
}

getRedstonePayloadForManualUsage()
  .then(() => {
    console.log("Done");
  })
  .catch(error => {
    console.error(error);
  });
