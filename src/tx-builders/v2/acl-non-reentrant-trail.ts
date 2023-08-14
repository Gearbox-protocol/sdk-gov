import {
  detectNetwork,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { Contract, ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";

const aclNonReentrantTraitABI = [
  "function setController(address newController) external",
  "function controller() view returns (address)",
];

export class ACLNonReentrantTraitV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  // eslint-disable-next-line no-unused-private-class-members
  #network: NetworkType | undefined;
  #isInit = false;

  #contract: Contract;

  constructor(args: { address: Address; provider: ethers.providers.Provider }) {
    const { provider, address } = args;
    super();
    this.#provider = provider;
    this.#contract = new Contract(
      address,
      aclNonReentrantTraitABI,
      this.#provider,
    );
  }

  async #initialize() {
    if (this.#isInit) return;

    const network = await detectNetwork(this.#provider);
    if (!supportedChains.includes(network))
      throw new Error("Provider's network is not supported");
    this.#network = network;

    // check if address is aclNonReentrantTrait
    try {
      await this.#contract.controller();
    } catch {
      throw new Error(
        "This address is not aclNonReentrantTrait contract, no controller()",
      );
    }

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-controller.ts
  async setController(newController: Address, force = false) {
    await this.#initialize();

    this.logger.info(
      `ACLNonReentrantTrait ${
        this.#contract.address
      }: setController ${newController}`,
    );

    const validationResult = await this.setControllerValidate(newController);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#contract!,
      method: "setController(address)",
      args: [newController],
      validationResult: validationResult,
    });
  }

  async setControllerValidate(newController: Address) {
    await this.#initialize();

    this.logger.info(
      `ACLNonReentrantTrait ${
        this.#contract.address
      }: validating setController ${newController}`,
    );

    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // todo what to validate?

    return validationResult;
  }
}
