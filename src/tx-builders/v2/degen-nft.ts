import {
  AddressProvider,
  AddressProvider__factory,
  ContractsRegister,
  ContractsRegister__factory,
  CreditFacade__factory,
  CreditManager__factory,
  DegenNFT,
  DegenNFT__factory,
} from "@gearbox-protocol/core-v2/types";
import {
  ADDRESS_PROVIDER,
  detectNetwork,
  NetworkType,
  supportedChains,
} from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, ValidationResult } from "../../base/types";
import { IsContract } from "../../base/utils";

export class DegenNFTV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  #network: NetworkType | undefined;
  #isInit = false;

  #degenNFT: DegenNFT;
  #addressProvider: AddressProvider | undefined;
  #contractsRegister: ContractsRegister | undefined;

  constructor(args: { address: string; provider: ethers.providers.Provider }) {
    const { address, provider } = args;
    super();
    this.#provider = provider;
    this.#degenNFT = DegenNFT__factory.connect(address, provider);
  }

  async #initialize() {
    if (this.#isInit) return;

    const network = await detectNetwork(this.#provider);
    if (!supportedChains.includes(network))
      throw new Error("Provider's network is not supported");
    this.#network = network;

    // Check if contract is degenNFT
    // It has minter property

    try {
      await this.#degenNFT.minter();
    } catch {
      throw new Error("This address is not degenNFT contract, no minter()");
    }

    this.#addressProvider = AddressProvider__factory.connect(
      ADDRESS_PROVIDER[this.#network],
      this.#provider,
    );

    const contractRegisterAddress =
      await this.#addressProvider.getContractsRegister();

    this.#contractsRegister = ContractsRegister__factory.connect(
      contractRegisterAddress,
      this.#provider,
    );

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-add-cf-to-dnft.ts
  async addCreditFacade(creditFacade: Address, force = false) {
    await this.#initialize();

    this.logger.info(`DegenNFT: addCreditFacade ${creditFacade}`);

    const validationResult = await this.addCreditFacadeValidate(creditFacade);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    return this.createTx({
      contract: this.#degenNFT,
      method: "addCreditFacade(address)",
      args: [creditFacade],
      validationResult: validationResult,
    });
  }

  async addCreditFacadeValidate(creditFacade: Address) {
    await this.#initialize();
    this.logger.info(`DegenNFT: Validating addCreditFacade ${creditFacade}`);

    const validationResult: ValidationResult = {
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
    let creditManager: Address | undefined;
    try {
      const creditManagerAddress = await creditFacadeContract.creditManager();
      creditManager = creditManagerAddress;
    } catch (e) {
      validationResult.errors.push(
        `Address ${creditFacade} does not have creditManager propetry, is not CreditFacade`,
      );
    }

    // check if creditFacade is already supported
    const isSupportedCreditFacade =
      await this.#degenNFT.isSupportedCreditFacade(creditFacade);

    if (isSupportedCreditFacade) {
      validationResult.warnings.push(
        `CreditFacade ${creditFacade} is already supported`,
      );
    }

    if (!creditManager) {
      validationResult.errors.push(
        `CreditFacade ${creditFacade} does not have creditManager propetry`,
      );
      return validationResult;
    }

    const isCreditManager = await this.#contractsRegister!.isCreditManager(
      creditManager,
    );

    if (!isCreditManager) {
      validationResult.errors.push(
        `CreditFacade ${creditFacade} creditManager ${creditManager} is not registered in ContractsRegister`,
      );
    }

    const facadeDegenNFT = await creditFacadeContract.degenNFT();
    if (facadeDegenNFT !== this.#degenNFT.address) {
      validationResult.errors.push(
        `CreditFacade ${creditFacade} degenNFT ${facadeDegenNFT} is not equal to this degenNFT ${
          this.#degenNFT.address
        }`,
      );
    }

    const creditManagerContract = CreditManager__factory.connect(
      creditManager,
      this.#provider,
    );

    const creditManagerFacade = await creditManagerContract.creditFacade();
    if (creditManagerFacade !== creditFacade) {
      validationResult.errors.push(
        `CreditManager ${creditManager} creditFacade ${creditManagerFacade} is not equal to this creditFacade ${creditFacade}`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-remove-cf-from-dnft.ts
  async removeCreditFacade(creditFacade: Address, force = false) {
    await this.#initialize();

    this.logger.info(`DegenNFT: removeCreditFacade ${creditFacade}`);

    const validationResult = await this.removeCreditFacadeValidate(
      creditFacade,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    return this.createTx({
      contract: this.#degenNFT,
      method: "removeCreditFacade(address)",
      args: [creditFacade],
      validationResult: validationResult,
    });
  }

  async removeCreditFacadeValidate(creditFacade: Address) {
    await this.#initialize();
    this.logger.info(`DegenNFT: Validating removeCreditFacade ${creditFacade}`);

    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    const isSupportedCreditFacade =
      await this.#degenNFT.isSupportedCreditFacade(creditFacade);

    if (!isSupportedCreditFacade) {
      validationResult.warnings.push(
        `CreditFacade ${creditFacade} is not supported`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-dnft-base-uri.ts
  async setBaseUri(baseURI: string, force = false) {
    await this.#initialize();

    this.logger.info(`DegenNFT: setBaseUri ${baseURI}`);

    const validationResult = await this.setBaseUriValidate(baseURI);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    return this.createTx({
      contract: this.#degenNFT,
      method: "setBaseUri(string)",
      args: [baseURI],
      validationResult: validationResult,
    });
  }

  async setBaseUriValidate(baseURI: string) {
    await this.#initialize();
    this.logger.info(`DegenNFT: Validating setBaseUri ${baseURI}`);

    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    // todo what to validate?

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-set-dnft-minter.ts
  async setMinter(minter: Address, force = false) {
    await this.#initialize();

    this.logger.info(`DegenNFT: setMinter ${minter}`);

    const validationResult = await this.setMinterValidate(minter);

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings.toString());

    return this.createTx({
      contract: this.#degenNFT,
      method: "setMinter(address)",
      args: [minter],
      validationResult: validationResult,
    });
  }

  async setMinterValidate(minter: Address) {
    await this.#initialize();
    this.logger.info(`DegenNFT: Validating setMinter ${minter}`);

    const validationResult: ValidationResult = {
      errors: [],
      warnings: [],
    };

    const currentMinter = await this.#degenNFT.minter();

    if (currentMinter === minter) {
      validationResult.warnings.push(
        `Minter ${minter} is already set as minter`,
      );
    }

    return validationResult;
  }
}
