import { NetworkType } from "../core/chains";
import { NOT_DEPLOYED } from "../core/constants";
import { SupportedToken } from "../tokens/token";
import { Address, PartialRecord } from "../utils/types";
import {
  FOUR_MINUTES,
  HOUR_1_BUFFERED,
  HOUR_1_BUFFERED_L2,
  HOUR_12_BUFFERED,
  HOUR_24,
  HOUR_24_BUFFERED,
  HOUR_24_BUFFERED_L2,
  MINUTES_20_BUFFERED_L2,
  PriceFeedEntry,
  PriceFeedNetwork,
  PriceFeedType,
} from "./pricefeedType";

export const GAS_PRICE_FEED = "0x169e633a2d1e6c10dd91238ba11c4a708dfef37c";

export interface RedstoneSingers {
  signers: Array<Address>;
  signersThreshold: number;
}

export const REDSTONE_SIGNERS: RedstoneSingers = {
  signers: [
    "0x8BB8F32Df04c8b654987DAaeD53D6B6091e3B774",
    "0xdEB22f54738d54976C4c0fe5ce6d408E40d88499",
    "0x51Ce04Be4b3E32572C4Ec9135221d0691Ba7d202",
    "0xDD682daEC5A90dD295d14DA4b0bec9281017b5bE",
    "0x9c5AE89C4Af6aA32cE58588DBaF90d18a855B6de",
  ],
  signersThreshold: 5,
};

export const REDSTONE_ARBITRUM_SIGNERS: RedstoneSingers = {
  signers: [
    "0x345Efd26098e173F811e3B9Af1B0e0a11872B38b",
    "0xbD0c5ccd85D5831B10E3e49527B8Cd67e2EFAf39",
    "0x2F3E8EC88C01593d10ca9461c807660fF2D8DB28",
    "0xb7f154bB5491565D215F4EB1c3fe3e84960627aF",
    "0xE6b0De8F4B31F137d3c59b5a0A71e66e7D504Ef9",
  ],
  signersThreshold: 5,
};

export const REDSTONE_DEMO_SIGNERS: RedstoneSingers = {
  signers: ["0x0C39486f770B26F5527BBBf942726537986Cd7eb"],
  signersThreshold: 1,
};

export function getPriceFeedsByToken(
  token: SupportedToken,
  network: NetworkType,
): PriceFeedEntry | undefined {
  const priceFeed = priceFeedsByToken[token];
  const networkPf = "AllNetworks" in priceFeed ? "AllNetworks" : network;
  return priceFeedsByToken[token][networkPf];
}

export const priceFeedsByToken: Record<
  SupportedToken,
  PartialRecord<PriceFeedNetwork, PriceFeedEntry>
