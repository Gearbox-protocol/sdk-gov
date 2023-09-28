import * as fs from "fs";
import yaml from "yaml";

import { GlobalState } from "./globalState";

const jsonName =
  process.argv.length > 2 ? process.argv[process.argv.length - 1] : "1.json";

const stateJson = fs.readFileSync(jsonName, "utf-8");
const globalState = GlobalState.fromJson(stateJson);

console.log(yaml.stringify(globalState));
