import { Address } from "..";
import { NetworkType } from "../core/chains";
import { NOT_DEPLOYED } from "../core/constants";

export const ADDRESS_PROVIDER: Record<NetworkType, Address> = {
  Mainnet: "0x9ea7b04Da02a5373317D745c1571c84aaD03321D",
  Arbitrum: "0x7d04eCdb892Ae074f03B5D0aBA03796F90F3F2af",
  Optimism: "0x3761ca4BFAcFCFFc1B8034e69F19116dD6756726",
  Base: NOT_DEPLOYED,
};

export const TIMELOCK: Record<NetworkType, Address> = {
  Mainnet: "0xa133C9A92Fb8dDB962Af1cbae58b2723A0bdf23b",
  Arbitrum: "0x148DD932eCe1155c11006F5650c6Ff428f8D374A",
  Optimism: "0x148DD932eCe1155c11006F5650c6Ff428f8D374A",
  Base: NOT_DEPLOYED,
};

export const GOVERNOR: Record<NetworkType, Address> = {
  Mainnet: "0x29B97F37B3E0C704bCFD785F5b7bBa2A0B7df2c7",
  Arbitrum: "0xF0C89a0eDCD68B4176A26B3bf7574498DD3E6d09",
  Optimism: "0xF0C89a0eDCD68B4176A26B3bf7574498DD3E6d09",
  Base: NOT_DEPLOYED,
};

export const BATCH_CHAIN: Record<NetworkType, Address> = {
  Mainnet: "0xB900bDEf6eAc8C5D97F8e876aBC39573Cf6626b2",
  Arbitrum: "0xAEbaa1015D0bc250F5b38aac9b8f65E0668cE3c2",
  Optimism: "0x5CfB7F186dEA745381ccb1D532e43223B5a6AD10",
  Base: NOT_DEPLOYED,
};

export const BLACKLIST_HELPER: Record<NetworkType, Address> = {
  Mainnet: "0xFfbF344741654a1B9Ab1286Cf05A42f275F67839",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
  Base: NOT_DEPLOYED,
};

export const CREATE2FACTORY: Record<NetworkType, Address> = {
  Mainnet: "0x45d146CAA25aa565Cfc7434926633f4F1C97c873",
  Arbitrum: "0xad1231A64eE68D6BF721a1E8e177776cc49bAA2C",
  Optimism: "0xad1231A64eE68D6BF721a1E8e177776cc49bAA2C",
  Base: NOT_DEPLOYED,
};

export const MULTISIG: Record<NetworkType, Address> = {
  Mainnet: "0xA7D5DDc1b8557914F158076b228AA91eF613f1D5",
  Arbitrum: "0x57Fd8B1a9213624157786Fff4a7bc532Ce717773",
  Optimism: "0x8bA8cd6D00919ceCc19D9B4A2c8669a524883C4c",
  Base: NOT_DEPLOYED,
};

export const VETO_ADMIN: Record<NetworkType, Address> = {
  Mainnet: "0xbb803559B4D58b75E12dd74641AB955e8B0Df40E",
  Arbitrum: "0x746fb3AcAfF6Bfe246206EC2E51F587d2E57abb6",
  Optimism: "0x9744f76dc5239Eb4DC2CE8D5538e1BA89C8FA90f",
  Base: NOT_DEPLOYED,
};

export const TREASURY: Record<NetworkType, Address> = {
  Mainnet: "0x7b065fcb0760df0cea8cfd144e08554f3cea73d1",
  Arbitrum: "0x2c31eFFE426765E68A43163A96DD13DF70B53C14",
  Optimism: "0x1ACc5BC353f23B901801f3Ba48e1E51a14263808",
  Base: NOT_DEPLOYED,
};

export const ROUTER_MULTISIG_ADDRESS: Record<NetworkType, Address> = {
  Mainnet: "0xaaDf86C39a76eEEf5a5337Ca449C7EfA66E3175E",
  Arbitrum: "0xEAb23245937A4F0894B0c92f08992C2c45Fc8df5",
  Optimism: "0x4cda5Fa96B5d436002175d958667C7EF3B644aA1",
  Base: NOT_DEPLOYED,
};

export const ROUTER_CREATE2FACTORY: Record<NetworkType, Address> = {
  Mainnet: "0xA287577Fb7Cf49246e569EA268FE919F1cD6d9E2",
  Arbitrum: "0x95345A4d55DAf6864924fC8861b311B9BC860E5f",
  Optimism: "0x95345A4d55DAf6864924fC8861b311B9BC860E5f",
  Base: NOT_DEPLOYED,
};

export const emergencyLiquidators: Array<Address> = [
  "0x7BD9c8161836b1F402233E80F55E3CaE0Fde4d87",
  "0x16040e932b5Ac7A3aB23b88a2f230B4185727b0d",
];
