/*
 * SPDX-License-Identifier: BSL-1.1
 * Gearbox. Generalized leverage protocol, which allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
 * (c) Gearbox.fi, 2021
 */
import { NetworkType } from "../core/chains";
import { NOT_DEPLOYED } from "../core/constants";
import { AaveV2LPToken } from "../tokens/aave";
import { AuraStakedToken } from "../tokens/aura";
import { ConvexStakedPhantomToken } from "../tokens/convex";
import type { CurveLPToken } from "../tokens/curveLP";
import { NormalToken } from "../tokens/normal";
import { tokenDataByNetwork } from "../tokens/token";
import type { YearnLPToken } from "../tokens/yearn";
import { TypedObjectUtils } from "../utils/mappers";
import { AdapterInterface } from "./adapters";
import { Protocols } from "./protocols";

export type UniswapV2Contract =
  | "UNISWAP_V2_ROUTER"
  | "SUSHISWAP_ROUTER"
  | "FRAXSWAP_ROUTER";

export type CurvePoolContract =
  | "CURVE_3CRV_POOL"
  | "CURVE_FRAX_USDC_POOL"
  | "CURVE_STETH_GATEWAY"
  | "CURVE_FRAX_POOL"
  | "CURVE_LUSD_POOL"
  | "CURVE_GUSD_POOL"
  | "CURVE_SUSD_POOL"
  | "CURVE_SUSD_DEPOSIT"
  | "CURVE_OHMFRAXBP_POOL"
  | "CURVE_CRVETH_POOL"
  | "CURVE_CVXETH_POOL"
  | "CURVE_3CRYPTO_POOL"
  | "CURVE_MIM_POOL"
  | "CURVE_LDOETH_POOL"
  | "CURVE_CRVUSD_USDC_POOL"
  | "CURVE_CRVUSD_USDT_POOL"
  | "CURVE_CRVUSD_FRAX_POOL"
  | "CURVE_TRI_CRV_POOL"
  | "CURVE_RETH_ETH_POOL"
  | "CURVE_ETH_WSTETH_GATEWAY";

export type YearnVaultContract =
  | "YEARN_DAI_VAULT"
  | "YEARN_USDC_VAULT"
  | "YEARN_WETH_VAULT"
  | "YEARN_WBTC_VAULT"
  | "YEARN_USDT_VAULT"
  | "YEARN_OP_VAULT"
  | "YEARN_CURVE_FRAX_VAULT"
  | "YEARN_CURVE_STETH_VAULT";

export type ERC4626VaultContract = "MAKER_DSR_VAULT" | "YIELD_ETH_VAULT";

export type ConvexPoolContract =
  | "CONVEX_3CRV_POOL"
  | "CONVEX_FRAX_USDC_POOL"
  | "CONVEX_GUSD_POOL"
  | "CONVEX_SUSD_POOL"
  | "CONVEX_STECRV_POOL"
  | "CONVEX_FRAX3CRV_POOL"
  | "CONVEX_LUSD3CRV_POOL"
  | "CONVEX_OHMFRAXBP_POOL"
  | "CONVEX_MIM3CRV_POOL"
  | "CONVEX_CRVETH_POOL"
  | "CONVEX_CVXETH_POOL"
  | "CONVEX_3CRYPTO_POOL"
  | "CONVEX_LDOETH_POOL"
  | "CONVEX_CRVUSD_USDC_POOL"
  | "CONVEX_CRVUSD_USDT_POOL"
  | "CONVEX_CRVUSD_FRAX_POOL"
  | "CONVEX_TRI_CRV_POOL";

export type AuraPoolContract =
  | "AURA_B_RETH_STABLE_POOL"
  | "AURA_BPT_RETH_ETH_POOL"
  | "AURA_BPT_WSTETH_ETH_POOL";

export type AaveV2TokenWrapperContract =
  | "AAVE_V2_DAI_TOKEN_WRAPPER"
  | "AAVE_V2_USDC_TOKEN_WRAPPER"
  | "AAVE_V2_USDT_TOKEN_WRAPPER"
  | "AAVE_V2_WETH_TOKEN_WRAPPER";

export type CompoundV2PoolContract =
  | "COMPOUND_V2_DAI_POOL"
  | "COMPOUND_V2_USDC_POOL"
  | "COMPOUND_V2_USDT_POOL"
  | "COMPOUND_V2_ETH_GATEWAY"
  | "COMPOUND_V2_LINK_POOL"
  | "FLUX_USDC_POOL";

export type SupportedContract =
  | UniswapV2Contract
  | "UNISWAP_V3_ROUTER"
  | CurvePoolContract
  | "CURVE_GEAR_POOL"
  | YearnVaultContract
  | "CONVEX_BOOSTER"
  | ConvexPoolContract
  | "AURA_BOOSTER"
  | AuraPoolContract
  | "LIDO_STETH_GATEWAY"
  | "LIDO_WSTETH"
  | "UNIVERSAL_ADAPTER"
  | "BALANCER_VAULT"
  | "AAVE_V2_LENDING_POOL"
  | AaveV2TokenWrapperContract
  | CompoundV2PoolContract
  | ERC4626VaultContract
  | "VELODROME_V2_ROUTER";

export const contractsByNetwork: Record<
  NetworkType,
  Record<SupportedContract, string>
