// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

import "./Tokens.sol";
import {Contracts} from "./SupportedContracts.sol";
import {AdapterType} from "./AdapterType.sol";

struct SimpleAdapter {
    Contracts targetContract;
    AdapterType adapterType;
}

struct CurveAdapter {
    Contracts targetContract;
    AdapterType adapterType;
    uint256 lpToken;
    Contracts basePool;
}

struct CurveStETHAdapter {
    Contracts curveETHGateway;
    AdapterType adapterType;
    uint256 lpToken;
}

struct CurveWrapper {
    Contracts targetContract;
    AdapterType adapterType;
    uint256 lpToken;
    uint256 nCoins;
}

struct ConvexBasePoolAdapter {
    Contracts targetContract;
    AdapterType adapterType;
    uint256 stakedToken;
}

struct StakingRewardsAdapter {
    Contracts targetContract;
    AdapterType adapterType;
    uint256 stakedToken;
}

contract AdapterData {
    SimpleAdapter[] simpleAdapters;
    CurveAdapter[] curveAdapters;
    CurveStETHAdapter[] curveStEthAdapters;
    CurveWrapper[] curveWrappers;
    ConvexBasePoolAdapter[] convexBasePoolAdapters;
    StakingRewardsAdapter[] stakingRewardsAdapters;

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
            SimpleAdapter({targetContract: Contracts.STAKED_USDS_VAULT, adapterType: AdapterType.ERC4626_VAULT})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.SAVINGS_CRVUSD_VAULT, adapterType: AdapterType.ERC4626_VAULT})
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
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.MELLOW_RE7_LABS_VAULT, adapterType: AdapterType.MELLOW_LRT_VAULT})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.MELLOW_AMPHOR_VAULT, adapterType: AdapterType.MELLOW_LRT_VAULT})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.MELLOW_RESTAKING_VAULT, adapterType: AdapterType.MELLOW_LRT_VAULT})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.MELLOW_RENZO_VAULT, adapterType: AdapterType.MELLOW_LRT_VAULT})
        );
        simpleAdapters.push(
            SimpleAdapter({targetContract: Contracts.DAI_USDS, adapterType: AdapterType.DAI_USDS_EXCHANGE})
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_3CRV_POOL,
                adapterType: AdapterType.CURVE_V1_3ASSETS,
                lpToken: TOKEN__3Crv,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_FRAX_USDC_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_crvFRAX,
                basePool: Contracts.NO_CONTRACT
            })
        );

        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_FRAX_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_FRAX3CRV,
                basePool: Contracts.CURVE_3CRV_POOL
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_LUSD_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_LUSD3CRV,
                basePool: Contracts.CURVE_3CRV_POOL
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_SUSD_POOL,
                adapterType: AdapterType.CURVE_V1_4ASSETS,
                lpToken: TOKEN_crvPlain3andSUSD,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_GUSD_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_gusd3CRV,
                basePool: Contracts.CURVE_3CRV_POOL
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVETH_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_crvCRVETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CVXETH_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_crvCVXETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_3CRYPTO_POOL,
                adapterType: AdapterType.CURVE_V1_3ASSETS,
                lpToken: TOKEN_crvUSDTWBTCWETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_LDOETH_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_LDOETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_USDC_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_crvUSDUSDC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_USDT_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_crvUSDUSDT,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_SUSDE_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_crvUsUSDe,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_LLAMA_THENA_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_scrvUsUSDe,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_FRAX_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_crvUSDFRAX,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_TRI_CRV_POOL,
                adapterType: AdapterType.CURVE_V1_3ASSETS,
                lpToken: TOKEN_crvUSDETHCRV,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_RETH_ETH_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_rETH_f,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_DOLA_FRAXBP_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_DOLAFRAXBP3CRV_f,
                basePool: Contracts.CURVE_FRAX_USDC_POOL
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_DOLA_CRVUSD_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_crvUSDDOLA_f,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_USDE_USDC_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_USDeUSDC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_FRAX_USDE_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_FRAXUSDe,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_USDE_CRVUSD_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_USDecrvUSD,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_USDE_DAI_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_USDeDAI,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_SDAI_SUSDE_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_MtEthena,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_GHO_USDE_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_GHOUSDe,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_FRAX_SDAI_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_FRAXsDAI,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_DOLA_SUSDE_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_DOLAsUSDe,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_PUFETH_WSTETH_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_pufETHwstE,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_GHO_CRVUSD_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_GHOcrvUSD,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_EZETH_ETH_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_ezETHWETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_EZPZ_ETH_POOL,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN_ezpzETH,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_LBTC_WBTC_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_LBTCWBTC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_EBTC_WBTC_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_eBTCWBTC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_TRIBTC_POOL,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_TriBTC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_2CRV_POOL_ARB,
                adapterType: AdapterType.CURVE_V1_2ASSETS,
                lpToken: TOKEN__2CRV,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                adapterType: AdapterType.CURVE_V1_3ASSETS,
                lpToken: TOKEN__3c_crvUSD,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_crvUSDC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_crvUSDC_e,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_crvUSDT,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_USDE_USDC_POOL_ARB,
                adapterType: AdapterType.CURVE_STABLE_NG,
                lpToken: TOKEN_USDEUSDC,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveAdapters.push(
            CurveAdapter({
                targetContract: Contracts.CURVE_3CRV_POOL_OP,
                adapterType: AdapterType.CURVE_V1_3ASSETS,
                lpToken: TOKEN__3CRV,
                basePool: Contracts.NO_CONTRACT
            })
        );
        curveStEthAdapters.push(
            CurveStETHAdapter({
                curveETHGateway: Contracts.CURVE_STETH_GATEWAY,
                adapterType: AdapterType.CURVE_V1_STECRV_POOL,
                lpToken: TOKEN_steCRV
            })
        );
        curveStEthAdapters.push(
            CurveStETHAdapter({
                curveETHGateway: Contracts.CURVE_ETH_WSTETH_GATEWAY_OP,
                adapterType: AdapterType.CURVE_V1_STECRV_POOL,
                lpToken: TOKEN_wstETHCRV
            })
        );
        curveWrappers.push(
            CurveWrapper({
                targetContract: Contracts.CURVE_SUSD_DEPOSIT,
                adapterType: AdapterType.CURVE_V1_WRAPPER,
                lpToken: TOKEN_crvPlain3andSUSD,
                nCoins: 4
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_3CRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvx3Crv
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_FRAX_USDC_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxcrvFRAX
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_GUSD_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxgusd3CRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_SUSD_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxcrvPlain3andSUSD
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_STECRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxsteCRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_FRAX3CRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxFRAX3CRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_LUSD3CRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxLUSD3CRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_CRVETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxcrvCRVETH
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_CVXETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxcrvCVXETH
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_3CRYPTO_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxcrvUSDTWBTCWETH
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_LDOETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxLDOETH
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_CRVUSD_USDC_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxcrvUSDUSDC
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_CRVUSD_USDT_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxcrvUSDUSDT
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_CRVUSD_FRAX_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxcrvUSDFRAX
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_TRI_CRV_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxcrvUSDETHCRV
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.CONVEX_GHO_CRVUSD_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_stkcvxGHOcrvUSD
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_B_RETH_STABLE_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_auraB_rETH_STABLE_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_WEETH_RETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_auraweETH_rETH_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_OSETH_WETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_auraosETH_wETH_BPT_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_BPT_RETH_ETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_auraBPT_rETH_ETH_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_BPT_WSTETH_ETH_POOL,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_auraBPT_WSTETH_ETH_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_WSTETH_WETH_POOL_ARB,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_aurawstETH_WETH_BPT_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_WSTETH_RETH_SFRXETH_POOL_ARB,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_aurawstETH_rETH_sfrxETH_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_CBETH_RETH_WSTETH_POOL_ARB,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_auracbETH_rETH_wstETH_vault
            })
        );
        convexBasePoolAdapters.push(
            ConvexBasePoolAdapter({
                targetContract: Contracts.AURA_RETH_WETH_POOL_ARB,
                adapterType: AdapterType.CONVEX_V1_BASE_REWARD_POOL,
                stakedToken: TOKEN_aurarETH_wETH_BPT_vault
            })
        );
        stakingRewardsAdapters.push(
            StakingRewardsAdapter({
                targetContract: Contracts.SKY_STAKING_REWARDS,
                adapterType: AdapterType.STAKING_REWARDS,
                stakedToken: TOKEN_stkUSDS
            })
        );
    }
}
