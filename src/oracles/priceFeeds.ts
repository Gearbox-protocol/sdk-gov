import { NOT_DEPLOYED } from "../core/constants";
import { SupportedToken } from "../tokens/token";
import { PriceFeedData, PriceFeedType } from "./pricefeedType";

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

export const priceFeedsByToken: Record<SupportedToken, PriceFeedData> = {
  "1INCH": {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  AAVE: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  COMP: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  CRV: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xCd627aA160A6fA45Eb793D19Ef54f5062F20f33f",
          trusted: false,
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
  },

  DAI: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9",
          trusted: true,
        },
        Reserve: {
          type: PriceFeedType.REDSTONE_ORACLE,
          dataServiceId: "redstone-primary-prod",
          dataId: "DAI",
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
  },

  DPI: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  FEI: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  GUSD: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  LINK: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c",
          trusted: false,
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
  },

  SNX: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  UNI: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x553303d460EE0afB37EdFf9bE42922D8FF63220e",
          trusted: false,
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
  },

  USDC: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6",
          trusted: true,
        },
        Reserve: {
          type: PriceFeedType.REDSTONE_ORACLE,
          dataServiceId: "redstone-primary-prod",
          dataId: "USDC",
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
  },

  USDT: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x3E7d1eAB13ad0104d2750B8863b489D65364e32D",
          trusted: false,
        },
        Reserve: {
          type: PriceFeedType.REDSTONE_ORACLE,
          dataServiceId: "redstone-primary-prod",
          dataId: "USDT",
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
  },

  WBTC: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.COMPOSITE_ORACLE,
          targetToBasePriceFeed: "0xfdFD9C85aD200c506Cf9e21F1FD8dd01932FBB23",
          baseToUsdPriceFeed: "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c",
          baseStalenessPeriod: 3600 * 24 * 10,
          targetStalenessPeriod: 3600 * 24 * 10,
          trusted: true,
        },
        Reserve: {
          type: PriceFeedType.REDSTONE_ORACLE,
          dataServiceId: "redstone-primary-prod",
          dataId: "BTC",
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
  },

  WETH: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          trusted: true,
        },
        Reserve: {
          type: PriceFeedType.REDSTONE_ORACLE,
          dataServiceId: "redstone-primary-prod",
          dataId: "ETH",
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
  },

  YFI: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  /// UPDATE
  STETH: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.COMPOSITE_ORACLE,

          targetToBasePriceFeed: "0x86392dC19c0b719886221c78AB11eb8Cf5c52812",
          baseToUsdPriceFeed: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
          trusted: false,
        },
        Reserve: {
          type: PriceFeedType.REDSTONE_ORACLE,
          dataServiceId: "redstone-primary-prod",
          dataId: "STETH",
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
  },

  wstETH: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  CVX: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xd962fC30A72A84cE50161031391756Bf2876Af5D",
          trusted: false,
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
  },

  FRAX: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD",
          trusted: false,
        },
        Reserve: {
          type: PriceFeedType.REDSTONE_ORACLE,
          dataServiceId: "redstone-primary-prod",
          dataId: "FRAX",
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
  },
  LUSD: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  sUSD: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xad35Bd71b9aFE6e4bDc266B345c198eaDEf9Ad94",
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
  },

  FXS: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f",
          trusted: false,
        },
        Reserve: {
          type: PriceFeedType.REDSTONE_ORACLE,
          dataServiceId: "redstone-primary-prod",
          dataId: "DAI",
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
  },
  LDO: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.COMPOSITE_ORACLE,
          targetToBasePriceFeed: "0x4e844125952D32AcdF339BE976c98E22F6F318dB",
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
    // ADD ETH-> DAI Oracle!
  },
  LQTY: {
    type: PriceFeedType.ZERO_ORACLE,
  },

  OHM: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },
  MIM: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  SPELL: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  GMX: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  ARB: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  SHIB: {
    type: PriceFeedType.REDSTONE_ORACLE,
    dataServiceId: "redstone-main-demo",
    dataId: "SHIB",
    signers: ["0x0C39486f770B26F5527BBBf942726537986Cd7eb"],
    signersThreshold: 1,
  },

  RDNT: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  BAL: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  rETH: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  AURA: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  yvDAI: {
    type: PriceFeedType.YEARN_ORACLE,
    token: "DAI",
  },
  yvUSDC: {
    type: PriceFeedType.YEARN_ORACLE,
    token: "USDC",
  },
  yvWETH: {
    type: PriceFeedType.YEARN_ORACLE,
    token: "WETH",
  },
  yvWBTC: {
    type: PriceFeedType.YEARN_ORACLE,
    token: "WBTC",
  },

  // CURVE LP TOKENS
  "3Crv": {
    type: PriceFeedType.CURVE_3LP_ORACLE,
    assets: ["DAI", "USDC", "USDT"],
  },

  crvFRAX: {
    type: PriceFeedType.CURVE_2LP_ORACLE,
    assets: ["FRAX", "USDC"],
  },

  steCRV: {
    type: PriceFeedType.CURVE_2LP_ORACLE,
    assets: ["STETH", "WETH"],
  },
  FRAX3CRV: {
    type: PriceFeedType.CURVE_4LP_ORACLE,
    assets: ["FRAX", "DAI", "USDC", "USDT"],
  },

  LUSD3CRV: {
    type: PriceFeedType.CURVE_4LP_ORACLE,
    assets: ["LUSD", "DAI", "USDC", "USDT"],
  },

  crvPlain3andSUSD: {
    type: PriceFeedType.CURVE_4LP_ORACLE,
    assets: ["DAI", "USDC", "USDT", "sUSD"],
  },

  gusd3CRV: {
    type: PriceFeedType.CURVE_4LP_ORACLE,
    assets: ["GUSD", "DAI", "USDC", "USDT"],
  },

  MIM_3LP3CRV: {
    type: PriceFeedType.CURVE_4LP_ORACLE,
    assets: ["MIM", "DAI", "USDC", "USDT"],
  },

  OHMFRAXBP: {
    type: PriceFeedType.CURVE_CRYPTO_ORACLE,
    assets: ["OHM", "crvFRAX"],
  },

  crvCRVETH: {
    type: PriceFeedType.CURVE_CRYPTO_ORACLE,
    assets: ["WETH", "CRV"],
  },

  crvCVXETH: {
    type: PriceFeedType.CURVE_CRYPTO_ORACLE,
    assets: ["WETH", "CVX"],
  },

  crvUSDTWBTCWETH: {
    type: PriceFeedType.CURVE_CRYPTO_ORACLE,
    assets: ["USDT", "WBTC", "WETH"],
  },

  LDOETH: {
    type: PriceFeedType.CURVE_CRYPTO_ORACLE,
    assets: ["LDO", "WETH"],
  },

  crvUSD: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  crvUSDUSDC: {
    type: PriceFeedType.CURVE_2LP_ORACLE,
    assets: ["crvUSD", "USDC"],
  },
  crvUSDUSDT: {
    type: PriceFeedType.CURVE_2LP_ORACLE,
    assets: ["crvUSD", "USDT"],
  },
  crvUSDFRAX: {
    type: PriceFeedType.CURVE_2LP_ORACLE,
    assets: ["crvUSD", "FRAX"],
  },
  crvUSDETHCRV: {
    type: PriceFeedType.CURVE_CRYPTO_ORACLE,
    assets: ["crvUSD", "WETH", "CRV"],
  },

  rETH_f: {
    type: PriceFeedType.CURVE_CRYPTO_ORACLE,
    assets: ["rETH", "WETH"],
  },
  // YEARN- CURVE TOKENS
  yvCurve_stETH: {
    type: PriceFeedType.YEARN_ORACLE,
    token: "steCRV",
  },
  yvCurve_FRAX: {
    type: PriceFeedType.YEARN_ORACLE,
    token: "FRAX3CRV",
  },

  // CVX tokens
  cvx3Crv: {
    type: PriceFeedType.THE_SAME_AS,
    token: "3Crv",
  },
  cvxcrvFRAX: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvFRAX",
  },
  cvxsteCRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "steCRV",
  },
  cvxFRAX3CRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "FRAX3CRV",
  },
  cvxLUSD3CRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "LUSD3CRV",
  },
  cvxcrvPlain3andSUSD: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvPlain3andSUSD",
  },
  cvxgusd3CRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "gusd3CRV",
  },
  cvxOHMFRAXBP: {
    type: PriceFeedType.THE_SAME_AS,
    token: "OHMFRAXBP",
  },
  cvxMIM_3LP3CRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "MIM_3LP3CRV",
  },

  cvxcrvCRVETH: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvCRVETH",
  },
  cvxcrvCVXETH: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvCVXETH",
  },
  cvxcrvUSDTWBTCWETH: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvUSDTWBTCWETH",
  },

  cvxLDOETH: {
    type: PriceFeedType.THE_SAME_AS,
    token: "LDOETH",
  },

  cvxcrvUSDETHCRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvUSDETHCRV",
  },

  // CVX tokens
  stkcvx3Crv: {
    type: PriceFeedType.THE_SAME_AS,
    token: "3Crv",
  },
  stkcvxcrvFRAX: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvFRAX",
  },
  stkcvxsteCRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "steCRV",
  },
  stkcvxFRAX3CRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "FRAX3CRV",
  },
  stkcvxLUSD3CRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "LUSD3CRV",
  },
  stkcvxcrvPlain3andSUSD: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvPlain3andSUSD",
  },
  stkcvxgusd3CRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "gusd3CRV",
  },
  stkcvxOHMFRAXBP: {
    type: PriceFeedType.THE_SAME_AS,
    token: "OHMFRAXBP",
  },
  stkcvxMIM_3LP3CRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "MIM_3LP3CRV",
  },
  stkcvxcrvCRVETH: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvCRVETH",
  },
  stkcvxcrvCVXETH: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvCVXETH",
  },
  stkcvxcrvUSDTWBTCWETH: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvUSDTWBTCWETH",
  },
  stkcvxLDOETH: {
    type: PriceFeedType.THE_SAME_AS,
    token: "LDOETH",
  },
  stkcvxcrvUSDETHCRV: {
    type: PriceFeedType.THE_SAME_AS,
    token: "crvUSDETHCRV",
  },
  "50OHM_50DAI": {
    type: PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE,

    assets: ["OHM", "DAI"],
  },
  "50OHM_50WETH": {
    type: PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE,
    assets: ["OHM", "WETH"],
  },
  OHM_wstETH: {
    type: PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE,
    assets: ["OHM", "wstETH"],
  },
  USDC_DAI_USDT: {
    type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
    assets: ["USDC", "DAI", "USDT"],
  },

  B_rETH_STABLE: {
    type: PriceFeedType.BALANCER_STABLE_LP_ORACLE,
    assets: ["rETH", "WETH"],
  },

  // GEARBOX
  dDAI: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  dUSDC: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  dWBTC: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  dWETH: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  dwstETH: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  dFRAX: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },

  GEAR: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },
  // AAVE
  aDAI: {
    type: PriceFeedType.THE_SAME_AS,
    token: "DAI",
  },
  aUSDC: {
    type: PriceFeedType.THE_SAME_AS,
    token: "USDC",
  },
  aUSDT: {
    type: PriceFeedType.THE_SAME_AS,
    token: "USDT",
  },
  aWETH: {
    type: PriceFeedType.THE_SAME_AS,
    token: "WETH",
  },
  waDAI: {
    type: PriceFeedType.WRAPPED_AAVE_V2_ORACLE,
    underlying: "aDAI",
  },
  waUSDC: {
    type: PriceFeedType.WRAPPED_AAVE_V2_ORACLE,
    underlying: "aUSDC",
  },
  waUSDT: {
    type: PriceFeedType.WRAPPED_AAVE_V2_ORACLE,
    underlying: "aUSDT",
  },
  waWETH: {
    type: PriceFeedType.WRAPPED_AAVE_V2_ORACLE,
    underlying: "aWETH",
  },
  cDAI: {
    type: PriceFeedType.COMPOUND_V2_ORACLE,
    underlying: "DAI",
  },
  cUSDC: {
    type: PriceFeedType.COMPOUND_V2_ORACLE,
    underlying: "USDC",
  },
  cUSDT: {
    type: PriceFeedType.COMPOUND_V2_ORACLE,
    underlying: "USDT",
  },
  cLINK: {
    type: PriceFeedType.COMPOUND_V2_ORACLE,
    underlying: "LINK",
  },
  cETH: {
    type: PriceFeedType.COMPOUND_V2_ORACLE,
    underlying: "WETH",
  },
  fUSDC: {
    type: PriceFeedType.COMPOUND_V2_ORACLE,
    underlying: "USDC",
  },
  MKR: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xec1D1B3b0443256cc3860e24a46F108e699484Aa",
          trusted: false,
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
  },
  RPL: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
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
  },
  APE: {
    type: PriceFeedType.NETWORK_DEPENDENT,
    feeds: {
      Mainnet: {
        Main: {
          type: PriceFeedType.CHAINLINK_ORACLE,
          address: "0xD10aBbC76679a20055E167BB80A24ac851b37056",
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
  },
  // ERC4626
  sDAI: {
    type: PriceFeedType.ERC4626_VAULT_ORACLE,
    underlying: "DAI",
  },
  YieldETH: {
    type: PriceFeedType.ERC4626_VAULT_ORACLE,
    underlying: "WETH",
  },
  // AURA
  auraB_rETH_STABLE: {
    type: PriceFeedType.THE_SAME_AS,
    token: "B_rETH_STABLE",
  },
  auraB_rETH_STABLE_vault: {
    type: PriceFeedType.THE_SAME_AS,
    token: "B_rETH_STABLE",
  },
};
