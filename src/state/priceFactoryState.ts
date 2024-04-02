import { PriceFeedType } from "../oracles/pricefeedType";
import { Address, PartialRecord } from "../utils/types";
import { BaseContractState } from "./state";

export interface PriceOracleState {
  priceOracleV3: PriceOracleV3State;
  mainPriceFeeds: PartialRecord<Address, PriceFeedState>;
  reservePriceFeeds: PartialRecord<Address, PriceFeedState>;
}

export type PriceOracleV3State = BaseContractState;

export type PriceFeedState =
  | BoundedOracleState
  | AssetPriceFeedState
  | RedstonePriceFeedState;

export interface BasePriceFeedState extends BaseContractState {
  stalenessPeriod: number;
  skipCheck: boolean;
  trusted?: boolean;
}

export interface AssetPriceFeedState extends BasePriceFeedState {
  type: Exclude<PriceFeedType, PriceFeedType.REDSTONE_ORACLE>;
  pricefeeds: Array<PriceFeedState>;
}

export interface BoundedOracleState extends AssetPriceFeedState {
  upperBound: bigint;
}

export interface RedstonePriceFeedState extends BasePriceFeedState {
  type: PriceFeedType.REDSTONE_ORACLE;
  dataId: string;
  signers: Array<string>;
  signersThreshold: number;
}
