import { expect } from "chai";
import { Interface, JsonRpcProvider, Network } from "ethers";

import { CHAINS, NetworkType } from "../core/chains";
import { SupportedToken } from "../tokens/token";
import { KeyedCall, safeMulticall } from "../utils/multicall";
import { priceFeedsByToken } from "./priceFeeds";
import { PriceFeedData, PriceFeedType } from "./pricefeedType";

type PricesDict = Record<
  string,
  { error?: Error | undefined; value?: { answer: bigint } | undefined }
>;

const iFeed = new Interface([
  "function latestRoundData() external view returns (uint80, int256, uint256, uint256, uint80)",
]);

type AggregatorV3InterfaceInterface = typeof iFeed;

class PriceFeedsSuite {
  public readonly networkTypes: NetworkType[];
  public readonly calls: KeyedCall<AggregatorV3InterfaceInterface>[][];

  constructor(...networkTypes: NetworkType[]) {
    this.networkTypes = networkTypes;
    this.calls = networkTypes.map(c => this.collectCalls(c));
  }

  public async getAnswers(): Promise<PricesDict[]> {
    const providers = this.networkTypes.map(c => {
      const url = process.env[`${c.toUpperCase()}_TESTS_FORK`];
      if (!url) {
        throw new Error(`Provider for ${c} not found in env`);
      }
      return new JsonRpcProvider(url, CHAINS[c], {
        staticNetwork: new Network(c, CHAINS[c]),
      });
    });

    const resps = await Promise.all(
      this.networkTypes.map((_, i) =>
        safeMulticall<{ answer: bigint }>(this.calls[i], providers[i]),
      ),
    );
    return resps.map((_, i) => this.buildDict(this.calls[i], resps[i]));
  }

  private collectCalls(
    c: NetworkType,
  ): KeyedCall<AggregatorV3InterfaceInterface>[] {
    const calls: KeyedCall<AggregatorV3InterfaceInterface>[] = [];
    for (const [symb, data] of Object.entries(priceFeedsByToken)) {
      const dataForNetwork = "AllNetworks" in data ? data.AllNetworks : data[c];
      if (dataForNetwork) {
        calls.push(
          ...this.getCallsForToken(symb as SupportedToken, dataForNetwork.Main),
        );

        if (dataForNetwork.Reserve) {
          calls.push(
            ...this.getCallsForToken(
              symb as SupportedToken,
              dataForNetwork.Reserve,
            ),
          );
        }
      }
    }
    return calls;
  }

  private getCallsForToken(
    token: SupportedToken,
    data: PriceFeedData,
  ): KeyedCall<AggregatorV3InterfaceInterface>[] {
    const calls: KeyedCall<AggregatorV3InterfaceInterface>[] = [];
    switch (data.type) {
      case PriceFeedType.CHAINLINK_ORACLE:
        if (data.address.startsWith("0x")) {
          calls.push({
            address: data.address,
            interface: iFeed,
            method: "latestRoundData()",
            key: token,
          });
        }
        break;
      case PriceFeedType.BOUNDED_ORACLE:
        if (data.priceFeed.type === PriceFeedType.CHAINLINK_ORACLE) {
          calls.push({
            address: data.priceFeed.address,
            interface: iFeed,
            method: "latestRoundData()",
            key: token,
          });
        }
        break;
      case PriceFeedType.COMPOSITE_ORACLE:
        if (data.baseToUsdPriceFeed.type === PriceFeedType.CHAINLINK_ORACLE) {
          calls.push({
            address: data.baseToUsdPriceFeed.address,
            interface: iFeed,
            method: "latestRoundData()",
            key: `${token}.baseToUsdPriceFeed`,
          });
        }
        if (
          data.targetToBasePriceFeed.type === PriceFeedType.CHAINLINK_ORACLE
        ) {
          calls.push({
            address: data.targetToBasePriceFeed.address,
            interface: iFeed,
            method: "latestRoundData()",
            key: `${token}.targetToBasePriceFeed`,
          });
        }
        break;
    }
    return calls;
  }

  private buildDict<T>(
    calls: KeyedCall<AggregatorV3InterfaceInterface>[],
    responses: T[],
  ): Record<string, T> {
    return calls.reduce(
      (acc, call, i) => ({
        ...acc,
        [call.key]: responses[i],
      }),
      {} as Record<string, T>,
    );
  }
}

describe("Price feeds", () => {
  const suite = new PriceFeedsSuite("Mainnet", "Arbitrum");
  const PERCENTAGE_FACTOR = 1_00_00;
  const THRESHOLD = 100; // 1%
  let answers: PricesDict[] = [];

  before(async function (this) {
    this.timeout(10000);
    answers = await suite.getAnswers();
  });

  describe(`should not deviate for more than ${
    (100 * THRESHOLD) / PERCENTAGE_FACTOR
  }% from mainnet`, () => {
    // have to use suite.calls here, because answers are empty atm
    // this is how mocha works, it builds test tree before execution
    const [_, ...chainCalls] = suite.calls;

    for (let i = 0; i < chainCalls.length; i++) {
      const calls = chainCalls[i];
      const chain = suite.networkTypes[i + 1];
      for (const call of calls) {
        it(`${chain}.${call.key} deviation`, () => {
          const mainDict = answers[0];
          const chainDict = answers[i + 1];

          const chainPrice = chainDict[call.key].value?.answer;
          const mainPrice = mainDict[call.key]?.value?.answer;
          if (!mainPrice) {
            // some tokens do not exist on mainnet
            return;
          }
          const deviation =
            chainPrice !== undefined
              ? Math.abs(
                  Number(
                    ((chainPrice - mainPrice) * BigInt(PERCENTAGE_FACTOR)) /
                      mainPrice,
                  ),
                )
              : undefined;

          // console.log(
          //   call.key,
          //   deviation,
          //   chainPrice?.toNumber(),
          //   mainPrice.toNumber(),
          // );
          expect(
            deviation,
            `Mainnet price: ${mainPrice.toString()}, ${chain} price: ${chainPrice} at ${
              call.address
            }`,
          ).to.be.below(THRESHOLD);
        });
      }
    }
  });
});