> = {
  "1INCH": {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xc929ad75B72593967DE83E7F7Cda0493458261D9",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x4bC735Ef24bf286983024CAd5D03f0738865Aaef",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },

  AAVE: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x547a514d5e3769680Ce22B2361c10Ea13619e8a9",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "AAVE",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xaD1d5344AaDE45F43E596773Bcc4c423EAbdD034",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "AAVE",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  COMP: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xe7C53FFd03Eb6ceF7d208bC4C13446c76d1E5884",
        stalenessPeriod: HOUR_1_BUFFERED_L2,
        trusted: false,
      },
    },
  },

  CRV: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xCd627aA160A6fA45Eb793D19Ef54f5062F20f33f",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "CRV",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xaebDA2c976cfd1eE1977Eac079B4382acb849325",
        stalenessPeriod: HOUR_1_BUFFERED_L2,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "CRV",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  DAI: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9",
        stalenessPeriod: HOUR_1_BUFFERED,
        trusted: true,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "DAI",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xc5C8E77B397E531B8EC06BFb0048328B30E9eCfB",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "DAI",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x8dBa75e83DA73cc766A7e5a0ee71F656BAb470d6",
        trusted: false,
        stalenessPeriod: HOUR_24_BUFFERED_L2,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "DAI",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  DPI: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xD2A593BF7594aCE1faD597adb697b5645d5edDB2",
        stalenessPeriod: HOUR_24,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  FEI: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE, // OUTDATED: "0x31e0a88fecB6eC0a411DBe0e9E76391498296EE9",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  GUSD: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xa89f5d2365ce98B3cD68012b6f503ab1416245Fc",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  LINK: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c",
        stalenessPeriod: HOUR_1_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "LINK",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x86E53CF1B870786351Da77A57575e79CB55812CB",
        stalenessPeriod: HOUR_1_BUFFERED_L2,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "LINK",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xCc232dcFAAE6354cE191Bd574108c1aD03f86450",
        trusted: false,
        stalenessPeriod: MINUTES_20_BUFFERED_L2,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "LINK",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  SNX: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xDC3EA94CD0AC27d9A86C180091e7f78C683d3699",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x054296f0D036b95531B4E14aFB578B80CFb41252",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x2FCF37343e916eAEd1f1DdaaF84458a359b53877",
        trusted: false,
        stalenessPeriod: MINUTES_20_BUFFERED_L2,
      },
    },
  },

  WLD: {
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x4e1C6B168DCFD7758bC2Ab9d2865f1895813D236",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },

  OP: {
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x0D276FC14719f9292D5C1eA2198673d1f4269246",
        trusted: false,
        stalenessPeriod: MINUTES_20_BUFFERED_L2,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "OP",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  UNI: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x553303d460EE0afB37EdFf9bE42922D8FF63220e",
        stalenessPeriod: HOUR_1_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "UNI",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x9C917083fDb403ab5ADbEC26Ee294f6EcAda2720",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "UNI",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  USDC: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: true,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "USDC",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: true,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "USDC",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3",
        trusted: false,
        stalenessPeriod: HOUR_24_BUFFERED_L2,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "USDC",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },
  USDC_e: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: true,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "USDC",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: true,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "USDC",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3",
        trusted: false,
        stalenessPeriod: HOUR_24_BUFFERED_L2,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "USDC",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  USDT: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x3E7d1eAB13ad0104d2750B8863b489D65364e32D",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "USDT",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x3f3f5dF88dC9F13eac63DF89EC16ef6e7E25DdE7",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "USDT",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xECef79E109e997bCA29c1c0897ec9d7b03647F5E",
        trusted: false,
        stalenessPeriod: HOUR_24_BUFFERED_L2,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "USDT",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  WBTC: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xfdFD9C85aD200c506Cf9e21F1FD8dd01932FBB23",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c",
          stalenessPeriod: HOUR_1_BUFFERED,
        },

        trusted: true,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "WBTC",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x0017abAc5b6f291F9164e35B1234CA1D697f9CF4",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x6ce185860a4963106506C203335A2910413708e9",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        trusted: true,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "WBTC",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x718A5788b89454aAE3A028AE9c111A29Be6c2a6F",
        trusted: false,
        stalenessPeriod: MINUTES_20_BUFFERED_L2,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "WBTC",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  WETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
        trusted: true,
        stalenessPeriod: HOUR_1_BUFFERED,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "ETH",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: true,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "ETH",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x13e3Ee699D1909E989722E753853AE30b17e08c5",
        trusted: true,
        stalenessPeriod: MINUTES_20_BUFFERED_L2,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "ETH",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  YFI: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xA027702dbb89fbd58938e4324ac03B58d812b0E1",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x745Ab5b69E01E2BE1104Ca84937Bb71f96f5fB21",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },

  /// UPDATE
  STETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x86392dC19c0b719886221c78AB11eb8Cf5c52812",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          stalenessPeriod: HOUR_1_BUFFERED,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "stETH",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  wstETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.WSTETH_ORACLE,
        token: "STETH",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xb523AE262D20A936BC152e6023996e46FDC2A95D",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "wstETH",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE, // wstETH/ETH x ETH/USD
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x524299Ab0987a7c4B3c8022a35669DdcdC715a10",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x13e3Ee699D1909E989722E753853AE30b17e08c5",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "wstETH",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  CVX: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xd962fC30A72A84cE50161031391756Bf2876Af5D",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "CVX",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x851175a919f36c8e30197c09a9A49dA932c2CC00",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },

  FRAX: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD",
        stalenessPeriod: HOUR_1_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "FRAX",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },
  LUSD: {
    Mainnet: {
      Main: {
        type: PriceFeedType.BOUNDED_ORACLE,
        priceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x3D7aE7E594f2f2091Ad8798313450130d0Aba3a0",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        upperBound: (BigInt(1e8) * 11n) / 10n,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "LUSD",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.BOUNDED_ORACLE,
        priceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        upperBound: (BigInt(1e8) * 11n) / 10n,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "LUSD",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  sUSD: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x8e0b7e6062272B5eF4524250bFFF8e5Bd3497757",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  USDe: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xbC5FBcf58CeAEa19D523aBc76515b9AEFb5cfd58",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
    },
  },

  FXS: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "FXS",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x36a121448D74Fa81450c992A1a44B9b7377CD3a5",
        stalenessPeriod: HOUR_1_BUFFERED_L2,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "FXS",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },
  LDO: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x4e844125952D32AcdF339BE976c98E22F6F318dB",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          stalenessPeriod: HOUR_1_BUFFERED,
        },
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    // ADD ETH-> DAI Oracle!
  },
  LQTY: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: true,
      },
    },
  },

  OHM: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x9a72298ae3886221820B1c878d12D872087D3a23",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },
  MIM: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x7A364e8770418566e3eb2001A96116E6138Eb32F",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  SPELL: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x8c110B94C5f1d347fAcF5E1E938AB2db60E3c9a8",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x383b3624478124697BEF675F07cA37570b73992f",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },

  GMX: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xDB98056FecFff59D032aB628337A4887110df3dB",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-arbitrum-prod",
        dataId: "GMX",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_ARBITRUM_SIGNERS,
      },
    },
  },

  ARB: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "ARB",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  SHIB: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  RDNT: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x20d0Fcab0ECFD078B036b6CAf1FaC69A6453b352",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },

  BAL: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xdF2917806E30300537aEB49A7663062F4d1F2b5F",
        stalenessPeriod: HOUR_24,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-arbitrum-prod",
        dataId: "BAL",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_ARBITRUM_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xBE5eA816870D11239c543F84b71439511D70B94f",
        stalenessPeriod: HOUR_1_BUFFERED_L2,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-arbitrum-prod",
        dataId: "BAL",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_ARBITRUM_SIGNERS,
      },
    },
  },

  rETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x536218f9E9Eb48863970252233c8F271f554C2d0",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "rETH",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xF3272CAfe65b190e76caAF483db13424a3e23dD2",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "rETH",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xb429DE60943a8e6DeD356dca2F93Cd31201D9ed0",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x13e3Ee699D1909E989722E753853AE30b17e08c5",
          stalenessPeriod: MINUTES_20_BUFFERED_L2,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "rETH",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  osETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x66ac817f997Efd114EDFcccdce99F3268557B32C",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          stalenessPeriod: HOUR_1_BUFFERED,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.THE_SAME_AS,
        token: "WETH",
      },
    },
  },

  weETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x8751F736E94F6CD167e8C5B97E245680FbD9CC36",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          stalenessPeriod: HOUR_1_BUFFERED,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.THE_SAME_AS,
        token: "WETH",
      },
    },
  },

  ezETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xF4a3e183F59D2599ee3DF213ff78b1B3b1923696",
          stalenessPeriod: HOUR_12_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          stalenessPeriod: HOUR_1_BUFFERED,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.THE_SAME_AS,
        token: "WETH",
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.REDSTONE_ORACLE,
          dataServiceId: "redstone-primary-prod",
          dataId: "ezETH/ETH",
          ...REDSTONE_SIGNERS,
          stalenessPeriod: FOUR_MINUTES,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.THE_SAME_AS,
        token: "WETH",
      },
    },
  },

  rswETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: true,
      },
    },
  },

  rsETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xA736eAe8805dDeFFba40cAB8c99bCB309dEaBd9B",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          stalenessPeriod: HOUR_1_BUFFERED,
        },
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.THE_SAME_AS,
        token: "WETH",
      },
    },
  },

  frxETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5C3e80763862CB777Aa07BDDBcCE0123104e1c34",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        trusted: false,
      },
    },
  },

  sfrxETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x98E5a52fB741347199C08a7a3fcF017364284431",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.COMPOSITE_ORACLE,
          targetToBasePriceFeed: {
            type: PriceFeedType.CHAINLINK_ORACLE,
            address: "0x5C3e80763862CB777Aa07BDDBcCE0123104e1c34",
            stalenessPeriod: HOUR_24_BUFFERED_L2,
          },
          baseToUsdPriceFeed: {
            type: PriceFeedType.CHAINLINK_ORACLE,
            address: "0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612",
            stalenessPeriod: HOUR_24_BUFFERED_L2,
          },
        },
        trusted: false,
      },
    },
  },

  cbETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xF017fcB346A1885194689bA23Eff2fE6fA5C483b",
          stalenessPeriod: HOUR_24_BUFFERED,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          stalenessPeriod: HOUR_1_BUFFERED,
        },
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xa668682974E3f121185a3cD94f00322beC674275",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        trusted: false,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x138b809B8472fF09Cd3E075E6EcbB2e42D41d870",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },
        baseToUsdPriceFeed: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x13e3Ee699D1909E989722E753853AE30b17e08c5",
          stalenessPeriod: HOUR_24_BUFFERED_L2,
        },

        trusted: false,
      },
    },
  },

  PENDLE: {
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x66853E19d73c0F9301fe099c324A1E9726953433",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
    Optimism: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x58F23F80bF389DB1af9e3aA8c59679806749A8a4",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },

  AURA: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  SWISE: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  GHO: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "GHO",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
  },

  yvDAI: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.YEARN_ORACLE,
        token: "DAI",
        trusted: false,
      },
    },
  },
  yvUSDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.YEARN_ORACLE,
        token: "USDC",
        trusted: false,
      },
    },
  },
  yvUSDC_e: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.YEARN_ORACLE,
        token: "USDC_e",
        trusted: false,
      },
    },
  },
  yvUSDT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.YEARN_ORACLE,
        token: "USDT",
        trusted: false,
      },
    },
  },
  yvWETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.YEARN_ORACLE,
        token: "WETH",
        trusted: false,
      },
    },
  },
  yvWBTC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.YEARN_ORACLE,
        token: "WBTC",
        trusted: false,
      },
    },
  },
  yvOP: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.YEARN_ORACLE,
        token: "OP",
        trusted: false,
      },
    },
  },

  // CURVE LP TOKENS
  "3Crv": {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_3LP_ORACLE,
        assets: ["DAI", "USDC", "USDT"],
        trusted: false,
      },
    },
  },

  crvFRAX: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["FRAX", "USDC"],
        trusted: false,
      },
    },
  },

  steCRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["STETH", "WETH"],
        trusted: false,
      },
    },
  },
  FRAX3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_4LP_ORACLE,
        assets: ["FRAX", "DAI", "USDC", "USDT"],
        trusted: false,
      },
    },
  },

  LUSD3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_4LP_ORACLE,
        assets: ["LUSD", "DAI", "USDC", "USDT"],
        trusted: false,
      },
    },
  },

  crvPlain3andSUSD: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_4LP_ORACLE,
        assets: ["DAI", "USDC", "USDT", "sUSD"],
        trusted: false,
      },
    },
  },

  gusd3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_4LP_ORACLE,
        assets: ["GUSD", "DAI", "USDC", "USDT"],
        trusted: false,
      },
    },
  },

  MIM_3LP3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_4LP_ORACLE,
        assets: ["MIM", "DAI", "USDC", "USDT"],
        trusted: false,
      },
    },
  },

  USDeUSDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["USDe", "USDC"],
        trusted: false,
      },
    },
  },

  USDeDAI: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["USDe", "DAI"],
        trusted: false,
      },
    },
  },

  MtEthena: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: true,
      },
    },
  },

  GHOUSDe: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["GHO", "USDe"],
        trusted: false,
      },
    },
  },

  FRAXUSDe: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["FRAX", "USDe"],
        trusted: false,
      },
    },
  },

  USDecrvUSD: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["USDe", "crvUSD"],
        trusted: false,
      },
    },
  },

  OHMFRAXBP: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_CRYPTO_ORACLE,
        assets: ["OHM", "crvFRAX"],
        trusted: false,
      },
    },
  },

  crvCRVETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_CRYPTO_ORACLE,
        assets: ["WETH", "CRV"],
        trusted: false,
      },
    },
  },

  crvCVXETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_CRYPTO_ORACLE,
        assets: ["WETH", "CVX"],
        trusted: false,
      },
    },
  },

  crvUSDTWBTCWETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_CRYPTO_ORACLE,
        assets: ["USDT", "WBTC", "WETH"],
        trusted: false,
      },
    },
  },

  LDOETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_CRYPTO_ORACLE,
        assets: ["LDO", "WETH"],
        trusted: false,
      },
    },
  },

  crvUSD: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xEEf0C605546958c1f899b6fB336C20671f9cD49F",
        stalenessPeriod: HOUR_24,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x0a32255dd4BB6177C994bAAc73E0606fDD568f66",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },

  crvUSDUSDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["crvUSD", "USDC"],
        trusted: false,
      },
    },
  },
  crvUSDUSDT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["crvUSD", "USDT"],
        trusted: false,
      },
    },
  },
  crvUSDFRAX: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["crvUSD", "FRAX"],
        trusted: false,
      },
    },
  },
  wstETHCRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["WETH", "wstETH"],
        trusted: false,
      },
    },
  },
  crvUSDETHCRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_CRYPTO_ORACLE,
        assets: ["crvUSD", "WETH", "CRV"],
        trusted: false,
      },
    },
  },

  rETH_f: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_CRYPTO_ORACLE,
        assets: ["rETH", "WETH"],
        trusted: false,
      },
    },
  },

  "2CRV": {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["USDC_e", "USDT"],
        trusted: false,
      },
    },
  },

  "3c-crvUSD": {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_CRYPTO_ORACLE,
        assets: ["crvUSD", "WBTC", "WETH"],
        trusted: false,
      },
    },
  },

  crvUSDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["crvUSD", "USDC"],
        trusted: false,
      },
    },
  },

  crvUSDC_e: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["crvUSD", "USDC_e"],
        trusted: false,
      },
    },
  },

  "3CRV": {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_3LP_ORACLE,
        assets: ["DAI", "USDC_e", "USDT"],
        trusted: false,
      },
    },
  },

  crvUSDT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.CURVE_2LP_ORACLE,
        assets: ["crvUSD", "USDT"],
        trusted: false,
      },
    },
  },

  // YEARN- CURVE TOKENS
  yvCurve_stETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.YEARN_ORACLE,
        token: "steCRV",
        trusted: false,
      },
    },
  },
  yvCurve_FRAX: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.YEARN_ORACLE,
        token: "FRAX3CRV",
        trusted: false,
      },
    },
  },

  // CVX tokens
  cvx3Crv: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "3Crv",
        trusted: false,
      },
    },
  },
  cvxcrvFRAX: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvFRAX",
        trusted: false,
      },
    },
  },
  cvxsteCRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "steCRV",
        trusted: false,
      },
    },
  },
  cvxFRAX3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "FRAX3CRV",
        trusted: false,
      },
    },
  },
  cvxLUSD3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "LUSD3CRV",
        trusted: false,
      },
    },
  },
  cvxcrvPlain3andSUSD: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvPlain3andSUSD",
        trusted: false,
      },
    },
  },
  cvxgusd3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "gusd3CRV",
        trusted: false,
      },
    },
  },
  cvxOHMFRAXBP: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "OHMFRAXBP",
        trusted: false,
      },
    },
  },
  cvxMIM_3LP3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "MIM_3LP3CRV",
        trusted: false,
      },
    },
  },

  cvxcrvCRVETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvCRVETH",
        trusted: false,
      },
    },
  },
  cvxcrvCVXETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvCVXETH",
        trusted: false,
      },
    },
  },
  cvxcrvUSDTWBTCWETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvUSDTWBTCWETH",
        trusted: false,
      },
    },
  },

  cvxLDOETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "LDOETH",
        trusted: false,
      },
    },
  },

  cvxcrvUSDUSDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvUSDUSDC",
        trusted: false,
      },
    },
  },

  cvxcrvUSDUSDT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvUSDUSDT",
        trusted: false,
      },
    },
  },

  cvxcrvUSDFRAX: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvUSDFRAX",
        trusted: false,
      },
    },
  },

  cvxcrvUSDETHCRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvUSDETHCRV",
        trusted: false,
      },
    },
  },

  // CVX tokens
  stkcvx3Crv: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "3Crv",
        trusted: false,
      },
    },
  },
  stkcvxcrvFRAX: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvFRAX",
        trusted: false,
      },
    },
  },
  stkcvxsteCRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "steCRV",
        trusted: false,
      },
    },
  },
  stkcvxFRAX3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "FRAX3CRV",
        trusted: false,
      },
    },
  },
  stkcvxLUSD3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "LUSD3CRV",
        trusted: false,
      },
    },
  },
  stkcvxcrvPlain3andSUSD: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvPlain3andSUSD",
        trusted: false,
      },
    },
  },
  stkcvxgusd3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "gusd3CRV",
        trusted: false,
      },
    },
  },
  stkcvxOHMFRAXBP: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "OHMFRAXBP",
        trusted: false,
      },
    },
  },
  stkcvxMIM_3LP3CRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "MIM_3LP3CRV",
        trusted: false,
      },
    },
  },
  stkcvxcrvCRVETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvCRVETH",
        trusted: false,
      },
    },
  },
  stkcvxcrvCVXETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvCVXETH",
        trusted: false,
      },
    },
  },
  stkcvxcrvUSDTWBTCWETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvUSDTWBTCWETH",
        trusted: false,
      },
    },
  },
  stkcvxLDOETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "LDOETH",
        trusted: false,
      },
    },
  },
  stkcvxcrvUSDUSDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvUSDUSDC",
        trusted: false,
      },
    },
  },

  stkcvxcrvUSDUSDT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvUSDUSDT",
        trusted: false,
      },
    },
  },

  stkcvxcrvUSDFRAX: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvUSDFRAX",
        trusted: false,
      },
    },
  },

  stkcvxcrvUSDETHCRV: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "crvUSDETHCRV",
        trusted: false,
      },
    },
  },
  "50OHM_50DAI": {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE,
        assets: ["OHM", "DAI"],
        trusted: false,
      },
    },
  },
  "50OHM_50WETH": {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE,
        assets: ["OHM", "WETH"],
        trusted: false,
      },
    },
  },
  B_80BAL_20WETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE,
        assets: ["BAL", "WETH"],
        trusted: false,
      },
    },
  },
  "50WETH_50AURA": {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },
  OHM_wstETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE,
        assets: ["OHM", "wstETH"],
        trusted: false,
      },
    },
  },
  USDC_DAI_USDT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["USDC", "DAI", "USDT"],
        trusted: false,
      },
    },
  },

  B_rETH_STABLE: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["rETH", "WETH"],
        trusted: false,
      },
    },
  },
  weETH_rETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["weETH", "rETH"],
        trusted: false,
      },
    },
  },
  osETH_wETH_BPT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["WETH", "osETH"],
        trusted: false,
      },
    },
  },
  ezETH_WETH_BPT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },
  weETH_ezETH_rswETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },
  rsETH_WETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["rsETH", "WETH"],
        trusted: false,
      },
    },
  },
  BPT_rETH_ETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["rETH", "WETH"],
        trusted: false,
      },
    },
  },
  BPT_WSTETH_ETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["wstETH", "WETH"],
        trusted: false,
      },
    },
  },
  BPT_ROAD: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE,
        assets: ["WETH", "OP", "USDC"],
        trusted: false,
      },
    },
  },
  ECLP_wstETH_WETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: true,
      },
    },
  },
  wstETH_WETH_BPT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["wstETH", "WETH"],
        trusted: false,
      },
    },
  },
  wstETH_rETH_cbETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["wstETH", "rETH", "cbETH"],
        trusted: false,
      },
    },
  },
  wstETH_rETH_sfrxETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["wstETH", "rETH", "sfrxETH"],
        trusted: false,
      },
    },
  },
  rETH_WETH_BPT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
        assets: ["rETH", "WETH"],
        trusted: false,
      },
    },
  },
  "33AURA_33ARB_33BAL": {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: true,
      },
    },
  },

  GHO_USDT_USDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: true,
      },
    },
  },

  // GEARBOX
  dDAI: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  dUSDC: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  dWBTC: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  dWETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  dwstETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  dFRAX: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  dUSDCV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  dWBTCV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  dWETHV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  sdUSDCV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  sdWBTCV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  sdWETHV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  dUSDTV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },
  dGHOV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },
  dDAIV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  sdUSDTV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },
  sdGHOV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },
  sdDAIV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },

  GEAR: {
    Mainnet: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.ZERO_ORACLE,
        trusted: false,
      },
    },
  },
  // AAVE
  aDAI: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "DAI",
        trusted: false,
      },
    },
  },
  aUSDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "USDC",
        trusted: false,
      },
    },
  },
  aUSDT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "USDT",
        trusted: false,
      },
    },
  },
  aWETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "WETH",
        trusted: false,
      },
    },
  },
  waDAI: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.WRAPPED_AAVE_V2_ORACLE,
        underlying: "aDAI",
        trusted: false,
      },
    },
  },
  waUSDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.WRAPPED_AAVE_V2_ORACLE,
        underlying: "aUSDC",
        trusted: false,
      },
    },
  },
  waUSDT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.WRAPPED_AAVE_V2_ORACLE,
        underlying: "aUSDT",
        trusted: false,
      },
    },
  },
  waWETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.WRAPPED_AAVE_V2_ORACLE,
        underlying: "aWETH",
        trusted: false,
      },
    },
  },
  cDAI: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.COMPOUND_V2_ORACLE,
        underlying: "DAI",
        trusted: false,
      },
    },
  },
  cUSDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.COMPOUND_V2_ORACLE,
        underlying: "USDC",
        trusted: false,
      },
    },
  },
  cUSDT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.COMPOUND_V2_ORACLE,
        underlying: "USDT",
        trusted: false,
      },
    },
  },
  cLINK: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.COMPOUND_V2_ORACLE,
        underlying: "LINK",
        trusted: false,
      },
    },
  },
  cETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.COMPOUND_V2_ORACLE,
        underlying: "WETH",
        trusted: false,
      },
    },
  },
  fUSDC: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.COMPOUND_V2_ORACLE,
        underlying: "USDC",
        trusted: false,
      },
    },
  },
  MKR: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xec1D1B3b0443256cc3860e24a46F108e699484Aa",
        stalenessPeriod: HOUR_1_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "MKR",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xdE9f0894670c4EFcacF370426F10C3AD2Cdf147e",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },
  RPL: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xF0b7159BbFc341Cc41E7Cb182216F62c6d40533D",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },
  APE: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xD10aBbC76679a20055E167BB80A24ac851b37056",
        stalenessPeriod: HOUR_24_BUFFERED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x221912ce795669f628c51c69b7d0873eDA9C03bB",
        stalenessPeriod: HOUR_24_BUFFERED_L2,
        trusted: false,
      },
    },
  },
  // ERC4626
  sDAI: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ERC4626_VAULT_ORACLE,
        underlying: "DAI",
        trusted: false,
      },
    },
  },
  sUSDe: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ERC4626_VAULT_ORACLE,
        underlying: "USDe",
        trusted: false,
      },
    },
  },
  YieldETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.ERC4626_VAULT_ORACLE,
        underlying: "WETH",
        trusted: false,
      },
    },
  },
  // AURA
  auraB_rETH_STABLE: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "B_rETH_STABLE",
        trusted: false,
      },
    },
  },
  auraB_rETH_STABLE_vault: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "B_rETH_STABLE",
        trusted: false,
      },
    },
  },
  auraweETH_rETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "weETH_rETH",
        trusted: false,
      },
    },
  },
  auraweETH_rETH_vault: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "weETH_rETH",
        trusted: false,
      },
    },
  },
  auraosETH_wETH_BPT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "osETH_wETH_BPT",
        trusted: false,
      },
    },
  },
  aurarETH_WETH_BPT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "rETH_WETH_BPT",
        trusted: false,
      },
    },
  },
  aurawstETH_rETH_cbETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "wstETH_rETH_cbETH",
        trusted: false,
      },
    },
  },
  aurawstETH_rETH_sfrxETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "wstETH_rETH_sfrxETH",
        trusted: false,
      },
    },
  },
  aurawstETH_WETH_BPT: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "wstETH_WETH_BPT",
        trusted: false,
      },
    },
  },
  auraosETH_wETH_BPT_vault: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "osETH_wETH_BPT",
        trusted: false,
      },
    },
  },
  auraBPT_rETH_ETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "BPT_rETH_ETH",
        trusted: false,
      },
    },
  },
  auraBPT_rETH_ETH_vault: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "BPT_rETH_ETH",
        trusted: false,
      },
    },
  },
  auraBPT_WSTETH_ETH: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "BPT_WSTETH_ETH",
        trusted: false,
      },
    },
  },
  auraBPT_WSTETH_ETH_vault: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "BPT_WSTETH_ETH",
        trusted: false,
      },
    },
  },
  aurarETH_WETH_BPT_vault: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "rETH_WETH_BPT",
        trusted: false,
      },
    },
  },
  aurawstETH_rETH_cbETH_vault: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "wstETH_rETH_cbETH",
        trusted: false,
      },
    },
  },
  aurawstETH_rETH_sfrxETH_vault: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "wstETH_rETH_sfrxETH",
        trusted: false,
      },
    },
  },
  aurawstETH_WETH_BPT_vault: {
    AllNetworks: {
      Main: {
        type: PriceFeedType.THE_SAME_AS,
        token: "wstETH_WETH_BPT",
        trusted: false,
      },
    },
  },
};
