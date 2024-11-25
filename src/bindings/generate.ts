import * as fs from "fs";

import { AdapterInterface } from "../contracts/adapters";
import {
  contractParams,
  contractsByNetwork,
  SupportedContract,
} from "../contracts/contracts";
import { CHAINS, getNetworkType, supportedChains } from "../core/chains";
import { NOT_DEPLOYED } from "../core/constants";
import { priceFeedsByToken, pythByNetwork } from "../oracles/priceFeeds";
import {
  CompositeOracleData,
  HOUR_24,
  PriceFeedData,
  PriceFeedType,
  RedstoneOracleData,
} from "../oracles/pricefeedType";
import { CurveLPTokenData } from "../tokens/curveLP";
import {
  LPTokens,
  lpTokens,
  SupportedToken,
  supportedTokens,
  tokenDataByNetwork,
} from "../tokens/token";
import { PhantomTokenType, TokenType } from "../tokens/tokenType";
import { safeEnum } from "../utils/safeEnum";

class BindingsGenerator {
  tokens: Array<SupportedToken>;

  constructor() {
    this.tokens = Object.keys(supportedTokens) as Array<SupportedToken>;
  }

  generateTokens() {
    const tokensConstants = this.tokens
      .map(
        (t, index) => `uint256 constant TOKEN_${safeEnum(t)} = ${index + 2};`,
      )
      .join("\n");
    let data = `uint256 constant TOKEN_NO_TOKEN = 0;
                uint256 constant TOKEN_LUNA = 1;
                ${tokensConstants}`;

    data += `uint256 constant NUM_TOKENS = ${this.tokens.length + 2};`;

    const tokenTypeEnum = Object.values(TokenType)
      .filter(v => isNaN(Number(v)))
      .map(t => safeEnum(t as string))
      .join(",\n");

    data += `enum TokenType {${tokenTypeEnum}}`;

    const phantomTokenTypeEnum = Object.values(PhantomTokenType)
      .filter(v => isNaN(Number(v)))
      .map(t => safeEnum(t as string))
      .join(",\n");

    data += `enum PhantomTokenType {${phantomTokenTypeEnum}}`;

    this.makeBindings("Tokens.sol", data);
  }

  generateNetworkDetector() {
    let data = "// ---------------- Networks ---------------------\n";
    data += supportedChains
      .map(chain => `connectedNetworks.push(${CHAINS[chain]});`)
      .join("\n");

    for (const chain of supportedChains) {
      const chainId = CHAINS[chain];
      data += `usdcByNetwork[${chainId}] = ${tokenDataByNetwork[chain].USDC};\n`;
    }

    this.makeBindings("NetworkDetector.sol", data);
  }

  /// ---------------- TokensDataLive.sol ---------------------

  generateTokenData() {
    let data = "";

    for (const chain of supportedChains) {
      const chainId = CHAINS[chain];
      data += this.tokens
        .map(t => {
          const addr = tokenDataByNetwork[chain][t];

          if (addr !== NOT_DEPLOYED) {
            return `tokenDataByNetwork[${chainId}].push(TokenData({ id: ${this.tokensEnum(
              t,
            )}, addr: ${addr}, symbol: "${t}", tokenType: TokenType.${
              "AllNetworks" in supportedTokens[t].type
                ? TokenType[supportedTokens[t].type["AllNetworks"] as TokenType]
                : TokenType[supportedTokens[t].type[chain] as TokenType]
            } }));`;
          } else return "";
        })

        .join("\n");
    }

    this.makeBindings("TokensData.sol", data);
  }

  /// ---------------- PriceFeedType.sol -----------------------------
  generatePriceFeedType() {
    const priceFeedTypeEnum = Object.values(PriceFeedType)
      .filter(v => isNaN(Number(v)))
      .map(t => safeEnum(t as string))
      .join(",\n");

    const data = `enum PriceFeedType {${priceFeedTypeEnum}}`;

    this.makeBindings("PriceFeedType.sol", data);
  }

