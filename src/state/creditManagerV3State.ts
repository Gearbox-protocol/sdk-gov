import {
  HumanizeDuration,
  HumanizeDurationLanguage,
} from "humanize-duration-ts";
import { z } from "zod";

import { TREASURY } from "../contracts/utilsContracts";
import { SupportedToken, tokenSymbolByAddress } from "../tokens/token";
import { percentFmt } from "../utils/formatter";
import { PartialRecord } from "../utils/types";
import { LinearModel, linearModelSchema } from "./linearModel";

//  "creditManagersV3": [
// {
//   "adapters": {
//     "0x0a760466e1b4621579a82a39cb56dda2f4e70f03": "0xa3c562eca6010d19bb7031438750e4e43fc32298",
//     "0x22ee18aca7f3ee920d01f25da85840d12d98e8ca": "0x0696e7d2ec24e84a189c9f69182aae5acf62581d",
//     "0x2ad92a7ae036a038ff02b96c88de868ddf3f8190": "0x55de4ec94adb08335f0af9d59bf145983f91e6a0",
//     "0x4f062658eaaf2c1ccf8c8e36d6824cdf41167956": "0x48d1e114023ce1546f4c6602c9cb779b4f210889",
//     "0x689440f2ff927e1f24c72f1087e1faf471ece1c8": "0xca3950820345fbe102565ca71f5fdc652b58cf93",
//     "0x7a250d5630b4cf539739df2c5dacb4c659f2488d": "0xce17d31e669d4416dd42cd82a3790bd95dad77a7",
//     "0x7a7bbf95c44b144979360c3300b54a7d34b44985": "0xfc0bb326e2bd31ea967157bb669aa0fe49d7b470",
//     "0x7e880867363a7e321f5d260cade2b0bb2f717b02": "0x9c7688b1ebf80bd1c16f7ab9a965f58274bcb433",
//     "0xa258c4606ca8206d8aa700ce2143d7db854d168c": "0x172cc07afc35007af8f19fd307ff8838c20e2e28",
//     "0xa354f35829ae975e850e23e9615b11da1b3dc4de": "0xc85343d1c043ccd782898710f86d8e498d6a9421",
//     "0xa5407eae9ba41422680e2e00537571bcc53efbfd": "0x2e726cda221e84f46a0058bf15206868fa15feae",
//     "0xa696a63cc78dffa1a63e9e50587c197387ff6c7e": "0xbfd6001946e89d5181a23b4397586e09a00e0b0e",
//     "0xb4ada607b9d6b2c9ee07a275e9616b84ac560139": "0xe6334c2ac8015f2fef1a0117946abf7b4a47ba86",
//     "0xb900ef131301b307db5efcbed9dbb50a3e209b2e": "0xf584b84b399479762d7ee153d84f4379bedb2112",
//     "0xba12222222228d8ba445958a75a0704d566bf2c8": "0x03dee35cda44b8e1cd342f891a02fc666afd6625",
//     "0xbebc44782c7db0a1a60cb6fe97d0b483032ff1c7": "0x50943b588455833d86506ab89105598972dc6323",
//     "0xd632f22692fac7611d2aa1c0d552930d43caed3b": "0x6f426553d5e14b1ea76e9a518a9f350cde42228d",
//     "0xd9e1ce17f2641f24ae83637ab66a2cca9c378b9f": "0xed7b62219f2c314075d175442059ee430983570d",
//     "0xda816459f1ab5631232fe5e97a05bbbb94970c95": "0xa26d533c7f5d8114cfdf267f14f3ed324bf2f345",
//     "0xdcd90c7f6324cfa40d7169ef80b12031770b4325": "0x3e74f6561190dd6bd674454477d438a6182c572c",
//     "0xdcef968d416a41cdac0ed8702fac8128a64241a2": "0xe13ccfe3dd59d2b38a5c95cdd881934536e69ce0",
//     "0xe592427a0aece92de3edee1f18e0157c05861564": "0x9d95e688b508ce7555c304aa380f2dac0999285a",
//     "0xed279fdd11ca84beef15af5d39bb4d4bee23f0ca": "0x46cf80b319dff988ef4afe447f98e817ff5f4f62",
//     "0xef0d72c594b28252bf7ea2bfbf098792430815b1": "0x8d31524c684fa39366ac34de61271ab6c9769c1a",
//     "0xf403c135812408bfbe8713b5a23a04b3d48aae31": "0x50ccd17f7da687e97889c333d53699ce63730d95",
//     "0xfcba3e75865d2d561be8d220616520c171f12851": "0x2771325565bc41c4042a8e8e13b1e60ad04df22e"
//   },
//   "addr": "0xda01555d2d76818b5b2279d35d5e66addc897595",
//   "ccVersion": 300,
//   "cfVersion": 300,
//   "cmVersion": 300,
//   "collateralTokens": [
//     "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48",
//     "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
//     "0xae7ab96520de3a18e5e111b5eaab095312d7fe84",
//     "0x2260fac5e5542a773aa44fbcfedf7c193bc2c599",
//     "0x6b175474e89094c44da98b954eedeac495271d0f",
//     "0xdac17f958d2ee523a2206206994597c13d831ec7",
//     "0x57ab1ec28d129707052df4df418d58a2d46d5f51",
//     "0x853d955acef822db058eb8505911ed77f175b99e",
//     "0x056fd409e1d7a124bd7017459dfea2f387b6d5cd",
//     "0x5f98805a4e8be255a32880fdec7f6728c6568ba0",
//     "0x06325440d014e39736583c165c2963ba99faf14e",
//     "0x9518c9063eb0262d791f38d8d6eb0aca33c63ed0",
//     "0xe15b7d80a51e1fe54ac355cabe848efce5289bdb",
//     "0x6c3f90f043a72fa612cbac8115ee7e52bde6e490",
//     "0x30d9410ed1d5da1f6c8391af5338c93ab8d4035c",
//     "0xbac7a431146aeaf3f57a16b9954f332fd292f270",
//     "0xd632f22692fac7611d2aa1c0d552930d43caed3b",
//     "0xbe0f6478e0e4894cfb14f32855603a083a57c7da",
//     "0xaf314b088b53835d5cf4e4cb81beaba5934a61fe",
//     "0xed279fdd11ca84beef15af5d39bb4d4bee23f0ca",
//     "0xfb9b2f06fdb404fd3e2278e9a9edc8f252f273d0",
//     "0x0a1d4a25d0390899b90bcd22e1ef155003ea76d7",
//     "0xc25a3a3b969415c80451098fa907ec722572917f",
//     "0x11d200ef1409ceca8d6d23e6496550f707772f11",
//     "0x7e1992a7f28daa5f6a2d34e2cd40f962f37b172c",
//     "0xd2967f45c4f384deea880f807be904762a3dea07",
//     "0x15c2471ef46fa721990730cfa526bcfb45574576",
//     "0x34fb99abbafb4e87e256960d572664c6adc301b8",
//     "0x3175df0976dfa876431c2e9ee6bc45b65d3473cc",
//     "0x117a0bab81f25e60900787d98061ccfae023560c",
//     "0x276187f24d41745513cbe2bd5dfc33a4d8cdc9ed",
//     "0xda816459f1ab5631232fe5e97a05bbbb94970c95",
//     "0xa354f35829ae975e850e23e9615b11da1b3dc4de",
//     "0xa258c4606ca8206d8aa700ce2143d7db854d168c",
//     "0xa696a63cc78dffa1a63e9e50587c197387ff6c7e",
//     "0xdcd90c7f6324cfa40d7169ef80b12031770b4325",
//     "0xb4ada607b9d6b2c9ee07a275e9616b84ac560139",
//     "0x4e3fbd56cd56c3e72c1403e103b45db9da5b9d2b",
//     "0x3432b6a60d23ca0dfca7761b7ab56459d9c964d0",
//     "0x6dea81c8171d0ba574754ef6f8b412f2ed88c54d",
//     "0xd533a949740bb3306d119cc777fa900ba034cd52",
//     "0x5a98fcbea516cf06857215779fd812ca3bef1b32",
//     "0xc011a73ee8576fb46f5e1c5751ca3b9fe0af2a6f"
//   ],
//   "creditConfigurator": "0x50acf8c73079979a4d8a3891efc26604985e92e9",
//   "creditFacade": "0x24dd968d3f8ed9a54c586764e70e5a7de8f9ad75",
//   "degenNft": "0x0000000000000000000000000000000000000000",
//   "feeInterest": 5000,
//   "feeLiquidation": 150,
//   "feeLiquidationExpired": 100,
//   "forbiddenTokenMask": "0x0",
//   "isDegenMode": false,
//   "isPaused": false,
//   "liquidationDiscount": 9600,
//   "liquidationDiscountExpired": 9800,
//   "liquidationThresholds": {
//     "0x056fd409e1d7a124bd7017459dfea2f387b6d5cd": 9000,
//     "0x06325440d014e39736583c165c2963ba99faf14e": 8250,
//     "0x0a1d4a25d0390899b90bcd22e1ef155003ea76d7": 9000,
//     "0x117a0bab81f25e60900787d98061ccfae023560c": 9000,
//     "0x11d200ef1409ceca8d6d23e6496550f707772f11": 9000,
//     "0x15c2471ef46fa721990730cfa526bcfb45574576": 9000,
//     "0x2260fac5e5542a773aa44fbcfedf7c193bc2c599": 8500,
//     "0x276187f24d41745513cbe2bd5dfc33a4d8cdc9ed": 9000,
//     "0x30d9410ed1d5da1f6c8391af5338c93ab8d4035c": 9000,
//     "0x3175df0976dfa876431c2e9ee6bc45b65d3473cc": 9000,
//     "0x3432b6a60d23ca0dfca7761b7ab56459d9c964d0": 0,
//     "0x34fb99abbafb4e87e256960d572664c6adc301b8": 9000,
//     "0x4e3fbd56cd56c3e72c1403e103b45db9da5b9d2b": 0,
//     "0x57ab1ec28d129707052df4df418d58a2d46d5f51": 9000,
//     "0x5a98fcbea516cf06857215779fd812ca3bef1b32": 0,
//     "0x5f98805a4e8be255a32880fdec7f6728c6568ba0": 9000,
//     "0x6b175474e89094c44da98b954eedeac495271d0f": 9200,
//     "0x6c3f90f043a72fa612cbac8115ee7e52bde6e490": 9000,
//     "0x6dea81c8171d0ba574754ef6f8b412f2ed88c54d": 0,
//     "0x7e1992a7f28daa5f6a2d34e2cd40f962f37b172c": 9000,
//     "0x853d955acef822db058eb8505911ed77f175b99e": 9000,
//     "0x9518c9063eb0262d791f38d8d6eb0aca33c63ed0": 8250,
//     "0xa258c4606ca8206d8aa700ce2143d7db854d168c": 8250,
//     "0xa354f35829ae975e850e23e9615b11da1b3dc4de": 9000,
//     "0xa696a63cc78dffa1a63e9e50587c197387ff6c7e": 8250,
//     "0xae7ab96520de3a18e5e111b5eaab095312d7fe84": 8250,
//     "0xaf314b088b53835d5cf4e4cb81beaba5934a61fe": 9000,
//     "0xb4ada607b9d6b2c9ee07a275e9616b84ac560139": 9000,
//     "0xbac7a431146aeaf3f57a16b9954f332fd292f270": 9000,
//     "0xbe0f6478e0e4894cfb14f32855603a083a57c7da": 9000,
//     "0xc011a73ee8576fb46f5e1c5751ca3b9fe0af2a6f": 25,
//     "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2": 8500,
//     "0xc25a3a3b969415c80451098fa907ec722572917f": 9000,
//     "0xd2967f45c4f384deea880f807be904762a3dea07": 9000,
//     "0xd533a949740bb3306d119cc777fa900ba034cd52": 2500,
//     "0xd632f22692fac7611d2aa1c0d552930d43caed3b": 9000,
//     "0xda816459f1ab5631232fe5e97a05bbbb94970c95": 9000,
//     "0xdac17f958d2ee523a2206206994597c13d831ec7": 9000,
//     "0xdcd90c7f6324cfa40d7169ef80b12031770b4325": 8250,
//     "0xe15b7d80a51e1fe54ac355cabe848efce5289bdb": 8250,
//     "0xed279fdd11ca84beef15af5d39bb4d4bee23f0ca": 9000,
//     "0xfb9b2f06fdb404fd3e2278e9a9edc8f252f273d0": 9000
//   },
//   "maxDebt": "0xe8d4a51000",
//   "maxEnabledTokensLength": 12,
//   "minDebt": "0x2540be400",
//   "pool": "0x7c87164ec88d058e504cbc6bf8a9d38edc976901",
//   "underlying": "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48"

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
  description: z.string(),

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

  constructor(payload: CreditManagerV3Payload) {
    this.address = payload.address;
    this.name = payload.description;

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
  }

  static fromJson(json: string): Array<CreditManagerV3State> {
    const payload = poolsV1ArraySchema.parse(JSON.parse(json));
    return payload.map(p => new CreditManagerV3State(p));
  }
}