> = {
  Mainnet: {
    UNISWAP_V2_ROUTER: "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D",
    UNISWAP_V3_ROUTER: "0xE592427A0AEce92De3Edee1F18E0157C05861564",
    SUSHISWAP_ROUTER: "0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F",
    FRAXSWAP_ROUTER: "0xC14d550632db8592D1243Edc8B95b0Ad06703867",
    VELODROME_V2_ROUTER: NOT_DEPLOYED,

    // CURVE
    CURVE_3CRV_POOL: "0xbEbc44782C7dB0a1A60Cb6fe97d0b483032FF1C7", // SEPARATE TOKEN
    CURVE_FRAX_USDC_POOL: "0xDcEF968d416a41Cdac0ED8702fAC8128A64241A2",
    CURVE_STETH_GATEWAY: "0xEf0D72C594b28252BF7Ea2bfbF098792430815b1", // SEPARATE TOKEN
    CURVE_FRAX_POOL: tokenDataByNetwork.Mainnet.FRAX3CRV,
    CURVE_LUSD_POOL: tokenDataByNetwork.Mainnet.LUSD3CRV,
    CURVE_SUSD_POOL: "0xA5407eAE9Ba41422680e2e00537571bcC53efBfD", // SEPARATE TOKEN
    CURVE_SUSD_DEPOSIT: "0xFCBa3E75865d2d561BE8D220616520c171F12851",
    CURVE_GUSD_POOL: "0x4f062658EaAF2C1ccf8C8e36D6824CDf41167956", // SEPARATE TOKEN
    CURVE_MIM_POOL: tokenDataByNetwork.Mainnet.MIM_3LP3CRV,
    CURVE_OHMFRAXBP_POOL: "0xFc1e8bf3E81383Ef07Be24c3FD146745719DE48D",
    CURVE_CRVETH_POOL: "0x8301AE4fc9c624d1D396cbDAa1ed877821D7C511",
    CURVE_CVXETH_POOL: "0xB576491F1E6e5E62f1d8F26062Ee822B40B0E0d4",
    CURVE_3CRYPTO_POOL: tokenDataByNetwork.Mainnet.crvUSDTWBTCWETH,
    CURVE_LDOETH_POOL: "0x9409280DC1e6D33AB7A8C6EC03e5763FB61772B5",
    CURVE_ETH_WSTETH_GATEWAY: NOT_DEPLOYED,

    CURVE_GEAR_POOL: "0x0E9B5B092caD6F1c5E6bc7f89Ffe1abb5c95F1C2",

    CURVE_CRVUSD_USDC_POOL: tokenDataByNetwork.Mainnet.crvUSDUSDC,
    CURVE_CRVUSD_USDT_POOL: tokenDataByNetwork.Mainnet.crvUSDUSDT,
    CURVE_CRVUSD_FRAX_POOL: tokenDataByNetwork.Mainnet.crvUSDFRAX,
    CURVE_TRI_CRV_POOL: tokenDataByNetwork.Mainnet.crvUSDETHCRV,

    CURVE_RETH_ETH_POOL: "0x0f3159811670c117c372428D4E69AC32325e4D0F",

    // YEARN
    YEARN_DAI_VAULT: tokenDataByNetwork.Mainnet.yvDAI,
    YEARN_USDC_VAULT: tokenDataByNetwork.Mainnet.yvUSDC,
    YEARN_WETH_VAULT: tokenDataByNetwork.Mainnet.yvWETH,
    YEARN_WBTC_VAULT: tokenDataByNetwork.Mainnet.yvWBTC,
    YEARN_USDT_VAULT: tokenDataByNetwork.Mainnet.yvUSDT,
    YEARN_OP_VAULT: tokenDataByNetwork.Mainnet.yvOP,
    YEARN_CURVE_FRAX_VAULT: tokenDataByNetwork.Mainnet.yvCurve_FRAX,
    YEARN_CURVE_STETH_VAULT: tokenDataByNetwork.Mainnet.yvCurve_stETH,

    // ERC4626
    MAKER_DSR_VAULT: tokenDataByNetwork.Mainnet.sDAI,
    YIELD_ETH_VAULT: tokenDataByNetwork.Mainnet.YieldETH,

    // CONVEX
    CONVEX_BOOSTER: "0xF403C135812408BFbE8713b5A23a04b3D48AAE31",
    CONVEX_3CRV_POOL: "0x689440f2Ff927E1f24c72F1087E1FAF471eCe1c8",
    CONVEX_FRAX_USDC_POOL: "0x7e880867363A7e321f5d260Cade2B0Bb2F717B02",
    CONVEX_GUSD_POOL: "0x7A7bBf95C44b144979360C3300B54A7D34b44985",
    CONVEX_SUSD_POOL: "0x22eE18aca7F3Ee920D01F25dA85840D12d98E8Ca",
    CONVEX_STECRV_POOL: "0x0A760466E1B4621579a82a39CB56Dda2F4E70f03",
    CONVEX_FRAX3CRV_POOL: "0xB900EF131301B307dB5eFcbed9DBb50A3e209B2e",
    CONVEX_LUSD3CRV_POOL: "0x2ad92A7aE036a038ff02B96c88de868ddf3f8190",
    CONVEX_OHMFRAXBP_POOL: "0x27A8c58e3DE84280826d615D80ddb33930383fE9",
    CONVEX_MIM3CRV_POOL: "0xFd5AbF66b003881b88567EB9Ed9c651F14Dc4771",
    CONVEX_CRVETH_POOL: "0x085A2054c51eA5c91dbF7f90d65e728c0f2A270f",
    CONVEX_CVXETH_POOL: "0xb1Fb0BA0676A1fFA83882c7F4805408bA232C1fA",
    CONVEX_3CRYPTO_POOL: "0xb05262D4aaAA38D0Af4AaB244D446ebDb5afd4A7",
    CONVEX_LDOETH_POOL: "0x8CA990E954611E5E3d2cc51C013fCC372c8c1D38",
    CONVEX_CRVUSD_USDC_POOL: "0x44D8FaB7CD8b7877D5F79974c2F501aF6E65AbBA",
    CONVEX_CRVUSD_USDT_POOL: "0xD1DdB0a0815fD28932fBb194C84003683AF8a824",
    CONVEX_CRVUSD_FRAX_POOL: "0x3CfB4B26dc96B124D15A6f360503d028cF2a3c00",
    CONVEX_TRI_CRV_POOL: "0xF956a46DbA1A0a567168db8655bc18E9050C7738",

    // AURA
    AURA_BOOSTER: "0xA57b8d98dAE62B26Ec3bcC4a365338157060B234",
    AURA_B_RETH_STABLE_POOL: tokenDataByNetwork.Mainnet.auraB_rETH_STABLE_vault,
    AURA_BPT_RETH_ETH_POOL: tokenDataByNetwork.Mainnet.auraBPT_rETH_ETH_vault,
    AURA_BPT_WSTETH_ETH_POOL:
      tokenDataByNetwork.Mainnet.auraBPT_WSTETH_ETH_vault,

    // LIDO
    LIDO_STETH_GATEWAY: "0x6f4b4aB5142787c05b7aB9A9692A0f46b997C29D",
    LIDO_WSTETH: tokenDataByNetwork.Mainnet.wstETH,

    // BALANCER
    BALANCER_VAULT: "0xBA12222222228d8Ba445958a75a0704d566BF2C8",

    // GEARBOX
    UNIVERSAL_ADAPTER: "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC",

    // AAVE
    AAVE_V2_LENDING_POOL: "0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9",

    AAVE_V2_DAI_TOKEN_WRAPPER: tokenDataByNetwork.Mainnet.waDAI,
    AAVE_V2_USDC_TOKEN_WRAPPER: tokenDataByNetwork.Mainnet.waUSDC,
    AAVE_V2_USDT_TOKEN_WRAPPER: tokenDataByNetwork.Mainnet.waUSDT,
    AAVE_V2_WETH_TOKEN_WRAPPER: tokenDataByNetwork.Mainnet.waWETH,

    COMPOUND_V2_DAI_POOL: tokenDataByNetwork.Mainnet.cDAI,
    COMPOUND_V2_USDC_POOL: tokenDataByNetwork.Mainnet.cUSDC,
    COMPOUND_V2_USDT_POOL: tokenDataByNetwork.Mainnet.cUSDT,
    COMPOUND_V2_LINK_POOL: tokenDataByNetwork.Mainnet.cLINK,
    COMPOUND_V2_ETH_GATEWAY: NOT_DEPLOYED,

    FLUX_USDC_POOL: tokenDataByNetwork.Mainnet.fUSDC,
  },

  //
  //
  //
  //
  //  A R B I T R U M
  //
  //
  //
  //
  Arbitrum: {
    UNISWAP_V2_ROUTER: NOT_DEPLOYED,
    UNISWAP_V3_ROUTER: NOT_DEPLOYED,
    SUSHISWAP_ROUTER: NOT_DEPLOYED,
    FRAXSWAP_ROUTER: NOT_DEPLOYED,
    VELODROME_V2_ROUTER: NOT_DEPLOYED,

    // CURVE
    CURVE_3CRV_POOL: NOT_DEPLOYED,
    CURVE_FRAX_USDC_POOL: NOT_DEPLOYED,
    CURVE_STETH_GATEWAY: NOT_DEPLOYED,
    CURVE_FRAX_POOL: tokenDataByNetwork.Arbitrum.FRAX3CRV,
    CURVE_LUSD_POOL: tokenDataByNetwork.Arbitrum.LUSD3CRV,
    CURVE_SUSD_POOL: NOT_DEPLOYED,
    CURVE_SUSD_DEPOSIT: NOT_DEPLOYED,
    CURVE_GUSD_POOL: NOT_DEPLOYED,
    CURVE_MIM_POOL: tokenDataByNetwork.Arbitrum.MIM_3LP3CRV,
    CURVE_OHMFRAXBP_POOL: NOT_DEPLOYED,
    CURVE_CRVETH_POOL: NOT_DEPLOYED,
    CURVE_CVXETH_POOL: NOT_DEPLOYED,
    CURVE_3CRYPTO_POOL: NOT_DEPLOYED,
    CURVE_LDOETH_POOL: NOT_DEPLOYED,
    CURVE_ETH_WSTETH_GATEWAY: NOT_DEPLOYED,

    CURVE_GEAR_POOL: NOT_DEPLOYED,

    CURVE_CRVUSD_USDC_POOL: tokenDataByNetwork.Mainnet.crvUSDUSDC,
    CURVE_CRVUSD_USDT_POOL: tokenDataByNetwork.Mainnet.crvUSDUSDT,
    CURVE_CRVUSD_FRAX_POOL: tokenDataByNetwork.Mainnet.crvUSDFRAX,
    CURVE_TRI_CRV_POOL: tokenDataByNetwork.Mainnet.crvUSDETHCRV,

    CURVE_RETH_ETH_POOL: NOT_DEPLOYED,

    // YEARN
    YEARN_DAI_VAULT: tokenDataByNetwork.Arbitrum.yvDAI,
    YEARN_USDC_VAULT: tokenDataByNetwork.Arbitrum.yvUSDC,
    YEARN_WETH_VAULT: tokenDataByNetwork.Arbitrum.yvWETH,
    YEARN_WBTC_VAULT: tokenDataByNetwork.Arbitrum.yvWBTC,
    YEARN_USDT_VAULT: tokenDataByNetwork.Arbitrum.yvUSDT,
    YEARN_OP_VAULT: tokenDataByNetwork.Arbitrum.yvOP,
    YEARN_CURVE_FRAX_VAULT: tokenDataByNetwork.Arbitrum.yvCurve_FRAX,
    YEARN_CURVE_STETH_VAULT: tokenDataByNetwork.Arbitrum.yvCurve_stETH,

    /// ERC4626
    MAKER_DSR_VAULT: tokenDataByNetwork.Arbitrum.sDAI,
    YIELD_ETH_VAULT: tokenDataByNetwork.Arbitrum.YieldETH,

    // CONVEX
    CONVEX_BOOSTER: NOT_DEPLOYED,
    CONVEX_3CRV_POOL: NOT_DEPLOYED,
    CONVEX_FRAX_USDC_POOL: NOT_DEPLOYED,
    CONVEX_STECRV_POOL: NOT_DEPLOYED,
    CONVEX_SUSD_POOL: NOT_DEPLOYED,
    CONVEX_FRAX3CRV_POOL: NOT_DEPLOYED,
    CONVEX_LUSD3CRV_POOL: NOT_DEPLOYED,
    CONVEX_GUSD_POOL: NOT_DEPLOYED,
    CONVEX_OHMFRAXBP_POOL: NOT_DEPLOYED,
    CONVEX_MIM3CRV_POOL: NOT_DEPLOYED,
    CONVEX_CRVETH_POOL: NOT_DEPLOYED,
    CONVEX_CVXETH_POOL: NOT_DEPLOYED,
    CONVEX_3CRYPTO_POOL: NOT_DEPLOYED,
    CONVEX_LDOETH_POOL: NOT_DEPLOYED,
    CONVEX_CRVUSD_USDC_POOL: NOT_DEPLOYED,
    CONVEX_CRVUSD_USDT_POOL: NOT_DEPLOYED,
    CONVEX_CRVUSD_FRAX_POOL: NOT_DEPLOYED,
    CONVEX_TRI_CRV_POOL: NOT_DEPLOYED,

    AURA_BOOSTER: NOT_DEPLOYED,
    AURA_B_RETH_STABLE_POOL:
      tokenDataByNetwork.Arbitrum.auraB_rETH_STABLE_vault,
    AURA_BPT_RETH_ETH_POOL: tokenDataByNetwork.Arbitrum.auraBPT_rETH_ETH_vault,
    AURA_BPT_WSTETH_ETH_POOL:
      tokenDataByNetwork.Arbitrum.auraBPT_WSTETH_ETH_vault,

    // LIDO
    LIDO_STETH_GATEWAY: NOT_DEPLOYED,
    LIDO_WSTETH: tokenDataByNetwork.Arbitrum.wstETH,

    // BALANCER
    BALANCER_VAULT: NOT_DEPLOYED,

    // GEARBOX
    UNIVERSAL_ADAPTER: "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC",

    // AAVE
    AAVE_V2_LENDING_POOL: NOT_DEPLOYED,

    AAVE_V2_DAI_TOKEN_WRAPPER: tokenDataByNetwork.Arbitrum.waDAI,
    AAVE_V2_USDC_TOKEN_WRAPPER: tokenDataByNetwork.Arbitrum.waUSDC,
    AAVE_V2_USDT_TOKEN_WRAPPER: tokenDataByNetwork.Arbitrum.waUSDT,
    AAVE_V2_WETH_TOKEN_WRAPPER: tokenDataByNetwork.Arbitrum.waWETH,

    COMPOUND_V2_DAI_POOL: tokenDataByNetwork.Arbitrum.cDAI,
    COMPOUND_V2_USDC_POOL: tokenDataByNetwork.Arbitrum.cUSDC,
    COMPOUND_V2_USDT_POOL: tokenDataByNetwork.Arbitrum.cUSDT,
    COMPOUND_V2_LINK_POOL: tokenDataByNetwork.Arbitrum.cLINK,
    COMPOUND_V2_ETH_GATEWAY: NOT_DEPLOYED,

    FLUX_USDC_POOL: tokenDataByNetwork.Arbitrum.fUSDC,
  },
  //
  //
  //
  //
  //  OPTIMISM
  //
  //
  //
  //
  Optimism: {
    UNISWAP_V2_ROUTER: NOT_DEPLOYED,
    UNISWAP_V3_ROUTER: "0xE592427A0AEce92De3Edee1F18E0157C05861564",
    SUSHISWAP_ROUTER: NOT_DEPLOYED,
    FRAXSWAP_ROUTER: "0xB9A55F455e46e8D717eEA5E47D2c449416A0437F", // UNVERIFIED!,
    VELODROME_V2_ROUTER: "0xa062aE8A9c5e11aaA026fc2670B0D65cCc8B2858",

    // CURVE
    CURVE_3CRV_POOL: "0x1337BedC9D22ecbe766dF105c9623922A27963EC",
    CURVE_FRAX_USDC_POOL: NOT_DEPLOYED,
    CURVE_STETH_GATEWAY: NOT_DEPLOYED,
    CURVE_FRAX_POOL: tokenDataByNetwork.Arbitrum.FRAX3CRV,
    CURVE_LUSD_POOL: tokenDataByNetwork.Arbitrum.LUSD3CRV,
    CURVE_SUSD_POOL: NOT_DEPLOYED,
    CURVE_SUSD_DEPOSIT: NOT_DEPLOYED,
    CURVE_GUSD_POOL: NOT_DEPLOYED,
    CURVE_MIM_POOL: tokenDataByNetwork.Arbitrum.MIM_3LP3CRV,
    CURVE_OHMFRAXBP_POOL: NOT_DEPLOYED,
    CURVE_CRVETH_POOL: NOT_DEPLOYED,
    CURVE_CVXETH_POOL: NOT_DEPLOYED,
    CURVE_3CRYPTO_POOL: NOT_DEPLOYED,
    CURVE_LDOETH_POOL: NOT_DEPLOYED,
    CURVE_ETH_WSTETH_GATEWAY: NOT_DEPLOYED,

    CURVE_GEAR_POOL: NOT_DEPLOYED,

    CURVE_CRVUSD_USDC_POOL: tokenDataByNetwork.Optimism.crvUSDUSDC,
    CURVE_CRVUSD_USDT_POOL: tokenDataByNetwork.Optimism.crvUSDUSDT,
    CURVE_CRVUSD_FRAX_POOL: tokenDataByNetwork.Optimism.crvUSDFRAX,
    CURVE_TRI_CRV_POOL: tokenDataByNetwork.Optimism.crvUSDETHCRV,

    CURVE_RETH_ETH_POOL: NOT_DEPLOYED,

    // YEARN
    YEARN_DAI_VAULT: tokenDataByNetwork.Optimism.yvDAI,
    YEARN_USDC_VAULT: tokenDataByNetwork.Optimism.yvUSDC,
    YEARN_WETH_VAULT: tokenDataByNetwork.Optimism.yvWETH,
    YEARN_WBTC_VAULT: tokenDataByNetwork.Optimism.yvWBTC,
    YEARN_USDT_VAULT: tokenDataByNetwork.Optimism.yvUSDT,
    YEARN_OP_VAULT: tokenDataByNetwork.Optimism.yvOP,
    YEARN_CURVE_FRAX_VAULT: tokenDataByNetwork.Optimism.yvCurve_FRAX,
    YEARN_CURVE_STETH_VAULT: tokenDataByNetwork.Optimism.yvCurve_stETH,

    /// ERC4626
    MAKER_DSR_VAULT: tokenDataByNetwork.Optimism.sDAI,
    YIELD_ETH_VAULT: tokenDataByNetwork.Optimism.YieldETH,

    // CONVEX
    CONVEX_BOOSTER: NOT_DEPLOYED,
    CONVEX_3CRV_POOL: NOT_DEPLOYED,
    CONVEX_FRAX_USDC_POOL: NOT_DEPLOYED,
    CONVEX_STECRV_POOL: NOT_DEPLOYED,
    CONVEX_SUSD_POOL: NOT_DEPLOYED,
    CONVEX_FRAX3CRV_POOL: NOT_DEPLOYED,
    CONVEX_LUSD3CRV_POOL: NOT_DEPLOYED,
    CONVEX_GUSD_POOL: NOT_DEPLOYED,
    CONVEX_OHMFRAXBP_POOL: NOT_DEPLOYED,
    CONVEX_MIM3CRV_POOL: NOT_DEPLOYED,
    CONVEX_CRVETH_POOL: NOT_DEPLOYED,
    CONVEX_CVXETH_POOL: NOT_DEPLOYED,
    CONVEX_3CRYPTO_POOL: NOT_DEPLOYED,
    CONVEX_LDOETH_POOL: NOT_DEPLOYED,
    CONVEX_CRVUSD_USDC_POOL: NOT_DEPLOYED,
    CONVEX_CRVUSD_USDT_POOL: NOT_DEPLOYED,
    CONVEX_CRVUSD_FRAX_POOL: NOT_DEPLOYED,
    CONVEX_TRI_CRV_POOL: NOT_DEPLOYED,

    // AURA
    AURA_BOOSTER: "0x98Ef32edd24e2c92525E59afc4475C1242a30184",
    AURA_B_RETH_STABLE_POOL:
      tokenDataByNetwork.Optimism.auraB_rETH_STABLE_vault,
    AURA_BPT_RETH_ETH_POOL: tokenDataByNetwork.Optimism.auraBPT_rETH_ETH_vault,
    AURA_BPT_WSTETH_ETH_POOL:
      tokenDataByNetwork.Optimism.auraBPT_WSTETH_ETH_vault,

    // LIDO
    LIDO_STETH_GATEWAY: NOT_DEPLOYED,
    LIDO_WSTETH: NOT_DEPLOYED,

    // BALANCER
    BALANCER_VAULT: "0xBA12222222228d8Ba445958a75a0704d566BF2C8",

    // GEARBOX
    UNIVERSAL_ADAPTER: "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC",

    // AAVE
    AAVE_V2_LENDING_POOL: NOT_DEPLOYED,

    AAVE_V2_DAI_TOKEN_WRAPPER: tokenDataByNetwork.Arbitrum.waDAI,
    AAVE_V2_USDC_TOKEN_WRAPPER: tokenDataByNetwork.Arbitrum.waUSDC,
    AAVE_V2_USDT_TOKEN_WRAPPER: tokenDataByNetwork.Arbitrum.waUSDT,
    AAVE_V2_WETH_TOKEN_WRAPPER: tokenDataByNetwork.Arbitrum.waWETH,

    COMPOUND_V2_DAI_POOL: tokenDataByNetwork.Arbitrum.cDAI,
    COMPOUND_V2_USDC_POOL: tokenDataByNetwork.Arbitrum.cUSDC,
    COMPOUND_V2_USDT_POOL: tokenDataByNetwork.Arbitrum.cUSDT,
    COMPOUND_V2_LINK_POOL: tokenDataByNetwork.Arbitrum.cLINK,
    COMPOUND_V2_ETH_GATEWAY: NOT_DEPLOYED,

    FLUX_USDC_POOL: tokenDataByNetwork.Arbitrum.fUSDC,
  },
};

