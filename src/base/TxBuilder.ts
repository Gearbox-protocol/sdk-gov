import { BigNumber, Contract } from "ethers";
import { String } from "ts-toolbelt";

import { Logged } from "./Logger";
import { ProposedTransaction, ValidationResult } from "./types";

export class TxBuilder extends Logged {
  constructor() {
    super();
    this.enableLogs();
  }

  createTx<
    T extends Contract,
    U extends string & keyof T["interface"]["functions"],
    V extends Parameters<T[String.Split<U, "(">[0]]>,
  >(callArgs: {
    contract: T;
    method: U;
    args: V;
    validationResult: ValidationResult;
  }): ProposedTransaction {
    const { contract, method, args, validationResult } = callArgs;

    const abi = JSON.parse(
      contract.interface.getFunction(method).format("json")
    );

    const contractFieldsValues: Record<string, string> = {};

    args.forEach((arg, index) => {
      const methodName =
        contract.interface.getFunction(method).inputs[index].name;

      let stringifiedArg: string;

      if (typeof arg === "string" || typeof arg === "number") {
        stringifiedArg = arg.toString();
      } else if (arg instanceof BigNumber) {
        stringifiedArg = arg.toString();
      } else {
        stringifiedArg = JSON.stringify(arg);
      }

      contractFieldsValues[methodName] = stringifiedArg;
    });

    const functionEncodedData = contract.interface.encodeFunctionData(
      method,
      args
    );

    const tx: ProposedTransaction = {
      to: contract.address,
      value: "0",
      contractMethod: {
        inputs: abi.inputs,
        name: abi.name,
        payable: abi.payable,
      },
      contractFieldsValues,
      callData: functionEncodedData,
      validationResult,
    };

    return tx;
  }
}