  /// ---------------- PriceFeedDataLive.sol -----------------------------
  generatePriceFeedData() {
    let data = "";
    for (let [token, pf] of Object.entries(priceFeedsByToken)) {
      data += `// ------------------------ ${token} ------------------------\n`;

      for (const chain of supportedChains) {
        const chainId = CHAINS[chain];

        const pfData =
          "AllNetworks" in pf ? pf["AllNetworks"]?.Main : pf[chain]?.Main;

        if (!pfData) {
          console.warn(`No Main price feed data for ${token} on ${chain}`);
          continue;
        }

        const priceFeedData = this.getPriceFeedData(
          token,
          pfData,
          chainId,
          false,
        );
        if (priceFeedData) {
          data += priceFeedData;
        } else {
          console.warn(`No price feed data for ${token}`);
        }

        const pfDataReserve =
          "AllNetworks" in pf ? pf["AllNetworks"]?.Reserve : pf[chain]?.Reserve;

        if (!pfDataReserve) {
          console.warn(`No Reserve price feed data for ${token} on ${chain}`);
          continue;
        }

        const priceFeedDataReserve = this.getPriceFeedData(
          token,
          pfDataReserve,
          chainId,
          true,
        );
        if (priceFeedData) {
          data += priceFeedDataReserve;
        } else {
          console.warn(`No price feed data for ${token}`);
        }
      }

      data += "\n\n";
    }
    this.makeBindings("PriceFeedDataLive.sol", data);
  }

