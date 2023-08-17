import {
  AccountFactory,
  AccountFactory__factory,
  CreditAccount__factory,
  CreditManager__factory,
  ERC20__factory,
} from "@gearbox-protocol/core-v2";
import {
  detectNetwork,
  NetworkType,
  supportedChains,
  SupportedToken,
} from "@gearbox-protocol/sdk";
import { ethers } from "ethers";

import { TxBuilder } from "../../base/TxBuilder";
import { Address, TxValidationResult } from "../../base/types";

export class AcountFactoryV2TxBuilder extends TxBuilder {
  #provider: ethers.providers.Provider;
  // eslint-disable-next-line no-unused-private-class-members
  #network: NetworkType | undefined;
  #isInit = false;

  #accountFactory: AccountFactory;

  constructor(args: { address: Address; provider: ethers.providers.Provider }) {
    const { provider, address } = args;
    super();
    this.#provider = provider;
    this.#accountFactory = AccountFactory__factory.connect(
      address,
      this.#provider,
    );
  }

  async #initialize() {
    if (this.#isInit) return;

    const network = await detectNetwork(this.#provider);
    if (!supportedChains.includes(network))
      throw new Error("Provider's network is not supported");
    this.#network = network;

    // check if address is AccountFactory, it has head() getter
    try {
      await this.#accountFactory.head();
    } catch {
      throw new Error("This address is not AccountFactory contract, no head()");
    }

    this.#isInit = true;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-cancel-account-allowance.ts
  async cancelAllowance(
    account: Address,
    token: SupportedToken,
    targetContract: Address,
    force = false,
  ) {
    await this.#initialize();

    this.logger.info(
      `Acount ${account}: cancelAllowance of token ${token} for contract ${targetContract}`,
    );

    const validationResult = await this.cancelAllowanceValidate(
      account,
      token,
      targetContract,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#accountFactory!,
      method: "cancelAllowance(address,address,address)",
      args: [account, token, targetContract],
      validationResult: validationResult,
    });
  }

  async cancelAllowanceValidate(
    account: Address,
    token: SupportedToken,
    targetContract: Address,
  ) {
    await this.#initialize();

    this.logger.info(
      `Acount ${account}: validating cancelAllowance of token ${token} for contract ${targetContract}`,
    );
    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // check if account is account, it has creditManager()
    const accountContract = CreditAccount__factory.connect(
      account,
      this.#provider,
    );

    try {
      await accountContract.creditManager();
    } catch {
      validationResult.errors.push(
        `Address ${account} is not a CreditAccount contract, no creditManager() found`,
      );
    }

    // check if allowance exists
    const erc20Contract = ERC20__factory.connect(token, this.#provider);
    const allowance = await erc20Contract.allowance(account, targetContract);

    if (allowance.eq(0)) {
      validationResult.warnings.push(
        `Allowance of token ${token} for contract ${targetContract} is already 0`,
      );
    }

    return validationResult;
  }

  // https://github.com/Gearbox-protocol/risk-framework/blob/main/src/data/actions/sc-take-out-account.ts
  async takeOut(
    prev: Address,
    creditAccount: Address,
    to: Address,
    force = false,
  ) {
    await this.#initialize();

    this.logger.info(
      `AcountFactory: takeOut creditAccount ${creditAccount} with prev ${prev} and to ${to}`,
    );

    const validationResult = await this.takeOutValidate(
      prev,
      creditAccount,
      to,
    );

    if (validationResult.errors.length && !force) throw validationResult;
    if (validationResult.warnings.length)
      this.logger.warn(validationResult.warnings);

    return this.createTx({
      contract: this.#accountFactory!,
      method: "takeOut(address,address,address)",
      args: [prev, creditAccount, to],
      validationResult: validationResult,
    });
  }

  async takeOutValidate(prev: Address, creditAccount: Address, to: Address) {
    await this.#initialize();

    this.logger.info(
      `AcountFactory: validating takeOut creditAccount ${creditAccount} with prev ${prev} and to ${to}`,
    );
    const validationResult: TxValidationResult = {
      errors: [],
      warnings: [],
    };

    // check if creditAccount is in the list
    const isCreditAccount =
      await this.#accountFactory.isCreditAccount(creditAccount);
    if (!isCreditAccount) {
      validationResult.errors.push(
        `Address ${creditAccount} is not a in list of CreditAccounts`,
      );
    }

    // check if prev is in the list
    const isPrevCreditAccount =
      await this.#accountFactory.isCreditAccount(prev);
    if (!isPrevCreditAccount) {
      validationResult.errors.push(
        `Address ${prev} is not a in list of CreditAccounts`,
      );
    }

    // check if 'to' is creditManager
    const creditManagerContract = CreditManager__factory.connect(
      to,
      this.#provider,
    );

    try {
      await creditManagerContract.creditConfigurator();
    } catch {
      validationResult.errors.push(
        `Address ${to} is not a CreditManager contract, no creditConfigurator() found`,
      );
    }

    return validationResult;
  }
}
