import axios from "axios";

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

export interface CommitLink {
  type: "commit";
  commit: string;
  report: Report;
}
export interface BranchLink {
  type: "branch";
  branch: string;
  comment?: string;
}

export const repos = [
  "core-v3",
  "core-v2",
  "integrations-v2",
  "integrations-v3",
  "governance",
  "contracts-v2",
] as const;

export type Repo = (typeof repos)[number];

export type Audits = Record<
  (typeof repos)[number],
  Array<CommitLink | BranchLink>
>;

export enum Auditor {
  ChainSecurity = "ChainSecurity",
  Consensys = "Consensys Diligence",
  SigmaPrime = "Sigma Prime",
}

export interface Report {
  auditor: Auditor;
  reportLink: string;
}

const reports: Record<string, Report> = {
  "2022_Oct_Chainsec": {
    auditor: Auditor.ChainSecurity,
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2022%20Oct%20-%20ChainSecurity%20report.pdf",
  },
  "2022_Sep_Consensys": {
    auditor: Auditor.Consensys,
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2022%20Sep%20-%20Consensys%20Diligence.pdf",
  },
  "2023_Apr_ChainSec": {
    auditor: Auditor.ChainSecurity,
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Apr%20-%20Chainsecurity%20v2.1%20.pdf",
  },
  "2022_Aug_Sigma": {
    auditor: Auditor.SigmaPrime,
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2022%20Aug%20-%20SigmaPrime_Gearbox_Smart_Contract_Security_Assessment_Report_v2.pdf",
  },
  "2023_Aug_ChainSec": {
    auditor: Auditor.ChainSecurity,
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Aug%20-%20ChainSecurity_V2.1.pdf",
  },
  "2023_Sep_ChainSec": {
    auditor: Auditor.ChainSecurity,
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Sep%20-%20ChainSecurity_Gearbox_Protocol_Gearbox_V2_1_audit.pdf",
  },
  "2023_Oct_ChainSec": {
    auditor: Auditor.ChainSecurity,
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Oct%20-%20ChainSecurity_Gearbox_Protocol_Gearbox_V3_Core_audit_draft_2.pdf",
  },
};

export const audits: Audits = {
  "core-v3": [
    {
      type: "commit",
      commit: "519647cc73f74db3af3730549e450e19e994d0d8",
      report: reports["2023_Oct_ChainSec"],
    },
  ],
  "core-v2": [
    {
      type: "commit",
      commit: "c6ca919d46dcd82fa69c89316d9ff969e89bd3f6",
      report: reports["2022_Oct_Chainsec"],
    },
    {
      type: "commit",
      commit: "2f01dcaa2512a4f51157bacce45544c51e5033b3",
      report: reports["2023_Apr_ChainSec"],
    },
    {
      type: "commit",
      commit: "98a984d37fa590e89ff976fe9e2a523b217d50ef",
      report: reports["2023_Sep_ChainSec"],
    },
  ],
  "integrations-v2": [
    {
      type: "commit",
      commit: "c7290c3ef917f456653e7d5151dc610f338a0805",
      report: reports["2022_Sep_Consensys"],
    },
    {
      type: "commit",
      commit: "e0d628447c3916f70d34a033e5571b730c88574f",
      report: reports["2023_Apr_ChainSec"],
    },
  ],
  "integrations-v3": [
    {
      type: "commit",
      commit: "e34cfbe9fb7e3b41121acce1911c4484ca60e211",
      report: reports["2023_Apr_ChainSec"],
    },
    {
      type: "commit",
      commit: "02f239fee250fb11b16a28974e71e73264de50b2",
      report: reports["2023_Aug_ChainSec"],
    },
  ],
  governance: [
    {
      type: "branch",
      branch: "master",
      comment: "Uniswap/governance fork",
    },
  ],
  "contracts-v2": [
    {
      type: "commit",
      commit: "0f500f03bf924715fb88844d942837a914b16b5b",
      report: reports["2022_Aug_Sigma"],
    },
  ],
};

export interface VerifyRequest {
  address: string;
  constructorArguments: Array<any>;
}

export interface EtherscanSource {
  sources: Record<
    string,
    {
      content: string;
    }
  >;
}

export interface ReportVerificationResult {
  audit?: CommitLink | BranchLink;
  identical?: boolean;
  githubUrl: string;
}

export interface ContractCheckResult {
  contract: string;
  reportsVerificationResult: Array<ReportVerificationResult>;
}

export interface FullContractAndImportsResult {
  contractName: string;
  sources: Array<ContractCheckResult>;
}

export type GithubCheckResponse =
  | (FullContractAndImportsResult & {
      found: true;
    })
  | { found: false };

interface VerifiedResponse {
  data?: EtherscanContract[];
  verified: boolean;
}

// eslint-disable-next-line no-promise-executor-return
const sleep = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

export class GithubChecker {
  protected readonly _audits = audits;
  protected readonly baseURL = "https://risk.gearbox.foundation";