  protected getPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    reserve: boolean,
  ): string | undefined {
    let result = this.generateChainlinkPriceFeedData(
      token,
      priceFeedData,
      chainId,
      reserve,
    );
    if (result) return result;

    result = this.generateSingeTokenPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "zeroPriceFeedsByNetwork",
      PriceFeedType.ZERO_ORACLE,
      reserve,
    );
    if (result) return result;

    result = this.generateCurvePriceFeedData(
      token,
      priceFeedData,
      chainId,
      reserve,
    );
    if (result) return result;

    result = this.generateTheSamePriceFeedData(
      token,
      priceFeedData,
      chainId,
      reserve,
    );
    if (result) return result;

    result = this.generateBoundedPriceFeedData(
      token,
      priceFeedData,
      chainId,
      reserve,
    );
    if (result) return result;

    result = this.generateCompositePriceFeedData(
      token,
      priceFeedData,
      chainId,
      reserve,
    );
    if (result) return result;

    result = this.generateSingeTokenPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "yearnPriceFeedsByNetwork",
      PriceFeedType.YEARN_ORACLE,
      reserve,
    );
    if (result) return result;

    result = this.generateSingeTokenPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "wstethPriceFeedByNetwork",
      PriceFeedType.WSTETH_ORACLE,
      reserve,
    );
    if (result) return result;

    result = this.generateGenericLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "wrappedAaveV2PriceFeedsByNetwork",
      PriceFeedType.WRAPPED_AAVE_V2_ORACLE,
      reserve,
    );
    if (result) return result;

    result = this.generateGenericLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "compoundV2PriceFeedsByNetwork",
      PriceFeedType.COMPOUND_V2_ORACLE,
      reserve,
    );
    if (result) return result;

    result = this.generateGenericLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "erc4626PriceFeedsByNetwork",
      PriceFeedType.ERC4626_VAULT_ORACLE,
      reserve,
    );
    if (result) return result;

    result = this.generateCrvUSDPriceFeedData(
      token,
      priceFeedData,
      chainId,
      reserve,
    );
    if (result) return result;

    result = this.generateBalancerLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "balancerStableLPPriceFeedsByNetwork",
      PriceFeedType.BALANCER_STABLE_LP_ORACLE,
      reserve,
    );
    if (result) return result;

    result = this.generateBalancerLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "balancerWeightedLPPriceFeedsByNetwork",
      PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE,
      reserve,
    );

    if (result) return result;

    result = this.generateRedStoneFeedData(
      token,
      priceFeedData,
      chainId,
      reserve,
    );
    if (result) return result;

    result = this.generatePythFeedData(token, priceFeedData, chainId, reserve);
    if (result) return result;

    result = this.generateGenericLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "mellowLRTPriceFeedsByNetwork",
      PriceFeedType.MELLOW_LRT_ORACLE,
      reserve,
    );
    if (result) return result;

    result = this.generatePendlePriceFeedData(
      token,
      priceFeedData,
      chainId,
      reserve,
    );
    if (result) return result;

    return undefined;
  }

  protected generateChainlinkPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.CHAINLINK_ORACLE) {
      const address: string = priceFeedData.address;

      return address && address !== NOT_DEPLOYED
        ? `chainlinkPriceFeedsByNetwork[${chainId}].push(ChainlinkPriceFeedData({
    token: ${this.tokensEnum(token)},
    priceFeed: ${address},
    stalenessPeriod: ${priceFeedData.stalenessPeriod || HOUR_24},
    trusted: ${
      !reserve
        ? (priceFeedData as PriceFeedData & { trusted: boolean }).trusted
        : false
    },
    reserve: ${reserve}
  }));`
        : undefined;
    }

    return undefined;
  }

  protected generateCurvePriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    reserve: boolean,
  ): string | undefined {
    if (
      priceFeedData.type === PriceFeedType.CURVE_2LP_ORACLE ||
      priceFeedData.type === PriceFeedType.CURVE_3LP_ORACLE ||
      priceFeedData.type === PriceFeedType.CURVE_4LP_ORACLE ||
      priceFeedData.type === PriceFeedType.CURVE_CRYPTO_ORACLE
    ) {
      const assets = priceFeedData.assets
        .map(t => this.tokensEnum(t))
        .join(", ");

      const mapping =
        priceFeedData.type === PriceFeedType.CURVE_CRYPTO_ORACLE
          ? "curveCryptoPriceFeedsByNetwork"
          : "curvePriceFeedsByNetwork";

      return `${mapping}[${chainId}].push(CurvePriceFeedData({
        lpToken: ${this.tokensEnum(token)},
        assets: TokensLib.arrayOf(${assets}),
        pool: Contracts.${
          (lpTokens[token as LPTokens] as CurveLPTokenData).pool
        },
        trusted: ${
          !reserve
            ? (priceFeedData as PriceFeedData & { trusted: boolean }).trusted
            : false
        },
        reserve: ${reserve}
      }));`;
    } else return undefined;
  }

  protected generateTheSamePriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.THE_SAME_AS) {
      const symbol = priceFeedData.token;
      return `theSamePriceFeedsByNetwork[${chainId}].push(TheSamePriceFeedData({
    token: ${this.tokensEnum(token)},
    tokenHasSamePriceFeed: ${this.tokensEnum(symbol as SupportedToken)},
    trusted: ${
      !reserve
        ? (priceFeedData as PriceFeedData & { trusted: boolean }).trusted
        : false
    },
    reserve: ${reserve}
  }));`;
    } else return undefined;
  }

  protected generateBoundedPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.BOUNDED_ORACLE) {
      if (priceFeedData.priceFeed.type === PriceFeedType.CHAINLINK_ORACLE) {
        const targetPriceFeed: string | undefined =
          priceFeedData.priceFeed.address;

        return targetPriceFeed !== NOT_DEPLOYED
          ? `boundedPriceFeedsByNetwork[${chainId}].push(BoundedPriceFeedData({
  token: ${this.tokensEnum(token)},
  priceFeed: ${targetPriceFeed},
  stalenessPeriod: ${priceFeedData.priceFeed.stalenessPeriod || HOUR_24},
  upperBound: ${priceFeedData.upperBound},
  trusted: ${
    !reserve
      ? (priceFeedData as PriceFeedData & { trusted: boolean }).trusted
      : false
  },
  reserve: ${reserve}
}));`
          : undefined;
      } else
        throw new Error(
          "Bounded price feed generation supports Chainlink only",
        );
    } else return undefined;
  }

  generateCompositePriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.COMPOSITE_ORACLE) {
      let targetToBaseFeedStr: string;
      let isTargetRedstone: boolean;
      let signers = [];
      if (
        priceFeedData.targetToBasePriceFeed.type ===
        PriceFeedType.CHAINLINK_ORACLE
      ) {
        targetToBaseFeedStr = `cpf.targetToBaseFeed = ${priceFeedData.targetToBasePriceFeed.address};`;

        const targetToBaseFeed = priceFeedData.targetToBasePriceFeed.address;
        if (targetToBaseFeed === NOT_DEPLOYED) return undefined;

        isTargetRedstone = false;
      } else if (
        priceFeedData.targetToBasePriceFeed.type ===
        PriceFeedType.REDSTONE_ORACLE
      ) {
        const targetToBaseRedstoneData = priceFeedData.targetToBasePriceFeed;
        for (let i = 0; i < 10; i++) {
          signers.push(
            i < targetToBaseRedstoneData.signers.length
              ? targetToBaseRedstoneData.signers[i]
              : "address(0)",
          );
        }

        targetToBaseFeedStr = `cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
          dataServiceId: "${targetToBaseRedstoneData.dataServiceId}",
          dataFeedId: "${targetToBaseRedstoneData.dataId}",
          signers: [${signers.join(",")}],
          signersThreshold: ${targetToBaseRedstoneData.signersThreshold}
        });`;

        isTargetRedstone = true;
      } else throw new Error("Unsupported targetToBasePriceFeed type");

      let baseToUSDFeedStr: string;

      let isBaseComposite: boolean;
      if (
        priceFeedData.baseToUsdPriceFeed.type === PriceFeedType.CHAINLINK_ORACLE
      ) {
        const baseToUSDFeed = priceFeedData.baseToUsdPriceFeed.address;
        if (baseToUSDFeed === NOT_DEPLOYED) return undefined;

        baseToUSDFeedStr = `cpf.baseToUSDFeed = ${baseToUSDFeed};
        cpf.baseStalenessPeriod = ${
          priceFeedData.baseToUsdPriceFeed.stalenessPeriod || HOUR_24
        };`;
        isBaseComposite = false;
      } else if (
        priceFeedData.baseToUsdPriceFeed.type === PriceFeedType.COMPOSITE_ORACLE
      ) {
        const baseToUSDCompositeData = priceFeedData.baseToUsdPriceFeed;

        if (
          baseToUSDCompositeData.targetToBasePriceFeed.type ===
            PriceFeedType.CHAINLINK_ORACLE &&
          baseToUSDCompositeData.baseToUsdPriceFeed.type ===
            PriceFeedType.CHAINLINK_ORACLE
        ) {
          baseToUSDFeedStr = `cpf.compositeBaseToUSDData = CompositePriceFeedDataShort({
        targetToBaseFeed: ${
          baseToUSDCompositeData.targetToBasePriceFeed.address
        },
        targetStalenessPeriod: ${
          baseToUSDCompositeData.targetToBasePriceFeed.stalenessPeriod ||
          HOUR_24
        },
        baseToUSDFeed: ${baseToUSDCompositeData.baseToUsdPriceFeed.address},
        baseStalenessPeriod: ${
          baseToUSDCompositeData.baseToUsdPriceFeed.stalenessPeriod || HOUR_24
        }
      });`;
          isBaseComposite = true;
        } else throw new Error("Unsupported baseToUsdPriceFeed type");
      } else throw new Error("Unsupported baseToUsdPriceFeed type");

      return `
      {
      CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[${chainId}].push();
      cpf.token = ${this.tokensEnum(token)};
      cpf.isTargetRedstone = ${isTargetRedstone};
      ${targetToBaseFeedStr}
      cpf.targetStalenessPeriod = ${
        priceFeedData.targetToBasePriceFeed.stalenessPeriod || HOUR_24
      };
      cpf.isBaseComposite = ${isBaseComposite};
      ${baseToUSDFeedStr}
      
      cpf.trusted = ${
        !reserve
          ? (priceFeedData as PriceFeedData & { trusted: boolean }).trusted
          : false
      };
      cpf.reserve = ${reserve};
      }`;
    } else return undefined;
  }

  protected generateSingeTokenPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    varName: string,
    oracleType: PriceFeedType,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === oracleType) {
      const structure = `SingeTokenPriceFeedData({ token: ${this.tokensEnum(
        token,
      )},
      trusted: ${
        !reserve
          ? (priceFeedData as PriceFeedData & { trusted: boolean }).trusted
          : false
      },
      reserve: ${reserve}
     })`;

      return oracleType === PriceFeedType.WSTETH_ORACLE
        ? `${varName}[${chainId}] = ${structure};`
        : `${varName}[${chainId}].push(${structure});`;
    }
    return undefined;
  }

  protected generateGenericLPPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    varName: string,
    oracleType: PriceFeedType,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === oracleType) {
      if (
        priceFeedData.type === PriceFeedType.WRAPPED_AAVE_V2_ORACLE ||
        priceFeedData.type === PriceFeedType.COMPOUND_V2_ORACLE ||
        priceFeedData.type === PriceFeedType.ERC4626_VAULT_ORACLE ||
        priceFeedData.type === PriceFeedType.MELLOW_LRT_ORACLE
      ) {
        return `${varName}[${chainId}].push(GenericLPPriceFeedData({ lpToken: ${this.tokensEnum(
          token,
        )}, underlying: ${this.tokensEnum(
          priceFeedData.underlying as SupportedToken,
        )},
        trusted: ${
          !reserve
            ? (priceFeedData as PriceFeedData & { trusted: boolean }).trusted
            : false
        },
        reserve: ${reserve}
      }));`;
      }
    }
    return undefined;
  }

  protected generateCrvUSDPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.CURVE_USD_ORACLE) {
      return `crvUSDPriceFeedsByNetwork[${chainId}].push(CrvUsdPriceFeedData({ token: ${this.tokensEnum(
        token,
      )}, 
      pool: Contracts.${(lpTokens[token as LPTokens] as CurveLPTokenData).pool},
      underlying: ${this.tokensEnum(
        priceFeedData.underlying as SupportedToken,
      )},
      trusted: ${
        !reserve
          ? (priceFeedData as PriceFeedData & { trusted: boolean }).trusted
          : false
      },
      reserve: ${reserve}
    }));`;
    }
    return undefined;
  }

  protected generateBalancerLPPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    varName: string,
    oracleType: PriceFeedType,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === oracleType) {
      if (
        priceFeedData.type === PriceFeedType.BALANCER_STABLE_LP_ORACLE ||
        priceFeedData.type === PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE
      ) {
        return `${varName}[${chainId}].push(BalancerLPPriceFeedData({ lpToken: ${this.tokensEnum(
          token,
        )}, assets: TokensLib.arrayOf(${priceFeedData.assets
          .map(t => this.tokensEnum(t))
          .join(",")}),
          trusted: ${
            !reserve
              ? (priceFeedData as PriceFeedData & { trusted: boolean }).trusted
              : false
          },
          reserve: ${reserve}
        }));`;
      }
    }
    return undefined;
  }

  protected generateRedStoneFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.REDSTONE_ORACLE) {
      const signers = [];
      for (let i = 0; i < 10; i++) {
        signers.push(
          i < priceFeedData.signers.length
            ? priceFeedData.signers[i]
            : "address(0)",
        );
      }

      return `redStonePriceFeedsByNetwork[${chainId}].push(RedStonePriceFeedData({ 
            token: ${this.tokensEnum(token)},
            dataServiceId: "${priceFeedData.dataServiceId}", 
            dataFeedId: "${priceFeedData.dataId}", signers: [${signers.join(
              ",",
            )}], signersThreshold: ${priceFeedData.signersThreshold},
            trusted: ${
              !reserve
                ? (priceFeedData as PriceFeedData & { trusted: boolean })
                    .trusted
                : false
            },
            reserve: ${reserve}
          }));`;
    }
    return undefined;
  }

  protected generatePythFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.PYTH_ORACLE) {
      return `pythPriceFeedsByNetwork[${chainId}].push(PythPriceFeedData({ 
            token: ${this.tokensEnum(token)},
            priceFeedId: ${priceFeedData.priceFeedId}, 
            ticker: "${priceFeedData.ticker}",
            pyth: ${pythByNetwork[getNetworkType(chainId)]},
            trusted: ${
              !reserve
                ? (priceFeedData as PriceFeedData & { trusted: boolean })
                    .trusted
                : false
            },
            reserve: ${reserve}
          }));`;
    }
    return undefined;
  }

  protected generatePendlePriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    reserve: boolean,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.PENDLE_PT_TWAP_ORACLE) {
      return `pendlePriceFeedsByNetwork[${chainId}].push(PendlePriceFeedData({ token: ${this.tokensEnum(
        token,
      )}, 
      underlying: ${this.tokensEnum(
        priceFeedData.underlying as SupportedToken,
      )},
      market: ${priceFeedData.market},
      twapWindow: ${priceFeedData.twapWindow},
      trusted: ${
        !reserve
          ? (priceFeedData as PriceFeedData & { trusted: boolean }).trusted
          : false
      },
      reserve: ${reserve}
    }));`;
    }
    return undefined;
  }

  /// ---------------- SupportedContracts.sol -----------------------------

  generateSupportedContracts() {
    const contracts: Array<SupportedContract> = Object.keys(
      contractsByNetwork.Mainnet,
    ) as Array<SupportedContract>;

    let data = `enum Contracts {NO_CONTRACT, ${contracts.join(",\n")} }`;

    this.makeBindings("ContractType.sol", data);

    data = "";
    for (const chain of supportedChains) {
      const chainId = CHAINS[chain];

      data += contracts
        .map(t => {
          if (contractsByNetwork[chain][t] !== NOT_DEPLOYED) {
            return `contractDataByNetwork[${chainId}].push(ContractData({ id: Contracts.${t}, addr:  ${contractsByNetwork[chain][t]}, name: "${t}" }));`;
          } else return "";
        })
        .join("\n");
    }

    this.makeBindings(
      "SupportedContracts.sol",

      data,
    );
  }
  /// ---------------- AdapterType.sol -----------------------------

  generateAdapterType() {
    const adapterTypeEnum = Object.values(AdapterInterface)
      .filter(v => isNaN(Number(v)))
      .map(t => safeEnum(t as string))
      .join(",\n");

    const data = `enum AdapterType {${adapterTypeEnum}}`;
    this.makeBindings("AdapterType.sol", data);
  }

  /// ---------------- AdapterData.sol -----------------------------
  generateAdapterData() {
    let data = Object.entries(contractParams)
      .filter(
        ([, contractParam]) =>
          contractParam.type === AdapterInterface.UNISWAP_V2_ROUTER ||
          contractParam.type === AdapterInterface.UNISWAP_V3_ROUTER ||
          contractParam.type === AdapterInterface.YEARN_V2 ||
          contractParam.type === AdapterInterface.CONVEX_V1_BOOSTER ||
          contractParam.type === AdapterInterface.LIDO_V1 ||
          contractParam.type === AdapterInterface.UNIVERSAL ||
          contractParam.type === AdapterInterface.LIDO_WSTETH_V1 ||
          contractParam.type === AdapterInterface.AAVE_V2_LENDING_POOL ||
          contractParam.type === AdapterInterface.AAVE_V2_WRAPPED_ATOKEN ||
          contractParam.type === AdapterInterface.COMPOUND_V2_CERC20 ||
          contractParam.type === AdapterInterface.COMPOUND_V2_CETHER ||
          contractParam.type === AdapterInterface.ERC4626_VAULT ||
          contractParam.type === AdapterInterface.BALANCER_VAULT ||
          contractParam.type === AdapterInterface.VELODROME_V2_ROUTER ||
          contractParam.type === AdapterInterface.CAMELOT_V3_ROUTER ||
          contractParam.type === AdapterInterface.CONVEX_L2_BOOSTER ||
          contractParam.type === AdapterInterface.CONVEX_L2_REWARD_POOL ||
          contractParam.type === AdapterInterface.AAVE_V3_LENDING_POOL ||
          contractParam.type === AdapterInterface.ZIRCUIT_POOL ||
          contractParam.type === AdapterInterface.MELLOW_LRT_VAULT ||
          contractParam.type === AdapterInterface.PENDLE_ROUTER ||
          contractParam.type === AdapterInterface.DAI_USDS_EXCHANGE,
      )
      .map(
        ([contract, contractParam]) =>
          `simpleAdapters.push(SimpleAdapter({targetContract:  Contracts.${contract},
        adapterType: AdapterType.${AdapterInterface[contractParam.type]}}));`,
      )
      .join("\n");

    data += Object.entries(contractParams)
      .filter(
        ([, contractParam]) =>
          contractParam.type === AdapterInterface.CURVE_V1_2ASSETS ||
          contractParam.type === AdapterInterface.CURVE_V1_3ASSETS ||
          contractParam.type === AdapterInterface.CURVE_V1_4ASSETS ||
          contractParam.type === AdapterInterface.CURVE_STABLE_NG,
      )
      .map(([contract, contractParam]) => {
        if (
          contractParam.type === AdapterInterface.CURVE_V1_2ASSETS ||
          contractParam.type === AdapterInterface.CURVE_V1_3ASSETS ||
          contractParam.type === AdapterInterface.CURVE_V1_4ASSETS ||
          contractParam.type === AdapterInterface.CURVE_STABLE_NG
        ) {
          if (contractParam.lpToken === "GEAR") return "";
          let basePool: SupportedContract | "NO_CONTRACT" = "NO_CONTRACT";
          for (let coin of contractParam.tokens) {
            const coinParams = supportedTokens[coin];
            if (
              (coinParams.type["AllNetworks"] as TokenType) ===
              TokenType.CURVE_LP_TOKEN
            ) {
              basePool = (coinParams as CurveLPTokenData).pool;
            }
          }
          return `curveAdapters.push(CurveAdapter({targetContract:  Contracts.${contract},
      adapterType: AdapterType.${
        AdapterInterface[contractParam.type]
      }, lpToken: TOKEN_${safeEnum(
        contractParam.lpToken,
      )}, basePool: Contracts.${basePool}}));`;
        }

        return "";
      })
      .join("\n");

    data += Object.entries(contractParams)
      .filter(
        ([, contractParam]) =>
          contractParam.type === AdapterInterface.CURVE_V1_STECRV_POOL,
      )
      .map(([contract, contractParam]) => {
        if (contractParam.type === AdapterInterface.CURVE_V1_STECRV_POOL) {
          return `curveStEthAdapters.push(CurveStETHAdapter({curveETHGateway:  Contracts.${contract},
        adapterType: AdapterType.${
          AdapterInterface[contractParam.type]
        }, lpToken: ${this.tokensEnum(contractParam.lpToken)}}));`;
        }
        return "";
      })
      .join("\n");

    data += Object.entries(contractParams)
      .filter(
        ([, contractParam]) =>
          contractParam.type === AdapterInterface.CURVE_V1_WRAPPER,
      )
      .map(([contract, contractParam]) => {
        if (contractParam.type === AdapterInterface.CURVE_V1_WRAPPER) {
          return `curveWrappers.push(CurveWrapper({targetContract:  Contracts.${contract},
  adapterType: AdapterType.${
    AdapterInterface[contractParam.type]
  }, lpToken: ${this.tokensEnum(contractParam.lpToken)}, nCoins: ${
    contractParam.tokens.length
  }}));`;
        }
        return "";
      })
      .join("\n");

    data += Object.entries(contractParams)
      .filter(
        ([, contractParam]) =>
          contractParam.type === AdapterInterface.CONVEX_V1_BASE_REWARD_POOL &&
          this.tokens.includes(contractParam.stakedToken),
      )
      .map(([contract, contractParam]) => {
        if (
          contractParam.type === AdapterInterface.CONVEX_V1_BASE_REWARD_POOL
        ) {
          return `convexBasePoolAdapters.push(ConvexBasePoolAdapter({targetContract:  Contracts.${contract},
  adapterType: AdapterType.${
    AdapterInterface[contractParam.type]
  }, stakedToken: ${this.tokensEnum(contractParam.stakedToken)}}));`;
        }
        return "";
      })
      .join("\n");

    data += Object.entries(contractParams)
      .filter(
        ([, contractParam]) =>
          contractParam.type === AdapterInterface.STAKING_REWARDS &&
          this.tokens.includes(contractParam.stakedToken),
      )
      .map(([contract, contractParam]) => {
        if (contractParam.type === AdapterInterface.STAKING_REWARDS) {
          return `stakingRewardsAdapters.push(StakingRewardsAdapter({targetContract:  Contracts.${contract},
  adapterType: AdapterType.${
    AdapterInterface[contractParam.type]
  }, stakedToken: ${this.tokensEnum(contractParam.stakedToken)}}));`;
        }
        return "";
      })
      .join("\n");

    this.makeBindings("AdapterData.sol", data);
  }

  //
  // INTERNAL FUNCTIONS
  //

  private makeBindings(fileName: string, replacement: string) {
    let content = fs.readFileSync(`./bindings/${fileName}`, "utf8");
    content = content.replace("// $GENERATE_HERE$", replacement);
    fs.writeFileSync(`./contracts/${fileName}`, content);
  }

  private tokensEnum(t: string): string {
    return `TOKEN_${safeEnum(t)}`;
  }
}

const generator = new BindingsGenerator();

generator.generateNetworkDetector();
generator.generateTokens();
generator.generateTokenData();
generator.generatePriceFeedType();
generator.generatePriceFeedData();
generator.generateSupportedContracts();
generator.generateAdapterType();
generator.generateAdapterData();
