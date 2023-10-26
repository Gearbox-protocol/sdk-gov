import { NetworkType } from "../core/chains";
import { NOT_DEPLOYED } from "../core/constants";

export const ADDRESS_PROVIDER: Record<NetworkType, string> = {
  Mainnet: "0x9ea7b04Da02a5373317D745c1571c84aaD03321D",
  Arbitrum: NOT_DEPLOYED,
};

export const TIMELOCK: Record<NetworkType, string> = {
  Mainnet: "0xa133C9A92Fb8dDB962Af1cbae58b2723A0bdf23b",
  Arbitrum: NOT_DEPLOYED,
};

export const BLACKLIST_HELPER: Record<NetworkType, string> = {
  Mainnet: "0xFfbF344741654a1B9Ab1286Cf05A42f275F67839",
  Arbitrum: NOT_DEPLOYED,
};

export const DEGEN_NFT: Record<NetworkType, string> = {
  Mainnet: "0xB829a5b349b01fc71aFE46E50dD6Ec0222A6E599",
  Arbitrum: NOT_DEPLOYED,
};

export const CREATE2FACTORY: Record<NetworkType, string> = {
  Mainnet: "0x59b7B8Dd9E6e1F934C9c3Def4a1Eb69Bc17Ec9cc",
  Arbitrum: NOT_DEPLOYED,
};

export const MULTISIG: Record<NetworkType, string> = {
  Mainnet: "0xA7D5DDc1b8557914F158076b228AA91eF613f1D5",
  Arbitrum: NOT_DEPLOYED,
};

export const TREASURY: Record<NetworkType, string> = {
  Mainnet: "0x7b065fcb0760df0cea8cfd144e08554f3cea73d1",
  Arbitrum: NOT_DEPLOYED,
};
