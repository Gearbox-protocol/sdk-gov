/**
 * https://docs.etherscan.io/api-endpoints/contracts#get-contract-source-code-for-verified-contract-source-codes
 */
export type EtherscanSourceCodeResp =
  | { status: "1"; message: "OK"; result: EtherscanContract[] }
  | { status: "0"; message: "NOTOK"; result: string };

export interface EtherscanContract {
  SourceCode: string;
  ABI: string;
  ContractName: string;
  CompilerVersion: string;
  OptimizationUsed: string;
  Runs: string;
  ConstructorArguments: string;
  EVMVersion: string;
  Library: string;
  LicenseType: string;
  Proxy: string;
  Implementation: string;
  SwarmSource: string;
}
