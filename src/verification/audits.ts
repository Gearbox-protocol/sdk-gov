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
  Decurity = "Decurity",
}

export interface Report {
  auditor: Auditor;
  revision: string;
  reportLink: string;
}

export const auditReports: Record<string, Report> = {
  "2022_Oct_Chainsec": {
    auditor: Auditor.ChainSecurity,
    revision: "2022 October",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2022%20Oct%20-%20ChainSecurity%20report.pdf",
  },
  "2022_Sep_Consensys": {
    auditor: Auditor.Consensys,
    revision: "2022 September",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2022%20Sep%20-%20Consensys%20Diligence.pdf",
  },
  "2023_Apr_ChainSec": {
    auditor: Auditor.ChainSecurity,
    revision: "2023 April",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Apr%20-%20Chainsecurity%20v2.1%20.pdf",
  },
  "2022_Aug_Sigma": {
    auditor: Auditor.SigmaPrime,
    revision: "2022 August",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2022%20Aug%20-%20SigmaPrime_Gearbox_Smart_Contract_Security_Assessment_Report_v2.pdf",
  },
  "2023_Aug_ChainSec": {
    auditor: Auditor.ChainSecurity,
    revision: "2023 August",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Aug%20-%20ChainSecurity_V2.1.pdf",
  },
  "2023_Sep_ChainSec": {
    auditor: Auditor.ChainSecurity,
    revision: "2023 September",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Sep%20-%20ChainSecurity_Gearbox_Protocol_Gearbox_V2_1_audit.pdf",
  },
  "2023_Oct_ChainSec": {
    auditor: Auditor.ChainSecurity,
    revision: "2023 October",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Oct%20-%20ChainSecurity_Gearbox_Protocol_Gearbox_V3_Core_audit_draft_2.pdf",
  },
  "2023_Dec_Decurity": {
    auditor: Auditor.Decurity,
    revision: "2023 December",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Dec%20-%20Decurity_Governor_Report.pdf",
  },
  "2023_Dec_ChainSecurity_Governance": {
    auditor: Auditor.ChainSecurity,
    revision: "2023 December",
    reportLink: "",
  },
  "2023_Dec_ChainSecurity_CoreV3": {
    auditor: Auditor.ChainSecurity,
    revision: "2023 December",
    reportLink: "",
  },
};

export const audits: Audits = {
  "core-v3": [
    {
      type: "commit",
      commit: "519647cc73f74db3af3730549e450e19e994d0d8",
      report: auditReports["2023_Oct_ChainSec"],
    },
    {
      type: "commit",
      commit: "e16559ae82f0f24c3dc29693c444f40d676ebff9",
      report: auditReports["2023_Dec_ChainSecurity_CoreV3"],
    },
  ],
  "core-v2": [
    {
      type: "commit",
      commit: "c6ca919d46dcd82fa69c89316d9ff969e89bd3f6",
      report: auditReports["2022_Oct_Chainsec"],
    },
    {
      type: "commit",
      commit: "2f01dcaa2512a4f51157bacce45544c51e5033b3",
      report: auditReports["2023_Apr_ChainSec"],
    },
    {
      type: "commit",
      commit: "98a984d37fa590e89ff976fe9e2a523b217d50ef",
      report: auditReports["2023_Sep_ChainSec"],
    },
  ],
  "integrations-v2": [
    {
      type: "commit",
      commit: "c7290c3ef917f456653e7d5151dc610f338a0805",
      report: auditReports["2022_Sep_Consensys"],
    },
    {
      type: "commit",
      commit: "e0d628447c3916f70d34a033e5571b730c88574f",
      report: auditReports["2023_Apr_ChainSec"],
    },
  ],
  "integrations-v3": [
    {
      type: "commit",
      commit: "e34cfbe9fb7e3b41121acce1911c4484ca60e211",
      report: auditReports["2023_Apr_ChainSec"],
    },
    {
      type: "commit",
      commit: "02f239fee250fb11b16a28974e71e73264de50b2",
      report: auditReports["2023_Aug_ChainSec"],
    },
  ],
  governance: [
    {
      type: "commit",
      commit: "c90434702c163f3f1c2cb4db90cece525160ee07",
      report: auditReports["2023_Nov_Decurity"],
    },
    {
      type: "commit",
      commit: "c90434702c163f3f1c2cb4db90cece525160ee07",
      report: auditReports["2023_Dec_ChainSecurity_Governance"],
    },
  ],
  "contracts-v2": [
    {
      type: "commit",
      commit: "0f500f03bf924715fb88844d942837a914b16b5b",
      report: auditReports["2022_Aug_Sigma"],
    },
  ],
};