  public async compareWithGithub(
    address: string,
  ): Promise<FullContractAndImportsResult> {
    // console.log(`Checking contracts from ${address}`)
    const url = `${this.baseURL}/api/contracts/verified?address=${address}&returnContracts=true`;
    const source = await axios.get<VerifiedResponse>(url);
    if (!source.data) {
      throw new Error(`cannot get verified contract at ${address}`);
    }
    if (!source.data.verified) {
      throw new Error(`contract not verified at ${address}`);
    }
    const mainContractName = source.data.data?.[0]?.ContractName;
    if (!mainContractName) {
      throw new Error(`cannot find main contract name for ${address}`);
    }

    const fullContractSourcesCheckResult: FullContractAndImportsResult = {
      contractName: mainContractName,
      sources: [],
    };

    const etherscanResponse = (source.data.data as Array<any>).map(
      c => c.SourceCode,
    );

    let etherscanData: EtherscanSource;
    try {
      etherscanData = JSON.parse(
        etherscanResponse[0].substr(1, etherscanResponse[0].length - 2),
      );
    } catch (error) {
      throw new Error(`Etherscan Response is not valid JSON`);
    }

    for (let [entry, data] of Object.entries(etherscanData.sources)) {
      console.log("checking entry", entry);

      if (!entry.startsWith("@gearbox-protocol")) continue;

      // console.log("checking entry", entry);

      const contract = entry.split("/").pop();

      if (contract === undefined) {
        throw new Error(`Can't get contract name from ${entry}`);
      }

      const contractNameWithSol = entry.split("/").pop();
      // console.log("contractNameWithSol", contractNameWithSol);
      if (!contractNameWithSol) {
        continue;
      }

      // const contractName = contractNameWithSol.replace(".sol", "");

      // if (contractName !== mainContractName) continue;

      const repoName = entry.split("/")[1];

      // console.log("repoName", repoName);

      const contractCheckResult: ContractCheckResult = {
        contract,
        reportsVerificationResult: [],
      };

      if (!(repoName in this._audits)) {
        continue;
      }

      const repo = repoName as Repo;
      const audits = this._audits[repo];

      for (const audit of audits) {
        console.log("checking audit", audit, "for entry", entry);

        // if (
        //   audit.type === "commit" &&
        //   audit.commit === "c6ca919d46dcd82fa69c89316d9ff969e89bd3f6"
        // )
        //   continue;

        let replacementPath: string;

        if (audit.type === "commit") {
          replacementPath = `${repo}/${audit.commit}`;
        } else {
          replacementPath = `${repo}/${audit.branch}`;
        }

        const githubRawUrl = entry
          .replace(
            "@gearbox-protocol",
            "https://raw.githubusercontent.com/Gearbox-protocol",
          )
          .replace(repo, replacementPath);

        console.log("githubRawUrl", githubRawUrl);

        let githubSource: string;

        try {
          githubSource = await this.getGithubSource(githubRawUrl);
          await sleep(1000);
        } catch (e) {
          console.error(`get github source error: ${e}`);
          continue;
        }

        console.log("github source downloaded");

        let identical = false;

        if (data.content.trim() !== githubSource.trim()) {
          // const diff = Diff.diffChars(data.content.trim(), githubSource.trim());

          // diff.forEach(part => {
          //   console.log({ part });
          // });

          console.error(`Contract ${entry} is not identical!`);
          // console.info(`Etherscan version:\n${data.content}`);
          // console.info(`Github version:\n${githubSource}`);
        } else {
          identical = true;
          console.debug(`Contract ${entry} is identical with main branch`);
        }

        let result: ReportVerificationResult;

        const githubUrl = githubRawUrl
          .replace("https://raw.githubusercontent.com", "https://github.com")
          .replace(repo, repo + "/blob");

        // console.log("githubUrl", githubUrl);

        console.log("identical", identical);

        if (identical) {
          result = {
            identical: true,
            audit,
            githubUrl,
          };
          contractCheckResult.reportsVerificationResult.push(result);
        } else {
          // result = {
          //   identical: false,
          //   githubUrl: githubUrl,
          // };
        }

        // console.log("result", result);
      }

      fullContractSourcesCheckResult.sources.push(contractCheckResult);
    }

    // console.log(JSON.stringify(fullContractSourcesCheckResult, null, 2));

    return fullContractSourcesCheckResult;
  }

  protected async getGithubSource(url: string): Promise<string> {
    try {
      const githubSource = await axios.get(url);
      return githubSource.data;
    } catch (e) {
      throw new Error(`can't get github file, ${e}`);
    }
  }

  // https://raw.githubusercontent.com/Gearbox-protocol/core-v2/2f01dcaa2512a4f51157bacce45544c51e5033b3/contracts/core/access/Claimable.sol

  protected _baseUrl(networkName: string): String {
    switch (networkName) {
      case "mainnet":
        return "https://api.etherscan.io";
      case "goerli":
        return "https://api-goerli.etherscan.io";
      default:
        throw new Error(`${networkName} is not supported`);
    }
  }
}
