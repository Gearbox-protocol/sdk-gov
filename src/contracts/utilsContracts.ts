import { Address } from "..";
import { NetworkType } from "../core/chains";
import { NOT_DEPLOYED } from "../core/constants";

export const ADDRESS_PROVIDER: Record<NetworkType, Address> = {
  Mainnet: "0x9ea7b04Da02a5373317D745c1571c84aaD03321D",
  Arbitrum: "0x7d04eCdb892Ae074f03B5D0aBA03796F90F3F2af",
  Optimism: "0x3761ca4BFAcFCFFc1B8034e69F19116dD6756726",
  Base: NOT_DEPLOYED,
  Sonic: "0x4b27b296273B72d7c7bfee1ACE93DC081467C41B",
};

export const TIMELOCK: Record<NetworkType, Address> = {
  Mainnet: "0xa133C9A92Fb8dDB962Af1cbae58b2723A0bdf23b",
  Arbitrum: "0x148DD932eCe1155c11006F5650c6Ff428f8D374A",
  Optimism: "0x148DD932eCe1155c11006F5650c6Ff428f8D374A",
  Base: NOT_DEPLOYED,
  Sonic: "0xAdbF876ce58CB65c99b18078353e1DCB16E69e84",
};

export const GOVERNOR: Record<NetworkType, Address> = {
  Mainnet: "0x29B97F37B3E0C704bCFD785F5b7bBa2A0B7df2c7",
  Arbitrum: "0xF0C89a0eDCD68B4176A26B3bf7574498DD3E6d09",
  Optimism: "0xF0C89a0eDCD68B4176A26B3bf7574498DD3E6d09",
  Base: NOT_DEPLOYED,
  Sonic: "0x1f3Ee385ce9A6333d73b61086349C4d0f5De0da8",
};

export const BATCH_CHAIN: Record<NetworkType, Address> = {
  Mainnet: "0xB900bDEf6eAc8C5D97F8e876aBC39573Cf6626b2",
  Arbitrum: "0xAEbaa1015D0bc250F5b38aac9b8f65E0668cE3c2",
  Optimism: "0x5CfB7F186dEA745381ccb1D532e43223B5a6AD10",
  Base: NOT_DEPLOYED,
  Sonic: "0xDe6c55B81442AF66Fd12508e15807fe2b92Be76D",
};

export const BLACKLIST_HELPER: Record<NetworkType, Address> = {
  Mainnet: "0xFfbF344741654a1B9Ab1286Cf05A42f275F67839",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
  Base: NOT_DEPLOYED,
  Sonic: NOT_DEPLOYED,
};

export const CREATE2FACTORY: Record<NetworkType, Address> = {
  Mainnet: "0x45d146CAA25aa565Cfc7434926633f4F1C97c873",
  Arbitrum: "0xad1231A64eE68D6BF721a1E8e177776cc49bAA2C",
  Optimism: "0xad1231A64eE68D6BF721a1E8e177776cc49bAA2C",
  Base: NOT_DEPLOYED,
  Sonic: "0x148DD932eCe1155c11006F5650c6Ff428f8D374A",
};

export const MULTISIG: Record<NetworkType, Address> = {
  Mainnet: "0xA7D5DDc1b8557914F158076b228AA91eF613f1D5",
  Arbitrum: "0x57Fd8B1a9213624157786Fff4a7bc532Ce717773",
  Optimism: "0x8bA8cd6D00919ceCc19D9B4A2c8669a524883C4c",
  Base: NOT_DEPLOYED,
  Sonic: "0xacEB9dc6a81f1C9E2d8a86c3bFec3f6EF584139D",
};

export const VETO_ADMIN: Record<NetworkType, Address> = {
  Mainnet: "0xbb803559B4D58b75E12dd74641AB955e8B0Df40E",
  Arbitrum: "0x746fb3AcAfF6Bfe246206EC2E51F587d2E57abb6",
  Optimism: "0x9744f76dc5239Eb4DC2CE8D5538e1BA89C8FA90f",
  Base: NOT_DEPLOYED,
  Sonic: "0x393eC629b90389F957c5a2E4FC2F8F488e735BFC",
};

export const TREASURY: Record<NetworkType, Address> = {
  Mainnet: "0x7b065fcb0760df0cea8cfd144e08554f3cea73d1",
  Arbitrum: "0x2c31eFFE426765E68A43163A96DD13DF70B53C14",
  Optimism: "0x1ACc5BC353f23B901801f3Ba48e1E51a14263808",
  Base: NOT_DEPLOYED,
  Sonic: "0x74028Cf1cBa6A4513c9a27137E7d0F3847833795",
};

