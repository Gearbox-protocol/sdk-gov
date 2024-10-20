// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

/// @dev c-Tokens and LUNA are added for unit test purposes
enum Tokens {
    NO_TOKEN,
    LUNA,
    _1INCH,
    AAVE,
    COMP,
    CRV,
    DAI,
    DPI,
    FEI,
    LINK,
    SNX,
    UNI,
    USDC,
    USDC_e,
    USDT,
    WBTC,
    WETH,
    YFI,
    WLD,
    OP,
    STETH,
    CVX,
    FRAX,
    FXS,
    LDO,
    LUSD,
    sUSD,
    GUSD,
    LQTY,
    OHM,
    MIM,
    SPELL,
    GMX,
    ARB,
    RDNT,
    BAL,
    SHIB,
    crvUSD,
    MKR,
    RPL,
    APE,
    LBTC,
    rETH,
    AURA,
    osETH,
    weETH,
    SWISE,
    ezETH,
    rsETH,
    frxETH,
    PENDLE,
    cbETH,
    rswETH,
    USDe,
    GHO,
    pufETH,
    wstETH,
    steakLRT,
    Re7LRT,
    amphrETH,
    rstETH,
    pzETH,
    PT_rsETH_26SEP2024,
    PT_sUSDe_26DEC2024,
    PT_eETH_26DEC2024,
    PT_ezETH_26DEC2024,
    sfrxETH,
    _3Crv,
    crvFRAX,
    steCRV,
    crvPlain3andSUSD,
    crvCRVETH,
    crvCVXETH,
    crvUSDTWBTCWETH,
    LDOETH,
    crvUSDUSDC,
    crvUSDUSDT,
    crvUSDFRAX,
    crvUSDETHCRV,
    rETH_f,
    USDeUSDC,
    FRAXUSDe,
    USDecrvUSD,
    USDeDAI,
    MtEthena,
    GHOUSDe,
    pufETHwstE,
    GHOcrvUSD,
    wstETHCRV,
    _2CRV,
    _3c_crvUSD,
    crvUSDC,
    crvUSDT,
    crvUSDC_e,
    USDEUSDC,
    _3CRV,
    ezETHWETH,
    ezpzETH,
    LBTCWBTC,
    FRAX3CRV,
    LUSD3CRV,
    gusd3CRV,
    MIM_3LP3CRV,
    OHMFRAXBP,
    cvx3Crv,
    cvxcrvFRAX,
    cvxsteCRV,
    cvxFRAX3CRV,
    cvxLUSD3CRV,
    cvxcrvPlain3andSUSD,
    cvxgusd3CRV,
    cvxOHMFRAXBP,
    cvxMIM_3LP3CRV,
    cvxcrvCRVETH,
    cvxcrvCVXETH,
    cvxcrvUSDTWBTCWETH,
    cvxLDOETH,
    cvxcrvUSDUSDC,
    cvxcrvUSDUSDT,
    cvxcrvUSDFRAX,
    cvxcrvUSDETHCRV,
    cvxGHOcrvUSD,
    stkcvx3Crv,
    stkcvxcrvFRAX,
    stkcvxsteCRV,
    stkcvxFRAX3CRV,
    stkcvxLUSD3CRV,
    stkcvxcrvPlain3andSUSD,
    stkcvxgusd3CRV,
    stkcvxOHMFRAXBP,
    stkcvxMIM_3LP3CRV,
    stkcvxcrvCRVETH,
    stkcvxcrvCVXETH,
    stkcvxcrvUSDTWBTCWETH,
    stkcvxLDOETH,
    stkcvxcrvUSDUSDC,
    stkcvxcrvUSDUSDT,
    stkcvxcrvUSDFRAX,
    stkcvxcrvUSDETHCRV,
    stkcvxGHOcrvUSD,
    cvxcrvUSDT,
    yvDAI,
    yvUSDC,
    yvUSDC_e,
    yvWETH,
    yvWBTC,
    yvUSDT,
    yvOP,
    yvCurve_stETH,
    yvCurve_FRAX,
    _50WETH_50AURA,
    B_80BAL_20WETH,
    _50OHM_50DAI,
    _50OHM_50WETH,
    OHM_wstETH,
    USDC_DAI_USDT,
    B_rETH_STABLE,
    weETH_rETH,
    osETH_wETH_BPT,
    ezETH_WETH_BPT,
    trenSTETH,
    weETH_ezETH_rswETH,
    GHO_USDT_USDC,
    rsETH_WETH,
    rsETH_wETH_Arb,
    BPT_rETH_ETH,
    BPT_WSTETH_ETH,
    BPT_ROAD,
    ECLP_wstETH_WETH,
    wstETH_WETH_BPT,
    wstETH_rETH_sfrxETH,
    wstETH_rETH_cbETH,
    cbETH_rETH_wstETH,
    rETH_WETH_BPT_deprecated,
    rETH_wETH_BPT,
    _33AURA_33ARB_33BAL,
    ezETH_wstETH,
    bpt_ethtri,
    aDAI,
    aUSDC,
    aUSDT,
    aWETH,
    waDAI,
    waUSDC,
    waUSDT,
    waWETH,
    cDAI,
    cUSDC,
    cUSDT,
    cETH,
    cLINK,
    fUSDC,
    sDAI,
    YieldETH,
    sUSDe,
    auraB_rETH_STABLE,
    auraosETH_wETH_BPT,
    auraweETH_rETH,
    auraBPT_rETH_ETH,
    auraBPT_WSTETH_ETH,
    aurawstETH_WETH_BPT,
    aurawstETH_rETH_sfrxETH,
    auracbETH_rETH_wstETH,
    aurarETH_wETH_BPT,
    auraB_rETH_STABLE_vault,
    auraosETH_wETH_BPT_vault,
    auraweETH_rETH_vault,
    auraBPT_rETH_ETH_vault,
    auraBPT_WSTETH_ETH_vault,
    aurawstETH_WETH_BPT_vault,
    aurawstETH_rETH_sfrxETH_vault,
    auracbETH_rETH_wstETH_vault,
    aurarETH_wETH_BPT_vault,
    zpufETH,
    dDAI,
    dUSDC,
    dWBTC,
    dWETH,
    dwstETH,
    dFRAX,
    dUSDCV3,
    dUSDC_eV3,
    dWBTCV3,
    dWETHV3,
    dUSDTV3,
    dGHOV3,
    dDAIV3,
    dcrvUSDV3,
    sdUSDCV3,
    sdUSDC_eV3,
    sdWBTCV3,
    sdWETHV3,
    sdWETHV3_OLD,
    sdUSDTV3,
    sdGHOV3,
    sdDAIV3,
    sdcrvUSDV3,
    GEAR
}

enum TokenType {
    NO_TOKEN,
    NORMAL_TOKEN,
    CURVE_LP_TOKEN,
    YEARN_ON_NORMAL_TOKEN,
    YEARN_ON_CURVE_TOKEN,
    CONVEX_LP_TOKEN,
    CONVEX_STAKED_TOKEN,
    DIESEL_LP_TOKEN,
    GEAR_TOKEN,
    COMPOUND_V2_C_TOKEN,
    BALANCER_LP_TOKEN,
    AAVE_V2_A_TOKEN,
    WRAPPED_AAVE_V2_TOKEN,
    ERC4626_VAULT_TOKEN,
    WRAPPED_TOKEN,
    AURA_LP_TOKEN,
    AURA_STAKED_TOKEN,
    CONVEX_L2_STAKED_TOKEN,
    ZIRCUIT_STAKED_TOKEN,
    STAKING_REWARDS_PHANTOM_TOKEN
}

enum PhantomTokenType {
    NO_TOKEN,
    CONVEX_PHANTOM_TOKEN,
    ZIRCUIT_PHANTOM_TOKEN,
    STAKING_REWARDS_PHANTOM_TOKEN
}
