import * as fs from "fs";

import { AdapterInterface } from "../contracts/adapters";
import {
  contractParams,
  contractsByNetwork,
  SupportedContract,
} from "../contracts/contracts";
import { CHAINS, supportedChains } from "../core/chains";
import { NOT_DEPLOYED } from "../core/constants";
import { priceFeedsByToken } from "../oracles/priceFeeds";
import {
  HOUR_24,
  PriceFeedData,
  PriceFeedType,
} from "../oracles/pricefeedType";
import { CurveLPTokenData } from "../tokens/curveLP";
import {
  LPTokens,
  lpTokens,
  SupportedToken,
  supportedTokens,
  tokenDataByNetwork,
} from "../tokens/token";
import { TokenType } from "../tokens/tokenType";
import { safeEnum } from "../utils/safeEnum";

class BindingsGenerator {
  tokens: Array<SupportedToken>;

  constructor() {
    this.tokens = Object.keys(supportedTokens) as Array<SupportedToken>;
  }

  generateTokens() {
    const tokensEnum = this.tokens.map(t => safeEnum(t)).join(",\n");
    let data = `enum Tokens {NO_TOKEN, LUNA, ${tokensEnum}}`;

    const tokenTypeEnum = Object.values(TokenType)
      .filter(v => isNaN(Number(v)))
      .map(t => safeEnum(t as string))
      .join(",\n");

    data += `enum TokenType {${tokenTypeEnum}}`;

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
              TokenType[supportedTokens[t].type]
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
        const priceFeedData = this.getPriceFeedData(
          token,
          pf.type === PriceFeedType.NETWORK_DEPENDENT
            ? pf.feeds[chain].Main
            : pf,
          chainId,
        );
        if (priceFeedData) {
          data += priceFeedData;
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
  ): string | undefined {
    let result = this.generateChainlinkPriceFeedData(
      token,
      priceFeedData,
      chainId,
    );
    if (result) return result;

    result = this.generateSingeTokenPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "zeroPriceFeedsByNetwork",
      PriceFeedType.ZERO_ORACLE,
    );
    if (result) return result;

    result = this.generateCurvePriceFeedData(token, priceFeedData, chainId);
    if (result) return result;

    result = this.generateTheSamePriceFeedData(token, priceFeedData, chainId);
    if (result) return result;

    result = this.generateBoundedPriceFeedData(token, priceFeedData, chainId);
    if (result) return result;

    result = this.generateCompositePriceFeedData(token, priceFeedData, chainId);
    if (result) return result;

    result = this.generateSingeTokenPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "yearnPriceFeedsByNetwork",
      PriceFeedType.YEARN_ORACLE,
    );
    if (result) return result;