export const UNISWAP_V3_QUOTER = NOT_DEPLOYED;

export interface BaseContractParams {
  name: string;
}

type UniswapV2Params = {
  protocol: Protocols.Uniswap | Protocols.Sushiswap | Protocols.Fraxswap;
  type: AdapterInterface.UNISWAP_V2_ROUTER;
} & BaseContractParams;

type VelodromeV2Params = {
  protocol: Protocols.Velodrome;
  type: AdapterInterface.VELODROME_V2_ROUTER;
} & BaseContractParams;

type UniswapV3Params = {
  protocol: Protocols.Uniswap;
  type: AdapterInterface.UNISWAP_V3_ROUTER;
  quoter: string;
} & BaseContractParams;

export type CurveParams = {
  protocol: Protocols.Curve;
  type:
    | AdapterInterface.CURVE_V1_2ASSETS
    | AdapterInterface.CURVE_V1_3ASSETS
    | AdapterInterface.CURVE_V1_4ASSETS
    | AdapterInterface.CURVE_V1_WRAPPER;
  version: number;
  lpToken: CurveLPToken;
  tokens: Array<NormalToken | CurveLPToken>;
  underlyings?: Array<NormalToken>;
  wrapper?: CurvePoolContract;
} & BaseContractParams;

export type CurveSteCRVPoolParams = {
  protocol: Protocols.Curve;
  type: AdapterInterface.CURVE_V1_STECRV_POOL;
  version: number;

  pool: Record<NetworkType, string>;
  tokens: ["WETH", "STETH"] | ["WETH", "wstETH"];
  lpToken: "steCRV" | "wstETHCRV";
} & BaseContractParams;

