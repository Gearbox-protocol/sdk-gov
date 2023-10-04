import {
  HumanizeDuration,
  HumanizeDurationLanguage,
} from "humanize-duration-ts";
import { string, z } from "zod";

import { SupportedToken, tokenSymbolByAddress } from "../tokens/token";
import { fmtContract, percentFmt } from "../utils/formatter";
import { PartialRecord } from "../utils/types";
import { AaveV2WrappedTokenAdapterState } from "./adapters/aaveV2WrappedToken";
import { BalancerVaultAdapterState } from "./adapters/balancerVault";
import { CompoundV2CEtherAdapterState } from "./adapters/compoundV2CEther";
import { ConvexV1BaseRewardPoolAdapterState } from "./adapters/convexV1BaseRewardPool";
import { ConvexV1BoosterAdapterState } from "./adapters/convexV1Booster";
import { CurveV2AdapterState } from "./adapters/curveV2Base";
import { ERC4626AdapterState } from "./adapters/erc4626";
import { LidoV1AdapterState } from "./adapters/lidoV1";
import { UniswapV2AdapterState } from "./adapters/uniswapV2";
import { UniswapV3AdapterState } from "./adapters/uniswapV3";
import { WstETHV1AdapterState } from "./adapters/wstETHV1";

const ltParamsSchema = z.object({
  ltNow: z.number(),
  ltFinal: z.number(),
  ltInitial: z.number(),
  rampDuration: z.number(),
  timestampRampStart: z.number(),
});

interface LtParamsHuman {
  ltNow: string;
  ltFinal: string;
  ltInitial: string;
  rampDuration: string;
  timestampRampStart: string;
}

const creditManagerV3Schema = z.object({
  address: z.string(),
  name: z.string(),

  ccVersion: z.number(),
  cfVersion: z.number(),
  cmVersion: z.number(),

  creditConfigurator: z.string().length(42),
  creditFacade: z.string().length(42),
  degenNft: z.string().length(42),
  feeInterest: z.number(),
  feeLiquidation: z.number(),
  forbiddenTokenMask: z.coerce.bigint(),
  isDegenMode: z.boolean(),
  liquidationDiscount: z.number(),
  liquidationThresholds: z.record(z.string().length(42), ltParamsSchema),
  minDebt: z.coerce.bigint(),
  maxDebt: z.coerce.bigint(),
  maxEnabledTokensLength: z.number(),
  pool: z.string().length(42),
  underlying: z.string().length(42),
  adapters: z.record(z.string().length(42), z.record(z.string(), z.any())),
});

type CreditManagerV3Payload = z.infer<typeof creditManagerV3Schema>;

const poolsV1ArraySchema = z.array(creditManagerV3Schema);

export class CreditManagerV3State {
  address: string;
  name: string;
  underlying: SupportedToken;

  ccVersion: number;
  cfVersion: number;
  cmVersion: number;

  creditConfigurator: string;
  creditFacade: string;
  degenNft: string;
  feeInterest: string;
  feeLiquidation: string;
  forbiddenTokenMask: string;
  isDegenMode: boolean;
  liquidationDiscount: string;
  liquidationThresholds: PartialRecord<SupportedToken, LtParamsHuman>;
  minDebt: string;
  maxDebt: string;
  maxEnabledTokensLength: number;
  pool: string;
  adapters: Record<string, Record<string, any>>;

