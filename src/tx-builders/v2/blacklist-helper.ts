import {
  BlacklistHelper,
  BlacklistHelper__factory,
  CreditFacade__factory,
} from "@gearbox-protocol/core-v2/types";
import {
  detectNetwork,
  NetworkType,
  supportedChains,
  tokenDataByNetwork,
} from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";
import { IsContract } from "../../base/utils";

export class BlacklistHelperV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  #network: NetworkType | undefined;
  #isInit = false;

  #blacklistHelper: BlacklistHelper;

  constructor(args: { address: string; provider: ethers.providers.Provider }) {
    const { address, provider } = args;
    super();
    this.#provider = provider;
    this.#blacklistHelper = BlacklistHelper__factory.connect(address, provider);
  }

  async #initialize() {
    if (this.#isInit) return;

    const network = await detectNetwork(this.#provider);
    if (!supportedChains.includes(network))
      throw new Error("Provider's network is not supported");
    this.#network = network;

    // Check if contract is blacklistHelper
    // It has valid usdc, usdt and version = 300 properties
    const usdt = await this.#blacklistHelper.usdt();
    if (usdt !== tokenDataByNetwork[this.#network].USDT)
      throw new Error(
        "This address is not blacklistHelper contract, wrong USDT address",
      );

    const usdc = await this.#blacklistHelper.usdc();
    if (usdc !== tokenDataByNetwork[this.#network].USDC)
      throw new Error(
        "This address is not blacklistHelper contract, wrong USDC address",
      );

    const version = await this.#blacklistHelper.version();
    if (!version.eq(ethers.BigNumber.from(300)))
      throw new Error(
        `This address is not blacklistHelper contract, got wrong version ${version} instead of 300`,
      );

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-add-cf-to-blacklist-helper.ts
  async addCreditFacade(creditFacade: Address, force = false) {
    await this.#initialize();

    this.logger.info(`BlacklistHelper: addCreditFacade ${creditFacade}`);

    const validationResult = await this.addCreditFacadeValidate(creditFacade);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    return this.createTx({
      contract: this.#blacklistHelper,
      method: "addCreditFacade(address)",
      args: [creditFacade],
      validationResult: validationResult,
    });
  }

  async addCreditFacadeValidate(creditFacade: Address) {
    await this.#initialize();
    this.logger.info(
      `BlacklistHelper: Validating addCreditFacade ${creditFacade}`,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    const isContract = await IsContract(creditFacade, this.#provider);
    if (!isContract) {
      validationResult.errors.push(`Address ${creditFacade} is not a contract`);
    }

    const creditFacadeContract = CreditFacade__factory.connect(
      creditFacade,
      this.#provider,
    );

    // check if this is CreditFacade and has creditManager public propetry
    try {
      await creditFacadeContract.creditManager();
    } catch (e) {
      validationResult.errors.push(
        `Address ${creditFacade} does not have creditManager propetry, is not CreditFacade`,
      );
    }

    // check if creditFacade isBlacklistableUnderlying
    const isBlacklistableUnderlying =
      await creditFacadeContract.isBlacklistableUnderlying();

    if (!isBlacklistableUnderlying) {
      validationResult.errors.push(
        `CreditFacade ${creditFacade} is not blacklistable`,
      );
    }

    return validationResult;
  }
}