export type CurveGEARPoolParams = {
  protocol: Protocols.Curve;
  type: AdapterInterface.CURVE_V1_2ASSETS;
  version: number;

  pool: Record<NetworkType, string>;
  tokens: ["GEAR", "WETH"];
  lpToken: "GEAR";
} & BaseContractParams;

export type YearnParams = {
  protocol: Protocols.Yearn;
  type: AdapterInterface.YEARN_V2;
  shareToken: YearnLPToken;
} & BaseContractParams;

export type ERC4626Params = {
  protocol: Protocols.MakerDSR | Protocols.Sommelier;
  type: AdapterInterface.ERC4626_VAULT;
  underlying: NormalToken;
} & BaseContractParams;

type ConvexParams = {
  protocol: Protocols.Convex;
  type: AdapterInterface.CONVEX_V1_BOOSTER;
} & BaseContractParams;

interface ConvexExtraPoolParams {
  rewardToken: NormalToken;
  poolAddress: Record<NetworkType, string>;
}

export type ConvexPoolParams = {
  protocol: Protocols.Convex;
  type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL;
  stakedToken: ConvexStakedPhantomToken;
  extraRewards: Array<ConvexExtraPoolParams>;
} & BaseContractParams;

// AURA

export type AuraPoolParams = {
  protocol: Protocols.Aura;
  type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL;
  stakedToken: AuraStakedToken;
  extraRewards: Array<AuraExtraPoolParams>;
} & BaseContractParams;

