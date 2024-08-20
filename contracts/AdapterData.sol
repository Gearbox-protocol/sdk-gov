// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

import {Tokens} from "./Tokens.sol";
import {Contracts} from "./SupportedContracts.sol";
import {AdapterType} from "./AdapterType.sol";

struct SimpleAdapter {
    Contracts targetContract;
    AdapterType adapterType;
}

struct CurveAdapter {
    Contracts targetContract;
    AdapterType adapterType;
    Tokens lpToken;
    Contracts basePool;
}

struct CurveStETHAdapter {
    Contracts curveETHGateway;
    AdapterType adapterType;
    Tokens lpToken;
}

struct CurveWrapper {
    Contracts targetContract;
    AdapterType adapterType;
    Tokens lpToken;
    uint256 nCoins;
}

struct ConvexBasePoolAdapter {
    Contracts targetContract;
    AdapterType adapterType;
    Tokens stakedToken;
}

contract AdapterData {
    SimpleAdapter[] simpleAdapters;
    CurveAdapter[] curveAdapters;
    CurveStETHAdapter[] curveStEthAdapters;
    CurveWrapper[] curveWrappers;
    ConvexBasePoolAdapter[] convexBasePoolAdapters;

    constructor() {
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.UNISWAP_V2_ROUTER, adapterType: AdapterType.UNISWAP_V2_ROUTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.UNISWAP_V3_ROUTER, adapterType: AdapterType.UNISWAP_V3_ROUTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.PANCAKESWAP_V3_ROUTER, adapterType: AdapterType.UNISWAP_V3_ROUTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.SUSHISWAP_ROUTER, adapterType: AdapterType.UNISWAP_V2_ROUTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.FRAXSWAP_ROUTER, adapterType: AdapterType.UNISWAP_V2_ROUTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.VELODROME_V2_ROUTER, adapterType: AdapterType.VELODROME_V2_ROUTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.VELODROME_CL_ROUTER, adapterType: AdapterType.UNISWAP_V3_ROUTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.CAMELOT_V3_ROUTER, adapterType: AdapterType.CAMELOT_V3_ROUTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.PENDLE_ROUTER, adapterType: AdapterType.PENDLE_ROUTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.YEARN_DAI_VAULT, adapterType: AdapterType.YEARN_V2})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.YEARN_USDC_VAULT, adapterType: AdapterType.YEARN_V2})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.YEARN_USDC_E_VAULT, adapterType: AdapterType.YEARN_V2})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.YEARN_WETH_VAULT, adapterType: AdapterType.YEARN_V2})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.YEARN_WBTC_VAULT, adapterType: AdapterType.YEARN_V2})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.YEARN_USDT_VAULT, adapterType: AdapterType.YEARN_V2})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.YEARN_OP_VAULT, adapterType: AdapterType.YEARN_V2})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.YEARN_CURVE_FRAX_VAULT, adapterType: AdapterType.YEARN_V2})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.YEARN_CURVE_STETH_VAULT, adapterType: AdapterType.YEARN_V2})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.MAKER_DSR_VAULT, adapterType: AdapterType.ERC4626_VAULT})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.YIELD_ETH_VAULT, adapterType: AdapterType.ERC4626_VAULT})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.STAKED_USDE_VAULT, adapterType: AdapterType.ERC4626_VAULT})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.CONVEX_BOOSTER, adapterType: AdapterType.CONVEX_V1_BOOSTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.CONVEX_BOOSTER_ARB, adapterType: AdapterType.CONVEX_L2_BOOSTER})
        );
        simpleAdapters.push(
            SimpleAdapter({
                targetContract: Contracts.CONVEX_CRVUSD_USDT_POOL_ARB,
                adapterType: AdapterType.CONVEX_L2_REWARD_POOL
            })
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.AURA_BOOSTER, adapterType: AdapterType.CONVEX_V1_BOOSTER})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.LIDO_STETH_GATEWAY, adapterType: AdapterType.LIDO_V1})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.LIDO_WSTETH, adapterType: AdapterType.LIDO_WSTETH_V1})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.UNIVERSAL_ADAPTER, adapterType: AdapterType.UNIVERSAL})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.BALANCER_VAULT, adapterType: AdapterType.BALANCER_VAULT})
        );
        simpleAdapters.push(
            SimpleAdapter({
                targetContract: Contracts.AAVE_V2_LENDING_POOL,
                adapterType: AdapterType.AAVE_V2_LENDING_POOL
            })
        );
        simpleAdapters.push(
            SimpleAdapter({
                targetContract: Contracts.AAVE_V2_DAI_TOKEN_WRAPPER,
                adapterType: AdapterType.AAVE_V2_WRAPPED_ATOKEN
            })
        );
        simpleAdapters.push(
            SimpleAdapter({
                targetContract: Contracts.AAVE_V2_USDC_TOKEN_WRAPPER,
                adapterType: AdapterType.AAVE_V2_WRAPPED_ATOKEN
            })
        );
        simpleAdapters.push(
            SimpleAdapter({
                targetContract: Contracts.AAVE_V2_USDT_TOKEN_WRAPPER,
                adapterType: AdapterType.AAVE_V2_WRAPPED_ATOKEN
            })
        );
        simpleAdapters.push(
            SimpleAdapter({
                targetContract: Contracts.AAVE_V2_WETH_TOKEN_WRAPPER,
                adapterType: AdapterType.AAVE_V2_WRAPPED_ATOKEN
            })
        );
        simpleAdapters.push(
            SimpleAdapter({
                targetContract: Contracts.AAVE_V3_LENDING_POOL,
                adapterType: AdapterType.AAVE_V3_LENDING_POOL
            })
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.COMPOUND_V2_DAI_POOL, adapterType: AdapterType.COMPOUND_V2_CERC20})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.COMPOUND_V2_USDC_POOL, adapterType: AdapterType.COMPOUND_V2_CERC20})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.COMPOUND_V2_USDT_POOL, adapterType: AdapterType.COMPOUND_V2_CERC20})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.COMPOUND_V2_LINK_POOL, adapterType: AdapterType.COMPOUND_V2_CERC20})
        );
        simpleAdapters.push(
            SimpleAdapter({
                targetContract: Contracts.COMPOUND_V2_ETH_GATEWAY,
                adapterType: AdapterType.COMPOUND_V2_CETHER
            })
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.FLUX_USDC_POOL, adapterType: AdapterType.COMPOUND_V2_CERC20})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.ZIRCUIT_POOL, adapterType: AdapterType.ZIRCUIT_POOL})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.MELLOW_STEAKHOUSE_VAULT, adapterType: AdapterType.MELLOW_LRT_VAULT})
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_3CRV_POOL,
                adapterType: AdapterType.CURVE_V1_3ASSETS,
                lpToken: Tokens._3Crv,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_FRAX_USDC_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.crvFRAX,
                basePool: Contracts.NO_CONTRACT
            })
        );

        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_FRAX_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.FRAX3CRV,
                basePool: Contracts.CURVE_3CRV_POOL
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_LUSD_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.LUSD3CRV,
                basePool: Contracts.CURVE_3CRV_POOL
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_SUSD_POOL,
                adapterType: AdapterType.CURVE_V1_4ASSETS,
                lpToken: Tokens.crvPlain3andSUSD,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_GUSD_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.gusd3CRV,
                basePool: Contracts.CURVE_3CRV_POOL
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_MIM_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.MIM_3LP3CRV,
                basePool: Contracts.CURVE_3CRV_POOL
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_OHMFRAXBP_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.OHMFRAXBP,
                basePool: Contracts.CURVE_FRAX_USDC_POOL
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVETH_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.crvCRVETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CVXETH_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.crvCVXETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_3CRYPTO_POOL,
                adapterType: AdapterType.CURVE_V1_3ASSETS,
                lpToken: Tokens.crvUSDTWBTCWETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_LDOETH_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.LDOETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_USDC_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.crvUSDUSDC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_USDT_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.crvUSDUSDT,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_FRAX_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.crvUSDFRAX,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_TRI_CRV_POOL,
                adapterType: AdapterType.CURVE_V1_3ASSETS,
                lpToken: Tokens.crvUSDETHCRV,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_RETH_ETH_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.rETH_f,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_USDE_USDC_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.USDeUSDC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_FRAX_USDE_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.FRAXUSDe,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_USDE_CRVUSD_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.USDecrvUSD,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_USDE_DAI_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.USDeDAI,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_SDAI_SUSDE_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.MtEthena,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_GHO_USDE_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.GHOUSDe,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_PUFETH_WSTETH_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: Tokens.pufETHwstE,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_GHO_CRVUSD_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: Tokens.GHOcrvUSD,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_EZETH_ETH_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: Tokens.ezETHWETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_EZPZ_ETH_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens.ezpzETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_LBTC_WBTC_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: Tokens.LBTCWBTC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_2CRV_POOL_ARB,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: Tokens._2CRV,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                adapterType: AdapterType.CURVE_V1_3ASSETS,
                lpToken: Tokens._3c_crvUSD,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: Tokens.crvUSDC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: Tokens.crvUSDC_e,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: Tokens.crvUSDT,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_USDE_USDC_POOL_ARB,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: Tokens.USDEUSDC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_3CRV_POOL_OP,
                adapterType: AdapterType.CURVE_V1_3ASSETS,
                lpToken: Tokens._3CRV,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveStEthAdapters.push(
            CurveStETHAdapter({
                curveETHGateway: Contracts.CURVE_STETH_GATEWAY,
                adapterType: AdapterType.CURVE_V1_STECRV_POOL,
                lpToken: Tokens.steCRV
            })
        );
        curveStEthAdapters.push(
            CurveStETHAdapter({
                curveETHGateway: Contracts.CURVE_ETH_WSTETH_GATEWAY_OP,
                adapterType: AdapterType.CURVE_V1_STECRV_POOL,
                lpToken: Tokens.wstETHCRV
            })
        );
        curveWrappers.push(
            CurveWrapper({
                targetContract: Contracts.CURVE_SUSD_DEPOSIT,
                adapterType: AdapterType.CURVE_V1_WRAPPER,
                lpToken: Tokens.crvPlain3andSUSD,
                nCoins: 4
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_3CRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvx3Crv
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_FRAX_USDC_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxcrvFRAX
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_GUSD_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxgusd3CRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_SUSD_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxcrvPlain3andSUSD
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_STECRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxsteCRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_FRAX3CRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxFRAX3CRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_LUSD3CRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxLUSD3CRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_MIM3CRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxMIM_3LP3CRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_OHMFRAXBP_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxOHMFRAXBP
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_CRVETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxcrvCRVETH
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_CVXETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxcrvCVXETH
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_3CRYPTO_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxcrvUSDTWBTCWETH
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_LDOETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxLDOETH
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_CRVUSD_USDC_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxcrvUSDUSDC
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_CRVUSD_USDT_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxcrvUSDUSDT
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_CRVUSD_FRAX_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxcrvUSDFRAX
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_TRI_CRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxcrvUSDETHCRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_GHO_CRVUSD_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.stkcvxGHOcrvUSD
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_B_RETH_STABLE_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.auraB_rETH_STABLE_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_WEETH_RETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.auraweETH_rETH_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_OSETH_WETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.auraosETH_wETH_BPT_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_BPT_RETH_ETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.auraBPT_rETH_ETH_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_BPT_WSTETH_ETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.auraBPT_WSTETH_ETH_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_WSTETH_WETH_POOL_ARB,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.aurawstETH_WETH_BPT_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_WSTETH_RETH_SFRXETH_POOL_ARB,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.aurawstETH_rETH_sfrxETH_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_CBETH_RETH_WSTETH_POOL_ARB,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.auracbETH_rETH_wstETH_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_RETH_WETH_POOL_ARB,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: Tokens.aurarETH_wETH_BPT_vault
            })
        );
    }
}
