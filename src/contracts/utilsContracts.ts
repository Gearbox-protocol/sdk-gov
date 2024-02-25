import { NetworkType } from "../core/chains";
import { NOT_DEPLOYED } from "../core/constants";

export const ADDRESS_PROVIDER: Record<NetworkType, string> = {
  Mainnet: "0x9ea7b04Da02a5373317D745c1571c84aaD03321D",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
};

export const TIMELOCK: Record<NetworkType, string> = {
  Mainnet: "0xa133C9A92Fb8dDB962Af1cbae58b2723A0bdf23b",
  Arbitrum: "0x148DD932eCe1155c11006F5650c6Ff428f8D374A",
  Optimism: NOT_DEPLOYED,
};

export const GOVERNOR: Record<NetworkType, string> = {
  Mainnet: "0x29B97F37B3E0C704bCFD785F5b7bBa2A0B7df2c7",
  Arbitrum: "0xF0C89a0eDCD68B4176A26B3bf7574498DD3E6d09",
  Optimism: NOT_DEPLOYED,
};

export const BLACKLIST_HELPER: Record<NetworkType, string> = {
  Mainnet: "0xFfbF344741654a1B9Ab1286Cf05A42f275F67839",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
};

export const DEGEN_NFT: Record<NetworkType, string> = {
  Mainnet: "0xB829a5b349b01fc71aFE46E50dD6Ec0222A6E599",
  Arbitrum: NOT_DEPLOYED,
  Optimism: NOT_DEPLOYED,
};

export const CREATE2FACTORY: Record<NetworkType, string> = {
  Mainnet: "0x45d146CAA25aa565Cfc7434926633f4F1C97c873",
  Arbitrum: "0x95345A4d55DAf6864924fC8861b311B9BC860E5f",
  Optimism: NOT_DEPLOYED,
};

export const MULTISIG: Record<NetworkType, string> = {
  Mainnet: "0xA7D5DDc1b8557914F158076b228AA91eF613f1D5",
  Arbitrum: "0x57Fd8B1a9213624157786Fff4a7bc532Ce717773",
  Optimism: "0x8bA8cd6D00919ceCc19D9B4A2c8669a524883C4c",
};

export const VETO_ADMIN: Record<NetworkType, string> = {
  Mainnet: "0xbb803559B4D58b75E12dd74641AB955e8B0Df40E",
  Arbitrum: "0x746fb3AcAfF6Bfe246206EC2E51F587d2E57abb6",
  Optimism: "0x9744f76dc5239Eb4DC2CE8D5538e1BA89C8FA90f",
};

export const TREASURY: Record<NetworkType, string> = {
  Mainnet: "0x7b065fcb0760df0cea8cfd144e08554f3cea73d1",
  Arbitrum: "0x2c31eFFE426765E68A43163A96DD13DF70B53C14",
  Optimism: "0x1ACc5BC353f23B901801f3Ba48e1E51a14263808",
};