type AuraParams = {
  protocol: Protocols.Aura;
  type: AdapterInterface.CONVEX_V1_BOOSTER;
} & BaseContractParams;

interface AuraExtraPoolParams {
  rewardToken: NormalToken;
  poolAddress: Record<NetworkType, string>;
}

export type LidoParams = {
  protocol: Protocols.Lido;
  type: AdapterInterface.LIDO_V1;
  oracle: Record<NetworkType, string>;
  lpToken: "steCRV";
} & BaseContractParams;

export type LidoWsthETHParams = {
  protocol: Protocols.Lido;
  type: AdapterInterface.LIDO_WSTETH_V1;
} & BaseContractParams;

export type UniversalParams = {
  protocol: Protocols.Gearbox;
  type: AdapterInterface.UNIVERSAL;
} & BaseContractParams;

export type BalancerParams = {
  protocol: Protocols.Balancer;
  type: AdapterInterface.BALANCER_VAULT;
  queries: Record<NetworkType, string>;
} & BaseContractParams;

export type AaveV2Params = {
  protocol: Protocols.AaveV2;
  type: AdapterInterface.AAVE_V2_LENDING_POOL;
} & BaseContractParams;

export type WrapperAaveV2Params = {
  protocol: Protocols.AaveV2;
  type: AdapterInterface.AAVE_V2_WRAPPED_ATOKEN;
  underlying: AaveV2LPToken;
} & BaseContractParams;

export type CompoundV2Params = {
  protocol: Protocols.CompoundV2 | Protocols.Flux;
  type:
    | AdapterInterface.COMPOUND_V2_CERC20
    | AdapterInterface.COMPOUND_V2_CETHER;
  underlying: NormalToken;
} & BaseContractParams;

export type ContractParams =
  | UniswapV2Params
  | UniswapV3Params
  | VelodromeV2Params
  | CurveParams
  | CurveSteCRVPoolParams
  | CurveGEARPoolParams
  | YearnParams
  | ConvexParams
  | ConvexPoolParams
  | LidoParams
  | LidoWsthETHParams
  | UniversalParams
  | BalancerParams
  | AaveV2Params
  | WrapperAaveV2Params
  | CompoundV2Params
  | AuraParams
  | AuraPoolParams
  | ERC4626Params;

