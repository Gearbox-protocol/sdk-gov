import * as fs from "fs";
import yaml from "yaml";

import { GlobalState } from "./globalState";

const stateJson = fs.readFileSync("1.json", "utf-8");

const globalState = GlobalState.fromJson(stateJson);

console.log(yaml.stringify(globalState));