  constructor(payload: CreditManagerV3Payload) {
    this.address = payload.address;
    this.name = payload.name;

    this.underlying = tokenSymbolByAddress[payload.underlying];

    this.ccVersion = payload.ccVersion;
    this.cfVersion = payload.cfVersion;
    this.cmVersion = payload.cmVersion;

    this.creditConfigurator = payload.creditConfigurator;
    this.creditFacade = payload.creditFacade;
    this.degenNft = payload.degenNft;

    this.feeInterest = percentFmt(payload.feeInterest);
    this.feeLiquidation = percentFmt(payload.feeLiquidation);
    this.forbiddenTokenMask = payload.forbiddenTokenMask.toString();
    this.isDegenMode = payload.isDegenMode;
    this.liquidationDiscount = percentFmt(payload.liquidationDiscount);

    const langService = new HumanizeDurationLanguage();
    const humanizer = new HumanizeDuration(langService);

    this.liquidationThresholds = Object.entries(payload.liquidationThresholds)
      .sort((a, b) => {
        return tokenSymbolByAddress[a[0]] > tokenSymbolByAddress[b[0]] ? 1 : -1;
      })
      .map(([token, ltParams]) => ({
        token: tokenSymbolByAddress[token],
        ltParams: {
          ltNow: percentFmt(ltParams.ltNow),
          ltInitial: percentFmt(ltParams.ltInitial),
          ltFinal: percentFmt(ltParams.ltFinal),

          rampDuration: `${humanizer.humanize(
            ltParams.rampDuration,
          )} [ ${ltParams.rampDuration.toString()}]`,
          timestampRampStart: new Date(ltParams.timestampRampStart * 1000),
        },
      }))
      .reduce(
        (acc, { token, ltParams: liquidationThresholds }) => ({
          ...acc,
          [token]: liquidationThresholds,
        }),
        {},
      );

    this.minDebt = payload.minDebt.toString();
    this.maxDebt = payload.maxDebt.toString();
    this.maxEnabledTokensLength = payload.maxEnabledTokensLength;
    this.pool = payload.pool;
    this.adapters = Object.entries(payload.adapters)
      .map(([address, data]) => {
        const { adapterType, state } =
          CreditManagerV3State.parseTypeAndState(data);

        let adapterData = {};

        switch (adapterType) {
          case "curveV1ExchangeOnly":
          case "curve2Assets":
          case "curve3Assets":
          case "curve4Assets":
          case "curveSteCrv":
          case "curveWrapper":
            adapterData = CurveV2AdapterState.fromJson(state);
            break;
          case "compoundV2CERC2":
            adapterData = CompoundV2CEtherAdapterState.fromJson(state);
            break;
          case "compoundV2Ether":
            adapterData = CompoundV2CEtherAdapterState.fromJson(state);
            break;
          case "convexV1BaseRewardPool":
            adapterData = ConvexV1BaseRewardPoolAdapterState.fromJson(state);
            break;
          case "convexV1Booster":
            adapterData = ConvexV1BoosterAdapterState.fromJson(state);
            break;
          case "lidoV1":
            adapterData = LidoV1AdapterState.fromJson(state);
            break;
          case "lidoWstETHV1":
            adapterData = WstETHV1AdapterState.fromJson(state);
            break;
          case "balancerVault":
            adapterData = BalancerVaultAdapterState.fromJson(state);
            break;
          case "eRC4626Vault":
            adapterData = ERC4626AdapterState.fromJson(state);
            break;
          case "uniswapV2Router":
            adapterData = UniswapV2AdapterState.fromJson(state);
            break;
          case "uniswapV3Router":
            adapterData = UniswapV3AdapterState.fromJson(state);
            break;
          default:
            adapterData = data;
        }

        return { address, data: { adapterType, ...adapterData } };
      })
      .reduce(
        (acc, { address, data }) => ({ ...acc, [fmtContract(address)]: data }),
        {},
      );
  }

  static parseTypeAndState(data: Record<string, any>): {
    adapterType: string;
    state: string;
  } {
    if (Object.keys(data).length !== 1) {
      throw new Error("Unexpected adapter data");
    }
    const adapterType = Object.keys(data)[0];
    const { state } = Object.values(data)[0];

    return { adapterType, state: JSON.stringify(state) };
  }

  static fromJson(json: string): Array<CreditManagerV3State> {
    const payload = poolsV1ArraySchema.parse(JSON.parse(json));
    return payload.map(p => new CreditManagerV3State(p));
  }
}