export const contractParams: Record<SupportedContract, ContractParams> = {
  UNISWAP_V2_ROUTER: {
    name: "Uniswap V2",
    protocol: Protocols.Uniswap,
    type: AdapterInterface.UNISWAP_V2_ROUTER,
  },
  UNISWAP_V3_ROUTER: {
    name: "Uniswap V3",
    protocol: Protocols.Uniswap,
    quoter: UNISWAP_V3_QUOTER,
    type: AdapterInterface.UNISWAP_V3_ROUTER,
  },

  SUSHISWAP_ROUTER: {
    name: "Sushiswap",
    protocol: Protocols.Sushiswap,
    type: AdapterInterface.UNISWAP_V2_ROUTER,
  },

  FRAXSWAP_ROUTER: {
    name: "Fraxswap",
    protocol: Protocols.Fraxswap,
    type: AdapterInterface.UNISWAP_V2_ROUTER,
  },

  VELODROME_V2_ROUTER: {
    name: "Velodrome V2",
    protocol: Protocols.Velodrome,
    type: AdapterInterface.VELODROME_V2_ROUTER,
  },
  CURVE_3CRV_POOL: {
    name: "Curve 3Pool",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_3ASSETS,
    version: 10,
    lpToken: "3Crv",
    tokens: ["DAI", "USDC", "USDT"],
  },
  CURVE_FRAX_USDC_POOL: {
    name: "Curve crvFRAX",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    version: 10,
    lpToken: "crvFRAX",
    tokens: ["FRAX", "USDC"],
  },
  CURVE_STETH_GATEWAY: {
    name: "Curve stETH",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_STECRV_POOL,
    version: 10,
    pool: {
      Mainnet: "0xDC24316b9AE028F1497c275EB9192a3Ea0f67022",
      Arbitrum: NOT_DEPLOYED, // CURVE_STECRV_POOL
      Optimism: NOT_DEPLOYED,
    },
    tokens: ["WETH", "STETH"],
    lpToken: "steCRV",
  },
  CURVE_ETH_WSTETH_GATEWAY: {
    name: "Curve wstETH Gateway",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_STECRV_POOL,
    version: 10,
    pool: {
      Mainnet: NOT_DEPLOYED,
      Arbitrum: NOT_DEPLOYED,
      Optimism: "0xb90b9b1f91a01ea22a182cd84c1e22222e39b415",
    },
    tokens: ["WETH", "STETH"],
    lpToken: "wstETHCRV",
  },
  CURVE_GEAR_POOL: {
    name: "Curve GEAR",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    version: 10,
    pool: {
      Mainnet: "0x0E9B5B092caD6F1c5E6bc7f89Ffe1abb5c95F1C2",
      Arbitrum: NOT_DEPLOYED,
      Optimism: NOT_DEPLOYED,
    },
    tokens: ["GEAR", "WETH"],
    lpToken: "GEAR",
  },
  CURVE_FRAX_POOL: {
    name: "Curve FRAX",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    version: 10,
    lpToken: "FRAX3CRV",
    tokens: ["FRAX", "3Crv"],
    underlyings: ["FRAX", "DAI", "USDC", "USDT"],
  },
  CURVE_LUSD_POOL: {
    name: "Curve LUSD",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    version: 10,
    lpToken: "LUSD3CRV",
    tokens: ["LUSD", "3Crv"],
    underlyings: ["LUSD", "DAI", "USDC", "USDT"],
  },
  CURVE_SUSD_POOL: {
    name: "Curve SUSD",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_4ASSETS,
    version: 10,
    lpToken: "crvPlain3andSUSD",
    tokens: ["DAI", "USDC", "USDT", "sUSD"],
    wrapper: "CURVE_SUSD_DEPOSIT",
  },
  CURVE_SUSD_DEPOSIT: {
    name: "Curve SUSD",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_WRAPPER,
    version: 10,
    lpToken: "crvPlain3andSUSD",
    tokens: ["DAI", "USDC", "USDT", "sUSD"],
  },
  CURVE_GUSD_POOL: {
    name: "Curve GUSD",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    version: 10,
    lpToken: "gusd3CRV",
    tokens: ["GUSD", "3Crv"],
    underlyings: ["GUSD", "DAI", "USDC", "USDT"],
  },
  CURVE_MIM_POOL: {
    name: "Curve MIM",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    version: 10,
    lpToken: "MIM_3LP3CRV",
    tokens: ["MIM", "3Crv"],
    underlyings: ["MIM", "DAI", "USDC", "USDT"],
  },

  CURVE_OHMFRAXBP_POOL: {
    name: "Curve OHM_FRAXBP",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    version: 20,
    lpToken: "OHMFRAXBP",
    tokens: ["OHM", "crvFRAX"],
    underlyings: ["OHM", "FRAX", "USDC"],
  },
  CURVE_CRVETH_POOL: {
    name: "Curve CRVETH",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    version: 20,
    lpToken: "crvCRVETH",
    tokens: ["WETH", "CRV"],
  },
  CURVE_CVXETH_POOL: {
    name: "Curve CVXETH",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    version: 20,
    lpToken: "crvCVXETH",
    tokens: ["WETH", "CVX"],
  },
  CURVE_3CRYPTO_POOL: {
    name: "Curve 3Crypto",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_3ASSETS,
    version: 20,
    lpToken: "crvUSDTWBTCWETH",
    tokens: ["USDT", "WBTC", "WETH"],
  },
  CURVE_LDOETH_POOL: {
    name: "Curve LDOETH",
    protocol: Protocols.Curve,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    version: 20,
    lpToken: "LDOETH",
    tokens: ["WETH", "LDO"],
  },

  CURVE_CRVUSD_USDC_POOL: {
    name: "Curve crvUSDUSDC",
    protocol: Protocols.Curve,
    version: 20,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    lpToken: "crvUSDUSDC",
    tokens: ["crvUSD", "USDC"],
  },

  CURVE_CRVUSD_USDT_POOL: {
    name: "Curve crvUSDUSDC",
    protocol: Protocols.Curve,
    version: 20,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    lpToken: "crvUSDUSDT",
    tokens: ["crvUSD", "USDT"],
  },

  CURVE_CRVUSD_FRAX_POOL: {
    name: "Curve crvUSDUSDC",
    protocol: Protocols.Curve,
    version: 20,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    lpToken: "crvUSDFRAX",
    tokens: ["crvUSD", "FRAX"],
  },

  CURVE_TRI_CRV_POOL: {
    name: "Curve crvUSDUSDC",
    protocol: Protocols.Curve,
    version: 20,
    type: AdapterInterface.CURVE_V1_3ASSETS,
    lpToken: "crvUSDETHCRV",
    tokens: ["crvUSD", "WETH", "CRV"],
  },

  CURVE_RETH_ETH_POOL: {
    name: "Curve rETH",
    protocol: Protocols.Curve,
    version: 20,
    type: AdapterInterface.CURVE_V1_2ASSETS,
    lpToken: "rETH_f",
    tokens: ["WETH", "rETH"],
  },

  YEARN_DAI_VAULT: {
    name: "Yearn DAI",
    protocol: Protocols.Yearn,
    type: AdapterInterface.YEARN_V2,
    shareToken: "yvDAI",
  },
  YEARN_USDC_VAULT: {
    name: "Yearn USDC",
    protocol: Protocols.Yearn,
    type: AdapterInterface.YEARN_V2,
    shareToken: "yvUSDC",
  },
  YEARN_WETH_VAULT: {
    name: "Yearn WETH",
    protocol: Protocols.Yearn,
    type: AdapterInterface.YEARN_V2,
    shareToken: "yvWETH",
  },
  YEARN_WBTC_VAULT: {
    name: "Yearn WBTC",
    protocol: Protocols.Yearn,
    type: AdapterInterface.YEARN_V2,
    shareToken: "yvWBTC",
  },
  YEARN_USDT_VAULT: {
    name: "Yearn USDT",
    protocol: Protocols.Yearn,
    type: AdapterInterface.YEARN_V2,
    shareToken: "yvUSDT",
  },
  YEARN_OP_VAULT: {
    name: "Yearn OP",
    protocol: Protocols.Yearn,
    type: AdapterInterface.YEARN_V2,
    shareToken: "yvOP",
  },
  YEARN_CURVE_FRAX_VAULT: {
    name: "Yearn Curve FRAX",
    protocol: Protocols.Yearn,
    type: AdapterInterface.YEARN_V2,
    shareToken: "yvCurve_FRAX",
  },
  YEARN_CURVE_STETH_VAULT: {
    name: "Yearn Curve STETH",
    protocol: Protocols.Yearn,
    type: AdapterInterface.YEARN_V2,
    shareToken: "yvCurve_stETH",
  },
  MAKER_DSR_VAULT: {
    name: "Maker DSR ERC4626 Vault",
    protocol: Protocols.MakerDSR,
    type: AdapterInterface.ERC4626_VAULT,
    underlying: "DAI",
  },
  YIELD_ETH_VAULT: {
    name: "Sommelier YieldETH",
    protocol: Protocols.Sommelier,
    type: AdapterInterface.ERC4626_VAULT,
    underlying: "WETH",
  },
  CONVEX_BOOSTER: {
    name: "Convex BOOSTER",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BOOSTER,
  },

  CONVEX_3CRV_POOL: {
    name: "Convex 3crv",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvx3Crv",
    extraRewards: [],
  },
  CONVEX_FRAX_USDC_POOL: {
    name: "Convex FRAXUSDC",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxcrvFRAX",
    extraRewards: [],
  },
  CONVEX_GUSD_POOL: {
    name: "Convex GUSD",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxgusd3CRV",
    extraRewards: [],
  },
  CONVEX_SUSD_POOL: {
    name: "Convex SUSD",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxcrvPlain3andSUSD",
    extraRewards: [
      {
        rewardToken: "SNX",
        poolAddress: {
          Mainnet: "0x81fCe3E10D12Da6c7266a1A169c4C96813435263",
          Arbitrum: NOT_DEPLOYED, // CONVEX_SUSD_POOL_EXTRA_SNX
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },
  CONVEX_STECRV_POOL: {
    name: "Convex STECRV",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxsteCRV",
    extraRewards: [
      {
        rewardToken: "LDO",
        poolAddress: {
          Mainnet: "0x008aEa5036b819B4FEAEd10b2190FBb3954981E8",
          Arbitrum: NOT_DEPLOYED, // CONVEX_STECRV_POOL_EXTRA_LDO
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },
  CONVEX_FRAX3CRV_POOL: {
    name: "Convex FRAX3CRV",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxFRAX3CRV",
    extraRewards: [
      {
        rewardToken: "FXS",
        poolAddress: {
          Mainnet: "0xcDEC6714eB482f28f4889A0c122868450CDBF0b0",
          Arbitrum: NOT_DEPLOYED, // CONVEX_FRAX3CRV_POOL_EXTRA_FXS
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },
  CONVEX_LUSD3CRV_POOL: {
    name: "Convex LUSD3CRV",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxLUSD3CRV",
    extraRewards: [
      {
        rewardToken: "LQTY",
        poolAddress: {
          Mainnet: "0x55d59b791f06dc519B176791c4E037E8Cf2f6361",
          Arbitrum: NOT_DEPLOYED, // CONVEX_LUSD3CRV_POOL_EXTRA_LQTY
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },
  CONVEX_MIM3CRV_POOL: {
    name: "Convex MIM3CRV",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxMIM_3LP3CRV",
    extraRewards: [
      {
        rewardToken: "SPELL",
        poolAddress: {
          Mainnet: "0x69a92f1656cd2e193797546cFe2EaF32EACcf6f7",
          Arbitrum: NOT_DEPLOYED,
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },

  CONVEX_OHMFRAXBP_POOL: {
    name: "Convex OHMFRAXBP",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxOHMFRAXBP",
    extraRewards: [],
  },
  CONVEX_CRVETH_POOL: {
    name: "Convex crvCRVETH",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxcrvCRVETH",
    extraRewards: [
      {
        rewardToken: "CVX",
        poolAddress: {
          Mainnet: "0xE1eCBB4181378E2346EAC90Eb5606c01Aa08f052",
          Arbitrum: NOT_DEPLOYED,
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },
  CONVEX_CVXETH_POOL: {
    name: "Convex crvCVXETH",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxcrvCVXETH",
    extraRewards: [
      {
        rewardToken: "CVX",
        poolAddress: {
          Mainnet: "0x834B9147Fd23bF131644aBC6e557Daf99C5cDa15",
          Arbitrum: NOT_DEPLOYED,
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },
  CONVEX_3CRYPTO_POOL: {
    name: "Convex 3Crypto",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxcrvUSDTWBTCWETH",
    extraRewards: [],
  },
  CONVEX_LDOETH_POOL: {
    name: "Convex LDOETH",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxLDOETH",
    extraRewards: [
      {
        rewardToken: "LDO",
        poolAddress: {
          Mainnet: "0x95e6092449a0f3946A5a0f308Ead4adcff244E2B",
          Arbitrum: NOT_DEPLOYED,
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },
  CONVEX_CRVUSD_USDC_POOL: {
    name: "Convex crvUSDUSDC",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxcrvUSDUSDC",
    extraRewards: [
      {
        rewardToken: "CVX",
        poolAddress: {
          Mainnet: "0xac183F7cd62d5b04Fa40362EB67249A80339541A",
          Arbitrum: NOT_DEPLOYED,
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },
  CONVEX_CRVUSD_USDT_POOL: {
    name: "Convex crvUSDUSDT",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxcrvUSDUSDT",
    extraRewards: [
      {
        rewardToken: "CVX",
        poolAddress: {
          Mainnet: "0xD490178B568b07c6DDbDfBBfaF9043772209Ec01",
          Arbitrum: NOT_DEPLOYED,
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },
  CONVEX_CRVUSD_FRAX_POOL: {
    name: "Convex crvUSDFRAX",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxcrvUSDFRAX",
    extraRewards: [
      {
        rewardToken: "CVX",
        poolAddress: {
          Mainnet: "0x749cFfCb53e008841d7387ba37f9284BDeCEe0A9",
          Arbitrum: NOT_DEPLOYED,
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },
  CONVEX_TRI_CRV_POOL: {
    name: "Convex TRICRV",
    protocol: Protocols.Convex,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "stkcvxcrvUSDETHCRV",
    extraRewards: [
      {
        rewardToken: "CVX",
        poolAddress: {
          Mainnet: "0x01eC96F1eEBF470E3fEAEEfB843fbC63424e668d",
          Arbitrum: NOT_DEPLOYED,
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },

  AURA_BOOSTER: {
    name: "Aura BOOSTER",
    protocol: Protocols.Aura,
    type: AdapterInterface.CONVEX_V1_BOOSTER,
  },

  AURA_B_RETH_STABLE_POOL: {
    name: "Balancer rETH Stable Pool Aura Deposit",
    protocol: Protocols.Aura,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "auraB_rETH_STABLE_vault",
    extraRewards: [
      {
        rewardToken: "AURA",
        poolAddress: {
          Mainnet: "0xf66a72886749c96b18526E8E124cC2e18b7c72D2",
          Arbitrum: NOT_DEPLOYED,
          Optimism: NOT_DEPLOYED,
        },
      },
    ],
  },

  AURA_BPT_RETH_ETH_POOL: {
    name: "BeethovenX rETH-ETH Pool Aura Deposit",
    protocol: Protocols.Aura,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "auraBPT_rETH_ETH_vault",
    extraRewards: [
      {
        rewardToken: "OP",
        poolAddress: {
          Mainnet: NOT_DEPLOYED,
          Arbitrum: NOT_DEPLOYED,
          Optimism: "0x0A22Ae9D9D149C14f6c15A235e715bB6C1Cfa739",
        },
      },
      {
        rewardToken: "AURA",
        poolAddress: {
          Mainnet: NOT_DEPLOYED,
          Arbitrum: NOT_DEPLOYED,
          Optimism: "0x81673Cdd00c2839440f31575cCFa5B6ca4a87B2B",
        },
      },
    ],
  },

  AURA_BPT_WSTETH_ETH_POOL: {
    name: "BeethovenX wstETH-ETH Pool Aura Deposit",
    protocol: Protocols.Aura,
    type: AdapterInterface.CONVEX_V1_BASE_REWARD_POOL,
    stakedToken: "auraBPT_WSTETH_ETH_vault",
    extraRewards: [
      {
        rewardToken: "OP",
        poolAddress: {
          Mainnet: NOT_DEPLOYED,
          Arbitrum: NOT_DEPLOYED,
          Optimism: "0x903d716fe68e7e091eCC43AA93c0F8cfD7e7BC0a",
        },
      },
      {
        rewardToken: "AURA",
        poolAddress: {
          Mainnet: NOT_DEPLOYED,
          Arbitrum: NOT_DEPLOYED,
          Optimism: "0xb0709c230C06BE6e2A84b2Ba877094EB9a4fA014",
        },
      },
    ],
  },

  LIDO_STETH_GATEWAY: {
    name: "Lido STETH",
    protocol: Protocols.Lido,
    type: AdapterInterface.LIDO_V1,
    oracle: {
      Mainnet: "0x442af784A788A5bd6F42A01Ebe9F287a871243fb",
      Arbitrum: NOT_DEPLOYED, // LIDO_ORACLE
      Optimism: NOT_DEPLOYED,
    },
    lpToken: "steCRV",
  },

  LIDO_WSTETH: {
    name: "Lido wstETH",
    protocol: Protocols.Lido,
    type: AdapterInterface.LIDO_WSTETH_V1,
  },

  UNIVERSAL_ADAPTER: {
    name: "Gearbox universal adapter",
    protocol: Protocols.Gearbox,
    type: AdapterInterface.UNIVERSAL,
  },

  BALANCER_VAULT: {
    name: "Balancer Vault",
    protocol: Protocols.Balancer,
    type: AdapterInterface.BALANCER_VAULT,
    queries: {
      Mainnet: "0xE39B5e3B6D74016b2F6A9673D7d7493B6DF549d5",
      Arbitrum: "0xE39B5e3B6D74016b2F6A9673D7d7493B6DF549d5",
      Optimism: "0xE39B5e3B6D74016b2F6A9673D7d7493B6DF549d5",
    },
  },
  AAVE_V2_LENDING_POOL: {
    name: "Aave V2 Lending Pool",
    protocol: Protocols.AaveV2,
    type: AdapterInterface.AAVE_V2_LENDING_POOL,
  },
  AAVE_V2_DAI_TOKEN_WRAPPER: {
    name: "Aave V2 DAI Token Wrapper",
    protocol: Protocols.AaveV2,
    type: AdapterInterface.AAVE_V2_WRAPPED_ATOKEN,
    underlying: "aDAI",
  },
  AAVE_V2_USDC_TOKEN_WRAPPER: {
    name: "Aave V2 USDC Token Wrapper",
    protocol: Protocols.AaveV2,
    type: AdapterInterface.AAVE_V2_WRAPPED_ATOKEN,
    underlying: "aUSDC",
  },
  AAVE_V2_USDT_TOKEN_WRAPPER: {
    name: "Aave V2 USDT Token Wrapper",
    protocol: Protocols.AaveV2,
    type: AdapterInterface.AAVE_V2_WRAPPED_ATOKEN,
    underlying: "aUSDT",
  },
  AAVE_V2_WETH_TOKEN_WRAPPER: {
    name: "Aave V2 WETH Token Wrapper",
    protocol: Protocols.AaveV2,
    type: AdapterInterface.AAVE_V2_WRAPPED_ATOKEN,
    underlying: "aWETH",
  },

  COMPOUND_V2_DAI_POOL: {
    name: "Compound V2 DAI",
    protocol: Protocols.CompoundV2,
    type: AdapterInterface.COMPOUND_V2_CERC20,
    underlying: "DAI",
  },
  COMPOUND_V2_USDC_POOL: {
    name: "Compound V2 DAI",
    protocol: Protocols.CompoundV2,
    type: AdapterInterface.COMPOUND_V2_CERC20,
    underlying: "USDT",
  },
  COMPOUND_V2_USDT_POOL: {
    name: "Compound V2 DAI",
    protocol: Protocols.CompoundV2,
    type: AdapterInterface.COMPOUND_V2_CERC20,
    underlying: "USDT",
  },
  COMPOUND_V2_LINK_POOL: {
    name: "Compound V2 LINK",
    protocol: Protocols.CompoundV2,
    type: AdapterInterface.COMPOUND_V2_CERC20,
    underlying: "LINK",
  },
  COMPOUND_V2_ETH_GATEWAY: {
    name: "Compound V2 ETH",
    protocol: Protocols.CompoundV2,
    type: AdapterInterface.COMPOUND_V2_CETHER,
    underlying: "WETH",
  },
  FLUX_USDC_POOL: {
    name: "Flux USDC",
    protocol: Protocols.Flux,
    type: AdapterInterface.COMPOUND_V2_CERC20,
    underlying: "USDC",
  },
};

export const contractsByAddress = TypedObjectUtils.entries(
  contractsByNetwork,
).reduce<Record<string, SupportedContract>>(
  (acc, [, contracts]) => ({
    ...acc,
    ...TypedObjectUtils.fromEntries(
      TypedObjectUtils.entries(contracts)
        .map(([k, v]) => [v.toLowerCase(), k])
        .filter(k => !!k) as Array<[string, SupportedContract]>,
    ),
  }),
  {},
);

export const isSupportedContract = (t: unknown): t is SupportedContract =>
  typeof t === "string" && !!contractParams[t as SupportedContract];