    result = this.generateSingeTokenPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "wstethPriceFeedByNetwork",
      PriceFeedType.WSTETH_ORACLE,
    );
    if (result) return result;

    result = this.generateGenericLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "wrappedAaveV2PriceFeedsByNetwork",
      PriceFeedType.WRAPPED_AAVE_V2_ORACLE,
    );
    if (result) return result;

    result = this.generateGenericLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "compoundV2PriceFeedsByNetwork",
      PriceFeedType.COMPOUND_V2_ORACLE,
    );
    if (result) return result;

    result = this.generateGenericLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "erc4626PriceFeedsByNetwork",
      PriceFeedType.ERC4626_VAULT_ORACLE,
    );
    if (result) return result;

    result = this.generateCrvUSDPriceFeedData(token, priceFeedData, chainId);
    if (result) return result;

    result = this.generateBalancerLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "balancerStableLPPriceFeedsByNetwork",
      PriceFeedType.BALANCER_STABLE_LP_ORACLE,
    );
    if (result) return result;

    result = this.generateBalancerLPPriceFeedData(
      token,
      priceFeedData,
      chainId,
      "balancerWeightedLPPriceFeedsByNetwork",
      PriceFeedType.BALANCER_WEIGHTED_LP_ORACLE,
    );

    if (result) return result;

    result = this.generateRedStoneFeedData(token, priceFeedData, chainId);
    if (result) return result;

    return undefined;
  }

  protected generateChainlinkPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.CHAINLINK_ORACLE) {
      const address: string = priceFeedData.address;

      return address && address !== NOT_DEPLOYED
        ? `chainlinkPriceFeedsByNetwork[${chainId}].push(ChainlinkPriceFeedData({
    token: ${this.tokensEnum(token)},
    priceFeed: ${address},
    stalenessPeriod: ${priceFeedData.stalenessPeriod || HOUR_24}
  }));`
        : undefined;
    }

    return undefined;
  }

  protected generateCurvePriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
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
        }
      }));`;
    } else return undefined;
  }

  protected generateTheSamePriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.THE_SAME_AS) {
      const symbol = priceFeedData.token;
      return `theSamePriceFeedsByNetwork[${chainId}].push(TheSamePriceFeedData({
    token: ${this.tokensEnum(token)},
    tokenHasSamePriceFeed: ${this.tokensEnum(symbol as SupportedToken)}
  }));`;
    } else return undefined;
  }

  protected generateBoundedPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.BOUNDED_ORACLE) {
      const targetPriceFeed: string | undefined = priceFeedData.priceFeed;

      return targetPriceFeed !== NOT_DEPLOYED
        ? `boundedPriceFeedsByNetwork[${chainId}].push(BoundedPriceFeedData({
  token: ${this.tokensEnum(token)},
  priceFeed: ${targetPriceFeed},
  stalenessPeriod: ${priceFeedData.stalenessPeriod || HOUR_24},
  upperBound: ${priceFeedData.upperBound}
}));`
        : undefined;
    } else return undefined;
  }

  generateCompositePriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
  ): string | undefined {
    if (
      priceFeedData.type === PriceFeedType.COMPOSITE_ORACLE &&
      priceFeedData.targetToBasePriceFeed !== NOT_DEPLOYED &&
      priceFeedData.baseToUsdPriceFeed !== NOT_DEPLOYED
    ) {
      const targetToBaseFeed = priceFeedData.targetToBasePriceFeed;
      const baseToUSDFeed = priceFeedData.baseToUsdPriceFeed;

      return `compositePriceFeedsByNetwork[${chainId}].push(CompositePriceFeedData({
        token: ${this.tokensEnum(token)},
        targetToBaseFeed: ${targetToBaseFeed},
        targetStalenessPeriod: ${
          priceFeedData.targetStalenessPeriod || HOUR_24
        },
        baseToUSDFeed: ${baseToUSDFeed},
        baseStalenessPeriod: ${priceFeedData.baseStalenessPeriod || HOUR_24}
      }));`;
    } else return undefined;
  }

  protected generateSingeTokenPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    varName: string,
    oracleType: PriceFeedType,
  ): string | undefined {
    if (priceFeedData.type === oracleType) {
      const structure = `SingeTokenPriceFeedData({ token: ${this.tokensEnum(
        token,
      )} })`;

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
  ): string | undefined {
    if (priceFeedData.type === oracleType) {
      if (
        priceFeedData.type === PriceFeedType.WRAPPED_AAVE_V2_ORACLE ||
        priceFeedData.type === PriceFeedType.COMPOUND_V2_ORACLE ||
        priceFeedData.type === PriceFeedType.ERC4626_VAULT_ORACLE
      ) {
        return `${varName}[${chainId}].push(GenericLPPriceFeedData({ lpToken: ${this.tokensEnum(
          token,
        )}, underlying: ${this.tokensEnum(
          priceFeedData.underlying as SupportedToken,
        )}}));`;
      }
    }
    return undefined;
  }

  protected generateCrvUSDPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
  ): string | undefined {
    if (priceFeedData.type === PriceFeedType.CURVE_USD_ORACLE) {
      return `crvUSDPriceFeedsByNetwork[${chainId}].push(CrvUsdPriceFeedData({ token: ${this.tokensEnum(
        token,
      )}, 
      pool: Contracts.${priceFeedData.pool},
      underlying: ${this.tokensEnum(
        priceFeedData.underlying as SupportedToken,
      )}}));`;
    }
    return undefined;
  }

  protected generateBalancerLPPriceFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
    varName: string,
    oracleType: PriceFeedType,
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
          .join(",")})}));`;
      }
    }
    return undefined;
  }

  protected generateRedStoneFeedData(
    token: string,
    priceFeedData: PriceFeedData,
    chainId: number,
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
            )}], signersThreshold: ${priceFeedData.signersThreshold} }));`;
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
          contractParam.type === AdapterInterface.BALANCER_VAULT,
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
          contractParam.type === AdapterInterface.CURVE_V1_4ASSETS,
      )
      .map(([contract, contractParam]) => {
        if (
          contractParam.type === AdapterInterface.CURVE_V1_2ASSETS ||
          contractParam.type === AdapterInterface.CURVE_V1_3ASSETS ||
          contractParam.type === AdapterInterface.CURVE_V1_4ASSETS
        ) {
          if (contractParam.lpToken === "GEAR") return "";
          let basePool: SupportedContract | "NO_CONTRACT" = "NO_CONTRACT";
          for (let coin of contractParam.tokens) {
            const coinParams = supportedTokens[coin];
            if (coinParams.type === TokenType.CURVE_LP_TOKEN) {
              basePool = coinParams.pool;
            }
          }
          return `curveAdapters.push(CurveAdapter({targetContract:  Contracts.${contract},
      adapterType: AdapterType.${
        AdapterInterface[contractParam.type]
      }, lpToken: Tokens.${safeEnum(
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
          return `curveStEthAdapter = CurveStETHAdapter({curveETHGateway:  Contracts.${contract},
        adapterType: AdapterType.${
          AdapterInterface[contractParam.type]
        }, lpToken: ${this.tokensEnum(contractParam.lpToken)}});`;
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
    return `Tokens.${safeEnum(t)}`;
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
