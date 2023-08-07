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

import { TxBuilder } from "../../base/TxBuilder";
import { ValidationResult } from "../../base/types";

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
      this.#provider
    );

    const priceOracleAddress = await addressProvider.getPriceOracle();
    this.#priceOracle = await IPriceOracleV2Ext__factory.connect(
      priceOracleAddress,
      this.#provider
    );

    this.#isInit = true;
  }

  async addPriceFeed(token: SupportedToken, priceFeed: string, force = false) {
    this.logger.info(`Adding price feed ${priceFeed} for token ${token}`);
    await this.#initialize();

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

  async addPriceFeedValidate(_token: SupportedToken, priceFeed: string) {
    this.logger.info(`Validating price feed ${priceFeed} for token ${_token}`);
    await this.#initialize();
    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    // check if priceFeed is address of priceFeed contract
    const priceFeedContract = AggregatorV3Interface__factory.connect(
      priceFeed,
      this.#provider
    );

    // todo check if contract is verified and similar to github - error if not
    try {
      const decimals = await priceFeedContract.decimals();
      if (decimals.toString() !== "8") {
        validationResult.errors.push(
          `Price feed ${priceFeed} has invalid decimals ${decimals.toString()}`
        );
      }
    } catch (e) {
      validationResult.errors.push(
        `Price feed ${priceFeed} is not valid address`
      );
    }

    return validationResult;
  }
}
