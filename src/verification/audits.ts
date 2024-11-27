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
  "bots-v3",
  "contracts-v2",
  "core-v2",
  "core-v3",
  "governance",
  "integrations-v2",
  "integrations-v3",
  "oracles-v3",
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
  Pessimistic = "Pessimistic",
  Watchpug = "Watchpug",
}

export interface Report {
  auditor: Auditor;
  revision: string;
  reportLink: string;
  /**
   * Some are just reports, not "hard" audits
   */
  isNotSecurityAudit?: boolean;
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
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Dec%20-%20ChainSecurity_Gearbox_Gearbox_V3_Governance_audit.pdf",
  },
  "2023_Dec_ChainSecurity_CoreV3": {
    auditor: Auditor.ChainSecurity,
    revision: "2023 December",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Dec%20-%20ChainSecurity_Gearbox_Protocol_Gearbox_V3_Core_audit.pdf",
  },
  "2023_Dec_ChainSecurity_IntegrationsV3": {
    auditor: Auditor.ChainSecurity,
    revision: "2023 December",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Dec%20-%20ChainSecurity_Gearbox_Protocol_Gearbox_V3_Integrations_audit.pdf",
  },
  "2023_Dec_ChainSecurity_OraclesV3": {
    auditor: Auditor.ChainSecurity,
    revision: "2023 December",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2023%20Dec%20-%20ChainSecurity_Gearbox_Protocol_Gearbox_V3_Oracles_audit.pdf",
  },
  "2024_Feb_ChainSecurity_CoreV3": {
    auditor: Auditor.ChainSecurity,
    revision: "2024 February",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2024%20Feb%20-%20ChainSecurity_Gearbox_Core_V3.pdf",
  },
  "2024_Mar_ChainSecurity_CoreV3": {
    auditor: Auditor.ChainSecurity,
    revision: "2024 March",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2024%20Mar%20-%20ChainSecurity_Gearbox_Core_V3.pdf",
  },
  "2024_May_Pessimistic": {
    auditor: Auditor.Pessimistic,
    revision: "2024 May",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/reports/2024%20May%20-%20Pessimistic_Gearbox_Security_Scan.pdf",
    isNotSecurityAudit: true,
  },
  "2024_Aug_ChainSecutiry_Oracles_V3": {
    auditor: Auditor.ChainSecurity,
    revision: "2024 Aug",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2024%20Aug%20-%20ChainSecurity_Gearbox_Oracles_V3.pdf",
  },
  "2024_Aug_Decurity_Pendle_Mellow": {
    auditor: Auditor.Decurity,
    revision: "2024 Aug",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2024%20Aug%20-%20Decurity_Gearbox_Pendle_Mellow.pdf",
  },
  "2024_Oct_Decurity_SKY": {
    auditor: Auditor.Decurity,
    revision: "2024 Oct",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2024%20Oct%20-%20Decurity_Gearbox_SKY_integration.pdf",
  },
  "2024_Oct_Watchpug_Pendle": {
    auditor: Auditor.Watchpug,
    revision: "2024 Oct",
    reportLink:
      "https://github.com/Gearbox-protocol/security/blob/main/audits/2024%20Oct%20-%20Watchpug_Pendle_oracle.pdf",
  },
};

export const audits: Audits = {
  "bots-v3": [
    {
      type: "commit",
      commit: "dc7fe47f5b0c05d24f8349ed41bdd72f4989bf40",
      report: auditReports["2024_May_Pessimistic"],
    },
  ],
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
    {
      type: "commit",
      commit: "27d05440deddb1af3f0505c5fc14721d637353f0",
      report: auditReports["2024_Feb_ChainSecurity_CoreV3"],
    },
    {
      type: "commit",
      commit: "9db98f7bb7876e40181a7235ca3a12dcfc08852a",
      report: auditReports["2024_Mar_ChainSecurity_CoreV3"],
    },
    {
      type: "commit",
      commit: "b2628d77f17fecf71feb77ebb038d5350f26fca7",
      report: auditReports["2024_Mar_ChainSecurity_CoreV3"],
    },
    {
      type: "commit",
      commit: "b2628d77f17fecf71feb77ebb038d5350f26fca7",
      report: auditReports["2024_May_Pessimistic"],
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
    {
      type: "commit",
      commit: "302c635e67c0017f5f7d91d9c4c56199c624c4f6",
      report: auditReports["2023_Dec_ChainSecurity_IntegrationsV3"],
    },
    {
      type: "commit",
      commit: "8f1ae29e14fa9c918b87e9ed9a2a6e93f3654dbe",
      report: auditReports["2024_May_Pessimistic"],
    },
    {
      type: "commit",
      commit: "247e7b69cb39f736358de8b0ec6b7f36bc8ec53f",
      report: auditReports["2024_Aug_Decurity_Pendle_Mellow"],
    },
    {
      type: "commit",
      commit: "7ca0f2196d643e3196f78204db9400f91c1d5c5a",
      report: auditReports["2024_Oct_Decurity_SKY"],
    },
    {
      type: "commit",
      commit: "e3e558df565f3541ca90a2afd40d9e76eded2fa9",
      report: auditReports["2024_Oct_Decurity_SKY"],
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
  "oracles-v3": [
    {
      type: "commit",
      commit: "c6e4bd0a42331daeec599f3d8a688fab79f9879a",
      report: auditReports["2023_Dec_ChainSecurity_OraclesV3"],
    },
    {
      type: "commit",
      commit: "c6e4bd0a42331daeec599f3d8a688fab79f9879a",
      report: auditReports["2024_May_Pessimistic"],
    },
    {
      type: "commit",
      commit: "9fa370b78bf3880f02f3c410e52abe21acc345da",
      report: auditReports["2024_Aug_ChainSecutiry_Oracles_V3"],
    },
    {
      type: "commit",
      commit: "e2357489a6f39d9f1862f854e6ef66f894adc63e",
      report: auditReports["2024_Aug_Decurity_Pendle_Mellow"],
    },
    {
      type: "commit",
      commit: "593aba9c41c374152e1fa57101f186a58e79c6c3", // v3.1
      report: auditReports["2024_Oct_Watchpug_Pendle"],
    },
    {
      type: "commit",
      commit: "044a7059d3c098900dac8c240bc7ec4102240add", // v3.0
      report: auditReports["2024_Oct_Watchpug_Pendle"],
    },
    {
      type: "commit",
      commit: "38b3a3461143af50d14c0b34f163ad3e774ade6f",
      report: auditReports["2024_Oct_Decurity_SKY"],
    },
  ],
};
