import {
  Contract,
  Interface,
  Overrides,
  Provider,
  Result,
  Signer,
} from "ethers";

import { Address } from "./types";

export const MULTICALL_ADDRESS: Address =
  "0xcA11bde05977b3631167028862bE2a173976CA11";

const _abi = [
  {
    inputs: [
      {
        components: [
          {
            internalType: "address",
            name: "target",
            type: "address",
          },
          {
            internalType: "bytes",
            name: "callData",
            type: "bytes",
          },
        ],
        internalType: "struct Multicall2.Call[]",
        name: "calls",
        type: "tuple[]",
      },
    ],
    name: "aggregate",
    outputs: [
      {
        internalType: "uint256",
        name: "blockNumber",
        type: "uint256",
      },
      {
        internalType: "bytes[]",
        name: "returnData",
        type: "bytes[]",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },

  {
    inputs: [
      {
        internalType: "bool",
        name: "requireSuccess",
        type: "bool",
      },
      {
        components: [
          {
            internalType: "address",
            name: "target",
            type: "address",
          },
          {
            internalType: "bytes",
            name: "callData",
            type: "bytes",
          },
        ],
        internalType: "struct Multicall2.Call[]",
        name: "calls",
        type: "tuple[]",
      },
    ],
    name: "tryAggregate",
    outputs: [
      {
        components: [
          {
            internalType: "bool",
            name: "success",
            type: "bool",
          },
          {
            internalType: "bytes",
            name: "returnData",
            type: "bytes",
          },
        ],
        internalType: "struct Multicall2.Result[]",
        name: "returnData",
        type: "tuple[]",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
];

export const multicallInterface = new Interface(_abi);

interface MulticallResult {
  success: boolean;
  returnData: string;
}

export interface CallData<T extends Interface> {
  method: Parameters<T["getFunctionName"]>[0];
  params?: any;
}

export interface MCall<T extends Interface> {
  address: string;
  interface: T;
  method: Parameters<T["getFunctionName"]>[0];
  params?: any;
}

export interface KeyedCall<T extends Interface, K = string> extends MCall<T> {
  key: K;
}

export async function multicall<R extends Array<any>>(
  calls: Array<MCall<any>>,
  p: Signer | Provider,
  overrides?: Overrides,
): Promise<R> {
  const multiCallContract = new Contract(
    MULTICALL_ADDRESS,
    multicallInterface,
    p,
  );

  const { returnData } = await multiCallContract.aggregate.staticCall(
    calls.map(c => ({
      target: c.address,
      callData: c.interface.encodeFunctionData(c.method, c.params),
    })),
    overrides || {},
  );

  const result = (returnData as Array<string>).map((d, num) => {
    const r = calls[num].interface.decodeFunctionResult(
      calls[num].method,
      d,
    ) as Result;

    return unwrapArray(r);
  }) as R;

  return result;
}

/**
 * Like multicall from sdk, but uses tryAggregate instead of aggregate
 * @param calls
 * @param p
 * @param overrides
 * @returns
 */
export async function safeMulticall<V = any, T extends MCall<any> = MCall<any>>(
  calls: T[],
  p: Signer | Provider,
  overrides?: Overrides,
): Promise<Array<{ error?: Error; value?: V }>> {
  if (!calls.length) {
    return [];
  }
  const multiCallContract = new Contract(
    MULTICALL_ADDRESS,
    multicallInterface,
    p,
  );

  const resp = await multiCallContract.tryAggregate.staticCall(
    false,
    calls.map(c => ({
      target: c.address,
      callData: c.interface.encodeFunctionData(c.method, c.params),
    })),
    overrides ?? {},
  );

  return (resp as Array<MulticallResult>).map((d, num) => {
    let value: V | undefined;
    let error: Error | undefined;
    if (d.success) {
      try {
        const r = calls[num].interface.decodeFunctionResult(
          calls[num].method,
          d.returnData,
        ) as Result;

        value = unwrapArray(r);
      } catch (e) {
        if (e instanceof Error) {
          error = e;
        } else {
          error = new Error(`${e}`);
        }
      }
    } else {
      error = new Error("multicall call failed");
    }
    return { error, value };
  });
}

function unwrapArray<V>(data: unknown): V {
  if (!data) {
    return data as V;
  }
  if (Array.isArray(data)) {
    return data.length === 1 ? data[0] : data;
  }
  return data as V;
}

export class MultiCallContract<T extends Interface> {
  private readonly _address: string;

  private readonly _interface: T;

  protected _multiCall: Contract;

  constructor(address: string, intrerface: T, provider: Provider | Signer) {
    this._address = address;
    this._interface = intrerface;

    this._multiCall = new Contract(
      MULTICALL_ADDRESS,
      multicallInterface,
      provider,
    );
  }

  async call<R extends Array<any>>(
    data: Array<CallData<T>>,
    overrides?: Overrides,
  ): Promise<R> {
    const { returnData } = await this._multiCall.aggregate.staticCall(
      data.map(c => ({
        target: this._address,
        callData: this._interface.encodeFunctionData(c.method, c.params),
      })),
      overrides || {},
    );

    const result = (returnData as Array<string>).map((d, num) => {
      const r = this._interface.decodeFunctionResult(
        data[num].method,
        d,
      ) as Result;

      const fullR = r.toObject()["result"];
      return fullR;
    }) as R;
    return result;
  }

  get address(): string {
    return this._address;
  }

  get interface(): T {
    return this._interface;
  }
}
