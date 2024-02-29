// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

enum Contracts {
    NO_CONTRACT,
    UNISWAP_V2_ROUTER,
    UNISWAP_V3_ROUTER,
    SUSHISWAP_ROUTER,
    FRAXSWAP_ROUTER,
    VELODROME_V2_ROUTER,
    CAMELOT_V3_ROUTER,
    CURVE_3CRV_POOL,
    CURVE_FRAX_USDC_POOL,
    CURVE_STETH_GATEWAY,
    CURVE_FRAX_POOL,
    CURVE_LUSD_POOL,
    CURVE_SUSD_POOL,
    CURVE_SUSD_DEPOSIT,
    CURVE_GUSD_POOL,
    CURVE_MIM_POOL,
    CURVE_OHMFRAXBP_POOL,
    CURVE_CRVETH_POOL,
    CURVE_CVXETH_POOL,
    CURVE_3CRYPTO_POOL,
    CURVE_LDOETH_POOL,
    CURVE_ETH_WSTETH_GATEWAY_OP,
    CURVE_USDE_USDC_POOL,
    CURVE_GEAR_POOL,
    CURVE_CRVUSD_USDC_POOL,
    CURVE_CRVUSD_USDT_POOL,
    CURVE_CRVUSD_FRAX_POOL,
    CURVE_TRI_CRV_POOL,
    CURVE_RETH_ETH_POOL,
    CURVE_3CRV_POOL_OP,
    CURVE_2CRV_POOL_ARB,
    CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
    CURVE_CRVUSD_USDC_POOL_ARB,
    CURVE_CRVUSD_USDT_POOL_ARB,
    CURVE_CRVUSD_USDC_E_POOL_ARB,
    YEARN_DAI_VAULT,
    YEARN_USDC_VAULT,
    YEARN_WETH_VAULT,
    YEARN_WBTC_VAULT,
    YEARN_USDT_VAULT,
    YEARN_OP_VAULT,
    YEARN_CURVE_FRAX_VAULT,
    YEARN_CURVE_STETH_VAULT,
    MAKER_DSR_VAULT,
    YIELD_ETH_VAULT,
    CONVEX_BOOSTER,
    CONVEX_3CRV_POOL,
    CONVEX_FRAX_USDC_POOL,
    CONVEX_GUSD_POOL,
    CONVEX_SUSD_POOL,
    CONVEX_STECRV_POOL,
    CONVEX_FRAX3CRV_POOL,
    CONVEX_LUSD3CRV_POOL,
    CONVEX_OHMFRAXBP_POOL,
    CONVEX_MIM3CRV_POOL,
    CONVEX_CRVETH_POOL,
    CONVEX_CVXETH_POOL,
    CONVEX_3CRYPTO_POOL,
    CONVEX_LDOETH_POOL,
    CONVEX_CRVUSD_USDC_POOL,
    CONVEX_CRVUSD_USDT_POOL,
    CONVEX_CRVUSD_FRAX_POOL,
    CONVEX_TRI_CRV_POOL,
    AURA_BOOSTER,
    AURA_WEETH_RETH_POOL,
    AURA_OSETH_WETH_POOL,
    AURA_B_RETH_STABLE_POOL,
    AURA_BPT_RETH_ETH_POOL,
    AURA_BPT_WSTETH_ETH_POOL,
    AURA_RETH_WETH_POOL_ARB,
    AURA_WSTETH_WETH_POOL_ARB,
    AURA_WSTETH_RETH_CBETH_POOL_ARB,
    AURA_WSTETH_RETH_SFRXETH_POOL_ARB,
    LIDO_STETH_GATEWAY,
    LIDO_WSTETH,
    BALANCER_VAULT,
    UNIVERSAL_ADAPTER,
    AAVE_V2_LENDING_POOL,
    AAVE_V2_DAI_TOKEN_WRAPPER,
    AAVE_V2_USDC_TOKEN_WRAPPER,
    AAVE_V2_USDT_TOKEN_WRAPPER,
    AAVE_V2_WETH_TOKEN_WRAPPER,
    COMPOUND_V2_DAI_POOL,
    COMPOUND_V2_USDC_POOL,
    COMPOUND_V2_USDT_POOL,
    COMPOUND_V2_LINK_POOL,
    COMPOUND_V2_ETH_GATEWAY,
    FLUX_USDC_POOL
}
