import { LPPriceFeed, LPPriceFeed__factory } from "@gearbox-protocol/core-v2";
import {
  detectNetwork,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { BigNumber, ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";

export class LpPriceFeedV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  // eslint-disable-next-line no-unused-private-class-members
  #network: NetworkType | undefined;
  #isInit = false;

  #lpPriceFeed: LPPriceFeed;

  constructor(args: { address: Address; provider: ethers.providers.Provider }) {
    const { provider, address } = args;
    super();
    this.#provider = provider;
    this.#lpPriceFeed = LPPriceFeed__factory.connect(address, this.#provider);
  }

  async #initialize() {
    if (this.#isInit) return;

    const network = await detectNetwork(this.#provider);
    if (!supportedChains.includes(network))
      throw new Error("Provider's network is not supported");
    this.#network = network;

    // check if address is LpPriceFeed, it has decimals == 8
    try {
      await this.#lpPriceFeed.decimals();
    } catch {
      throw new Error(
        "This address is not LpPriceFeed contract, no decimals()",
      );
    }

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-lp-feed-limiter.ts
  async setLimiter(lowerBound: BigNumber, force = false) {
    await this.#initialize();

    this.logger.info(
      `LpPriceFeed ${this.#lpPriceFeed.address}: setLimiter ${lowerBound} `,
    );

    const validationResult = await this.setLimiterValidate(lowerBound);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#lpPriceFeed!,
      method: "setLimiter(uint256)",
      args: [lowerBound],
      validationResult: validationResult,
    });
  }

  async setLimiterValidate(lowerBound: BigNumber) {
    await this.#initialize();

    this.logger.info(
      `LpPriceFeed ${
        this.#lpPriceFeed.address
      }: validating setLimiter ${lowerBound} `,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    if (lowerBound.isZero()) {
      validationResult.errors.push(
        `lowerBound ${lowerBound} should be greater than 0`,
      );
    }

    // todo how to check _checkCurrentValueInBounds ??

    return validationResult;
  }
}
