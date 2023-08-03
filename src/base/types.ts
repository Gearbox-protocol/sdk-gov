import { SupportedToken } from "@gearbox-protocol/sdk";

export type Address = string;
export type Uint16 = number;

export interface SafeTransaction {
  to: Address;
  value: string;
  data: string;
  operation: number;
}

export function hasDefinedProp<
  Obj extends Partial<Record<string, any>>,
  Prop extends string,
>(
  obj: Obj,
  prop: Prop
): obj is Obj &
  Record<
    Prop,
    Prop extends keyof Obj ? Exclude<Obj[Prop], undefined> : unknown
  > {
  return obj[prop] !== undefined;
}

export type TimelockAction = "queue" | "execute";

export type TxsForSafe = { [k in TimelockAction]: ProposedTransaction[] };

export interface BachTransaction {
  to: string;
  value: string;
  contractMethod: {
    inputs: any[];
    name: string;
    payable: boolean;
  };
  contractInputsValues: Record<string, any>;
}

// Safe related types
export interface ContractMethod {
  inputs: any[];
  name: string;
  payable: boolean;
}

export interface ValidationResult {
  errors: string[];
  warnings: string[];
}

export interface ProposedTransaction {
  to: string;
  value: string;
  contractMethod: ContractMethod;
  contractFieldsValues: Record<string, string>;
  callData: string;
  validationResult: ValidationResult;
}

export interface BatchJson {
  version: string;
  chainId: string;
  createdAt: number;
  meta: BatchFileMeta;
  transactions: BatchTransaction[];
}

export interface BatchFileMeta {
  txBuilderVersion?: string;
  checksum?: string;
  createdFromSafeAddress?: string;
  createdFromOwnerAddress?: string;
  name: string;
  description?: string;
}

export interface BatchTransaction {
  to: string;
  value: string;
  data?: string;
  contractMethod?: ContractMethod;
  contractInputsValues?: { [key: string]: string };
}

export interface ContractInput {
  internalType: string;
  name: string;
  type: string;
}

export interface UnderlyingToken {
  token: SupportedToken | undefined;
  decimals: number | undefined;
}