export const ROUTER_MULTISIG_ADDRESS: Record<NetworkType, Address> = {
  Mainnet: "0xaaDf86C39a76eEEf5a5337Ca449C7EfA66E3175E",
  Arbitrum: "0xEAb23245937A4F0894B0c92f08992C2c45Fc8df5",
  Optimism: "0x4cda5Fa96B5d436002175d958667C7EF3B644aA1",
  Base: NOT_DEPLOYED,
  Sonic: "0x21DEE3c9bAc88F8cb96b7e7d19D3DFDB071EC81d",
};

export const ROUTER_CREATE2FACTORY: Record<NetworkType, Address> = {
  Mainnet: "0xA287577Fb7Cf49246e569EA268FE919F1cD6d9E2",
  Arbitrum: "0x95345A4d55DAf6864924fC8861b311B9BC860E5f",
  Optimism: "0x95345A4d55DAf6864924fC8861b311B9BC860E5f",
  Base: NOT_DEPLOYED,
  Sonic: "0x5CfB7F186dEA745381ccb1D532e43223B5a6AD10",
};

export const emergencyLiquidators: Array<Address> = [
  "0x7BD9c8161836b1F402233E80F55E3CaE0Fde4d87",
  "0x16040e932b5Ac7A3aB23b88a2f230B4185727b0d",
];

export const NEXO_MULTISIG: Record<NetworkType, Address> = {
  Mainnet: "0x3655Ae71eB5437F8FbD0187C012e4619064F9B41",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
  Base: NOT_DEPLOYED,
  Sonic: NOT_DEPLOYED,
};

export const NEXO_TREASURY: Record<NetworkType, Address> = {
  Mainnet: "0x349e22baeB15Da6fad00093b3873D5E16d5Bb842",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
  Base: NOT_DEPLOYED,
  Sonic: NOT_DEPLOYED,
};

export const NEXO_ADDRESS_PROVIDER: Record<NetworkType, Address> = {
  Mainnet: "0x2Eb0BE5585E49190414307597912BD039a029Eda",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
  Base: NOT_DEPLOYED,
  Sonic: NOT_DEPLOYED,
};

export const NEXO_TIMELOCK: Record<NetworkType, Address> = {
  Mainnet: "0xdcC3FD83DBF480e8Ad74DD3A634CaE29B68b9814",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
  Base: NOT_DEPLOYED,
  Sonic: NOT_DEPLOYED,
};

export const NEXO_GOVERNOR: Record<NetworkType, Address> = {
  Mainnet: "0x42Cf536467f4fa474010a16f66A3fa7576f987D6",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
  Base: NOT_DEPLOYED,
  Sonic: NOT_DEPLOYED,
};

export const NEXO_BATCH_CHAIN: Record<NetworkType, Address> = {
  Mainnet: "0xcba71ACEDe17d2CABBfADBab30cc08F20eeaca52",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
  Base: NOT_DEPLOYED,
  Sonic: NOT_DEPLOYED,
};

export const NEXO_CREATE2FACTORY: Record<NetworkType, Address> = {
  Mainnet: "0x48D945ACc64043B10A781917bfB88dDF49e06Fc6",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
  Base: NOT_DEPLOYED,
  Sonic: NOT_DEPLOYED,
};

export const NEXO_VETO_ADMIN: Record<NetworkType, Address> = {
  Mainnet: "0xdD84A24eeddE63F10Ec3e928f1c8302A47538b6B",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
  Base: NOT_DEPLOYED,
  Sonic: NOT_DEPLOYED,
};

export const nexoEmergencyLiquidators: Array<Address> = [
  "0xbd796DdE46DEB00B1840e7be311eF469c375c940",
  "0x98b0EB10A3a2aaf72CA2C362f8D8360FE6037E8b",
  "0x16040e932b5Ac7A3aB23b88a2f230B4185727b0d",
  "0x3c2E5548bCe88315D50eAB4f6b1Ffb2f1B8eBd7A",
  "0x1a396F9209BDbF7E1Bc95c488E7F1237DA796a03",
  "0x3d673C58eA3486E95943F4418932c3b1776B3c8c",
  "0x32D956b225b0F1C1E78E676a53C886552c38ed70",
];
