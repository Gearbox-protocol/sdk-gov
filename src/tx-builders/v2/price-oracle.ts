import {
  ADDRESS_PROVIDER,
  AggregatorV3Interface__factory,
  detectNetwork,
  IAddressProvider__factory,
  IPriceOracleV2Ext,
  IPriceOracleV2Ext__factory,
  NetworkType,
  supportedChains,
  SupportedToken,
  tokenDataByNetwork,
} from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { isContractIdentical } from "../../base/is-contract-identical";
import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";

export class PriceOracleV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  #network: NetworkType | undefined;
  #isInit = false;

  #priceOracle: IPriceOracleV2Ext | undefined;

  constructor(args: { provider: ethers.providers.Provider }) {
    const { provider } = args;
    super();
    this.#provider = provider;
  }

  async #initialize() {
    if (this.#isInit) return;

    const network = await detectNetwork(this.#provider);
    if (!supportedChains.includes(network))
      throw new Error("Provider's network is not supported");
    this.#network = network;

    const addressProviderAddress = ADDRESS_PROVIDER[this.#network];
    const addressProvider = await IAddressProvider__factory.connect(
      addressProviderAddress,
      this.#provider,
    );

    const priceOracleAddress = await addressProvider.getPriceOracle();

    this.#priceOracle = await IPriceOracleV2Ext__factory.connect(
      priceOracleAddress,
      this.#provider,
    );

    this.#isInit = true;
  }

  // https://www.google.com/url?q=https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-add-price-feed.ts&sa=D&source=editors&ust=1691738002067810&usg=AOvVaw2fg8wQnqVDmcWcS_URJtpg
  async addPriceFeed(token: SupportedToken, priceFeed: Address, force = false) {
    await this.#initialize();

    this.logger.info(
      `PriceOracle: addPriceFeed ${priceFeed} for token ${token}`,
    );

    const validationResult = await this.addPriceFeedValidate(token, priceFeed);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    const tokenAddress = tokenDataByNetwork[this.#network!][token];

    return this.createTx({
      contract: this.#priceOracle!,
      method: "addPriceFeed(address,address)",
      args: [tokenAddress, priceFeed],
      validationResult: validationResult,
    });
  }

  async addPriceFeedValidate(token: SupportedToken, priceFeed: string) {
    await this.#initialize();

    this.logger.info(
      `PriceOracle: validate addPriceFeed ${priceFeed} for token ${token}`,
    );
    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const identityCheckResult = await isContractIdentical(priceFeed);
    if (!identityCheckResult.identical) {
      validationResult.errors.push(
        `Address ${priceFeed} is not identical to github repo, error: ${identityCheckResult.error}`,
      );
    }

    // check if priceFeed is address of priceFeed contract
    const priceFeedContract = AggregatorV3Interface__factory.connect(
      priceFeed,
      this.#provider,
    );

    // todo check if contract is verified and similar to github - error if not
    try {
      const decimals = await priceFeedContract.decimals();
      if (decimals.toString() !== "8") {
        validationResult.errors.push(
          `Price feed ${priceFeed} has invalid decimals ${decimals.toString()}`,
        );
      }
    } catch (e) {
      validationResult.errors.push(
        `Price feed ${priceFeed} is not valid address`,
      );
    }

    return validationResult;
  }
}