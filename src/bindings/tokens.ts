import { balancerLpTokens } from "../tokens/balancer";
import { convexTokens } from "../tokens/convex";
import { curveTokens } from "../tokens/curveLP";
import { tokenDataByNetwork } from "../tokens/token";
import { yearnTokens } from "../tokens/yearn";

const bindings = {
  tokenDataByNetwork,
  curveTokens,
  yearnTokens,
  convexTokens,
  balancerLpTokens,
};

console.log(JSON.stringify(bindings));
