import { NOT_DEPLOYED } from "../core/constants";
import { SupportedToken } from "../tokens/token";
import { PartialRecord } from "../utils/types";
import {
  FOUR_MINUTES,
  HOUR_1_BUFFERED,
  HOUR_24_BUFFERED,
  PriceFeedEntry,
  PriceFeedNetwork,
  PriceFeedType,
} from "./pricefeedType";

export const GAS_PRICE_FEED = "0x169e633a2d1e6c10dd91238ba11c4a708dfef37c";

export const REDSTONE_SIGNERS = {
  signers: [
    "0x8BB8F32Df04c8b654987DAaeD53D6B6091e3B774",
    "0xdEB22f54738d54976C4c0fe5ce6d408E40d88499",
    "0x51Ce04Be4b3E32572C4Ec9135221d0691Ba7d202",
    "0xDD682daEC5A90dD295d14DA4b0bec9281017b5bE",
    "0x9c5AE89C4Af6aA32cE58588DBaF90d18a855B6de",
  ],
  signersThreshold: 5,
};

export const priceFeedsByToken: Record<
  SupportedToken,
  PartialRecord<PriceFeedNetwork, PriceFeedEntry>
> = {
  "1INCH": {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xc929ad75B72593967DE83E7F7Cda0493458261D9",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x4bC735Ef24bf286983024CAd5D03f0738865Aaef",
        trusted: false,
      },
    },
  },

  AAVE: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x547a514d5e3769680Ce22B2361c10Ea13619e8a9",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xaD1d5344AaDE45F43E596773Bcc4c423EAbdD034",
        trusted: false,
      },
    },
  },

  COMP: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xe7C53FFd03Eb6ceF7d208bC4C13446c76d1E5884",
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
        trusted: false,
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
        trusted: false,
      },
    },
  },

  DPI: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xD2A593BF7594aCE1faD597adb697b5645d5edDB2",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  FEI: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED, // OUTDATED: "0x31e0a88fecB6eC0a411DBe0e9E76391498296EE9",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  GUSD: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xa89f5d2365ce98B3cD68012b6f503ab1416245Fc",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
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
        trusted: false,
      },
    },
  },

  SNX: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xDC3EA94CD0AC27d9A86C180091e7f78C683d3699",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x054296f0D036b95531B4E14aFB578B80CFb41252",
        trusted: false,
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
        trusted: false,
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
        trusted: false,
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
        trusted: false,
      },
    },
  },

  WBTC: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: "0xfdFD9C85aD200c506Cf9e21F1FD8dd01932FBB23",
        baseToUsdPriceFeed: "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c",
        targetStalenessPeriod: HOUR_24_BUFFERED,
        baseStalenessPeriod: HOUR_1_BUFFERED,

        trusted: true,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "BTC",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: "0x0017abAc5b6f291F9164e35B1234CA1D697f9CF4",
        baseToUsdPriceFeed: "0x6ce185860a4963106506C203335A2910413708e9",
        trusted: false,
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
        trusted: false,
      },
    },
  },

  YFI: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xA027702dbb89fbd58938e4324ac03B58d812b0E1",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x745Ab5b69E01E2BE1104Ca84937Bb71f96f5fB21",
        trusted: false,
      },
    },
  },

  /// UPDATE
  STETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: "0x86392dC19c0b719886221c78AB11eb8Cf5c52812",
        baseToUsdPriceFeed: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
        targetStalenessPeriod: HOUR_24_BUFFERED,
        baseStalenessPeriod: HOUR_1_BUFFERED,
        trusted: false,
      },
      Reserve: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "STETH",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
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
        targetToBasePriceFeed: NOT_DEPLOYED,
        baseToUsdPriceFeed: NOT_DEPLOYED,
        trusted: false,
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
        trusted: false,
      },
    },
  },
  LUSD: {
    Mainnet: {
      Main: {
        type: PriceFeedType.BOUNDED_ORACLE,
        priceFeed: "0x3D7aE7E594f2f2091Ad8798313450130d0Aba3a0",
        upperBound: (BigInt(1e8) * 11n) / 10n,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.BOUNDED_ORACLE,
        priceFeed: "0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF",
        upperBound: (BigInt(1e8) * 11n) / 10n,
        trusted: false,
      },
    },
  },

  sUSD: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: "0x8e0b7e6062272B5eF4524250bFFF8e5Bd3497757",
        baseToUsdPriceFeed: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
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
        trusted: false,
      },
    },
  },
  LDO: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: "0x4e844125952D32AcdF339BE976c98E22F6F318dB",
        baseToUsdPriceFeed: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
        targetStalenessPeriod: HOUR_24_BUFFERED,
        baseStalenessPeriod: HOUR_1_BUFFERED,
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
        targetToBasePriceFeed: "0x9a72298ae3886221820B1c878d12D872087D3a23",
        baseToUsdPriceFeed: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
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
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  SPELL: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x8c110B94C5f1d347fAcF5E1E938AB2db60E3c9a8",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x383b3624478124697BEF675F07cA37570b73992f",
        trusted: false,
      },
    },
  },

  GMX: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xDB98056FecFff59D032aB628337A4887110df3dB",
        trusted: false,
      },
    },
  },

  ARB: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6",
        trusted: false,
      },
    },
  },

  SHIB: {
    Mainnet: {
      Main: {
        type: PriceFeedType.REDSTONE_ORACLE,
        dataServiceId: "redstone-primary-prod",
        dataId: "SHIB",
        stalenessPeriod: FOUR_MINUTES,
        ...REDSTONE_SIGNERS,
        trusted: false,
      },
    },
  },

  RDNT: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x20d0Fcab0ECFD078B036b6CAf1FaC69A6453b352",
        trusted: false,
      },
    },
  },

  BAL: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xdF2917806E30300537aEB49A7663062F4d1F2b5F",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xBE5eA816870D11239c543F84b71439511D70B94f",
        trusted: false,
      },
    },
  },

  rETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.COMPOSITE_ORACLE,
        targetToBasePriceFeed: "0x536218f9E9Eb48863970252233c8F271f554C2d0",
        baseToUsdPriceFeed: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  AURA: {
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
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
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

  // GEARBOX
  dDAI: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  dUSDC: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  dWBTC: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  dWETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  dwstETH: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  dFRAX: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  dUSDCV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  dWBTCV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  dWETHV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  sdUSDCV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  sdWBTCV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  sdWETHV3: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
  },

  GEAR: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: NOT_DEPLOYED,
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
        trusted: false,
      },
    },
  },
  RPL: {
    Mainnet: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d",
        trusted: false,
      },
    },
    Arbitrum: {
      Main: {
        type: PriceFeedType.CHAINLINK_ORACLE,
        address: "0xF0b7159BbFc341Cc41E7Cb182216F62c6d40533D",
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
};
