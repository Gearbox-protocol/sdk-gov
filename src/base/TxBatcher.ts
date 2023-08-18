import { getNetworkType, MULTISIG } from "@gearbox-protocol/sdk";
import { utils } from "web3";

import {
  BatchJson,
  BatchTransaction,
  ProposedTransaction,
  TimelockAction,
} from "./types";

export class TxBatcher {
  #eta = 0;
  #description = "";
  #chainId = 0;
  #multisigAddress = "";
  txs: ProposedTransaction[] = [];

  setEta(eta: number) {
    this.#eta = eta;
    return this;
  }

  setEtaDays(etaDays: number) {
    const eta = Math.floor(Date.now() / 1000) + etaDays * 24 * 60 * 60;
    this.#eta = eta;
    return this;
  }

  setDescription(description: string) {
    this.#description = description;
    return this;
  }

  addTx(tx: ProposedTransaction) {
    this.txs.push(tx);
    return this;
  }

  /// @dev Set the chainId and multisig address to use for the batch
  setChainId(chainId: number) {
    this.#chainId = chainId;
    const network = getNetworkType(chainId);
    this.#multisigAddress = MULTISIG[network];
    return this;
  }

  /// @dev Set custom multisig address to use for the batch
  setCustomMultisigAddress(multisigAddress: string) {
    this.#multisigAddress = multisigAddress;
    return this;
  }

  #generateBatch(action: TimelockAction) {
    if (!this.#chainId) {
      throw new Error("ChainId not set");
    }

    if (!this.#description) {
      throw new Error("Description not set");
    }

    if (!this.#eta) {
      throw new Error("ETA not set");
    }

    if (!this.txs.length) {
      throw new Error("No transactions added");
    }

    const batch = this.#addChecksum(
      this.#generateBatchFile({
        name: `${action}.json`,
        description: this.#description,
        transactions: this.txs,
        chainId: this.#chainId,
        safeAddress: this.#multisigAddress,
        action,
        eta: this.#eta,
      }),
    );

    return batch;
  }

  /// @dev Generate a batch file for the queue action
  /// @return batch json
  exportQueueBatch() {
    return this.#generateBatch("queue");
  }

  exportExecuteBatch() {
    return this.#generateBatch("execute");
  }

  // Private checksum calculation related methods from safe ui app code
  #addChecksum(batchJson: BatchJson): BatchJson {
    return {
      ...batchJson,
      meta: {
        ...batchJson.meta,
        checksum: this.#calculateChecksum(batchJson),
      },
    };
  }

  #calculateChecksum = (batchJson: BatchJson): string | undefined => {
    const serialized = this.#serializeJSONObject({
      ...batchJson,
      meta: { ...batchJson.meta, name: null },
    });
    const sha = utils.sha3(serialized);

    return sha || undefined;
  };

  #serializeJSONObject = (json: any): string => {
    if (Array.isArray(json)) {
      return `[${json.map(el => this.#serializeJSONObject(el)).join(",")}]`;
    }

    if (typeof json === "object" && json !== null) {
      let acc = "";
      const keys = Object.keys(json).sort();
      acc += `{${JSON.stringify(keys, this.#stringifyReplacer)}`;

      for (const key of keys) {
        acc += `${this.#serializeJSONObject(json[key])},`;
      }

      return `${acc}}`;
    }

    return `${JSON.stringify(json, this.#stringifyReplacer)}`;
  };

  #stringifyReplacer(_: string, value: any) {
    return value === undefined ? null : value;
  }

  #generateBatchFile({
    name,
    description,
    transactions,
    chainId,
    safeAddress,
    action,
    eta,
  }: {
    name: string;
    description: string;
    transactions: ProposedTransaction[];
    chainId: number;
    safeAddress?: string;
    action: TimelockAction;
    eta: number;
  }): BatchJson {
    return {
      version: "1.0",
      chainId: `${chainId}`,
      createdAt: Date.now(),
      meta: {
        name,
        description,
        txBuilderVersion: "1.16.0",
        createdFromSafeAddress: safeAddress ?? process.env.MULTISIG,
        createdFromOwnerAddress: "",
      },
      transactions: transactions.map(tx => this.#wrapTimelock(tx, action, eta)),
    };
  }

  #wrapTimelock(
    tx: ProposedTransaction,
    action: TimelockAction,
    eta: number,
  ): BatchTransaction {
    return {
      to: "0xa133C9A92Fb8dDB962Af1cbae58b2723A0bdf23b",
      value: "0",
      contractMethod: {
        inputs: [
          {
            type: "address",
            name: "target",
            internalType: "address[]",
          },
          {
            type: "uint256",
            name: "value",
          },
          {
            type: "string",
            name: "signature",
          },
          {
            type: "bytes",
            name: "data",
          },
          {
            type: "uint256",
            name: "eta",
          },
        ],
        name: action === "queue" ? "queueTransaction" : "executeTransaction",
        payable: true,
      },
      contractInputsValues: {
        target: tx.to,
        value: "0",
        signature: tx.contractMethod,
        data: "0x" + tx.callData.slice(10),
        eta: eta.toString(),
      },
    };
  }
}
