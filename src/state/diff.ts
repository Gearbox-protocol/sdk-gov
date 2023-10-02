import { detailedDiff, diff } from "deep-object-diff";
import * as fs from "fs";
import yaml from "yaml";

import { GlobalState } from "./globalState";

const json1Name =
  process.argv.length > 2 ? process.argv[process.argv.length - 1] : "1.json";

const stateJson1 = fs.readFileSync(json1Name, "utf-8");
const globalState1 = GlobalState.fromJson(stateJson1);

const json2Name =
  process.argv.length > 3 ? process.argv[process.argv.length - 2] : "2.json";

const stateJson2 = fs.readFileSync(json2Name, "utf-8");
const globalState2 = GlobalState.fromJson(stateJson2);

console.log(yaml.stringify(detailedDiff(globalState1, globalState2)));
