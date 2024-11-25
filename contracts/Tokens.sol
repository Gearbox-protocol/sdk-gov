// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

/// @dev c-Tokens and LUNA are added for unit test purposes
uint256 constant TOKEN_NO_TOKEN = 0;
uint256 constant TOKEN_LUNA = 1;
uint256 constant TOKEN__1INCH = 2;
uint256 constant TOKEN_AAVE = 3;
uint256 constant TOKEN_COMP = 4;
uint256 constant TOKEN_CRV = 5;
uint256 constant TOKEN_DAI = 6;
uint256 constant TOKEN_DPI = 7;
uint256 constant TOKEN_FEI = 8;
uint256 constant TOKEN_LINK = 9;
uint256 constant TOKEN_SNX = 10;
uint256 constant TOKEN_UNI = 11;
uint256 constant TOKEN_USDC = 12;
uint256 constant TOKEN_USDC_e = 13;
uint256 constant TOKEN_USDT = 14;
uint256 constant TOKEN_WBTC = 15;
uint256 constant TOKEN_WETH = 16;
uint256 constant TOKEN_YFI = 17;
uint256 constant TOKEN_WLD = 18;
uint256 constant TOKEN_OP = 19;
uint256 constant TOKEN_STETH = 20;
uint256 constant TOKEN_CVX = 21;
uint256 constant TOKEN_FRAX = 22;
uint256 constant TOKEN_FXS = 23;
uint256 constant TOKEN_LDO = 24;
uint256 constant TOKEN_LUSD = 25;
uint256 constant TOKEN_sUSD = 26;
uint256 constant TOKEN_GUSD = 27;
uint256 constant TOKEN_LQTY = 28;
uint256 constant TOKEN_OHM = 29;
uint256 constant TOKEN_MIM = 30;
uint256 constant TOKEN_SPELL = 31;
uint256 constant TOKEN_GMX = 32;
uint256 constant TOKEN_ARB = 33;
uint256 constant TOKEN_RDNT = 34;
uint256 constant TOKEN_BAL = 35;
uint256 constant TOKEN_SHIB = 36;
uint256 constant TOKEN_crvUSD = 37;
uint256 constant TOKEN_MKR = 38;
uint256 constant TOKEN_RPL = 39;
uint256 constant TOKEN_APE = 40;
uint256 constant TOKEN_LBTC = 41;
uint256 constant TOKEN_eBTC = 42;
uint256 constant TOKEN_rETH = 43;
uint256 constant TOKEN_AURA = 44;
uint256 constant TOKEN_osETH = 45;
uint256 constant TOKEN_weETH = 46;
uint256 constant TOKEN_SWISE = 47;
uint256 constant TOKEN_ezETH = 48;
uint256 constant TOKEN_rsETH = 49;
uint256 constant TOKEN_frxETH = 50;
uint256 constant TOKEN_PENDLE = 51;
uint256 constant TOKEN_cbETH = 52;
uint256 constant TOKEN_rswETH = 53;
uint256 constant TOKEN_USDe = 54;
uint256 constant TOKEN_GHO = 55;
uint256 constant TOKEN_pufETH = 56;
uint256 constant TOKEN_wstETH = 57;
uint256 constant TOKEN_steakLRT = 58;
uint256 constant TOKEN_Re7LRT = 59;
uint256 constant TOKEN_amphrETH = 60;
uint256 constant TOKEN_rstETH = 61;
uint256 constant TOKEN_pzETH = 62;
uint256 constant TOKEN_PT_rsETH_26SEP2024 = 63;
uint256 constant TOKEN_USDS = 64;
uint256 constant TOKEN_SKY = 65;
uint256 constant TOKEN_PT_sUSDe_26DEC2024 = 66;
uint256 constant TOKEN_PT_eETH_26DEC2024 = 67;
uint256 constant TOKEN_PT_ezETH_26DEC2024 = 68;
uint256 constant TOKEN_PT_eBTC_26DEC2024 = 69;
uint256 constant TOKEN_PT_LBTC_27MAR2025 = 70;
uint256 constant TOKEN_sfrxETH = 71;
uint256 constant TOKEN__3Crv = 72;
uint256 constant TOKEN_crvFRAX = 73;
uint256 constant TOKEN_steCRV = 74;
uint256 constant TOKEN_crvPlain3andSUSD = 75;
uint256 constant TOKEN_crvCRVETH = 76;
uint256 constant TOKEN_crvCVXETH = 77;
uint256 constant TOKEN_crvUSDTWBTCWETH = 78;
uint256 constant TOKEN_LDOETH = 79;
uint256 constant TOKEN_crvUSDUSDC = 80;
uint256 constant TOKEN_crvUSDUSDT = 81;
uint256 constant TOKEN_crvUSDFRAX = 82;
uint256 constant TOKEN_crvUSDETHCRV = 83;
uint256 constant TOKEN_rETH_f = 84;
uint256 constant TOKEN_USDeUSDC = 85;
uint256 constant TOKEN_FRAXUSDe = 86;
uint256 constant TOKEN_USDecrvUSD = 87;
uint256 constant TOKEN_USDeDAI = 88;
uint256 constant TOKEN_MtEthena = 89;
uint256 constant TOKEN_GHOUSDe = 90;
uint256 constant TOKEN_pufETHwstE = 91;
uint256 constant TOKEN_GHOcrvUSD = 92;
uint256 constant TOKEN_wstETHCRV = 93;
uint256 constant TOKEN__2CRV = 94;
uint256 constant TOKEN__3c_crvUSD = 95;
uint256 constant TOKEN_crvUSDC = 96;
uint256 constant TOKEN_crvUSDT = 97;
uint256 constant TOKEN_crvUSDC_e = 98;
uint256 constant TOKEN_USDEUSDC = 99;
uint256 constant TOKEN__3CRV = 100;
uint256 constant TOKEN_ezETHWETH = 101;
uint256 constant TOKEN_ezpzETH = 102;
uint256 constant TOKEN_LBTCWBTC = 103;
uint256 constant TOKEN_eBTCWBTC = 104;
uint256 constant TOKEN_TriBTC = 105;
uint256 constant TOKEN_FRAX3CRV = 106;
uint256 constant TOKEN_LUSD3CRV = 107;
uint256 constant TOKEN_gusd3CRV = 108;
uint256 constant TOKEN_MIM_3LP3CRV = 109;
uint256 constant TOKEN_OHMFRAXBP = 110;
uint256 constant TOKEN_cvx3Crv = 111;
uint256 constant TOKEN_cvxcrvFRAX = 112;
uint256 constant TOKEN_cvxsteCRV = 113;
uint256 constant TOKEN_cvxFRAX3CRV = 114;
uint256 constant TOKEN_cvxLUSD3CRV = 115;
uint256 constant TOKEN_cvxcrvPlain3andSUSD = 116;
uint256 constant TOKEN_cvxgusd3CRV = 117;
uint256 constant TOKEN_cvxOHMFRAXBP = 118;
uint256 constant TOKEN_cvxMIM_3LP3CRV = 119;
uint256 constant TOKEN_cvxcrvCRVETH = 120;
uint256 constant TOKEN_cvxcrvCVXETH = 121;
uint256 constant TOKEN_cvxcrvUSDTWBTCWETH = 122;
uint256 constant TOKEN_cvxLDOETH = 123;
uint256 constant TOKEN_cvxcrvUSDUSDC = 124;
uint256 constant TOKEN_cvxcrvUSDUSDT = 125;
uint256 constant TOKEN_cvxcrvUSDFRAX = 126;
uint256 constant TOKEN_cvxcrvUSDETHCRV = 127;
uint256 constant TOKEN_cvxGHOcrvUSD = 128;
uint256 constant TOKEN_stkcvx3Crv = 129;
uint256 constant TOKEN_stkcvxcrvFRAX = 130;
uint256 constant TOKEN_stkcvxsteCRV = 131;
uint256 constant TOKEN_stkcvxFRAX3CRV = 132;
uint256 constant TOKEN_stkcvxLUSD3CRV = 133;
uint256 constant TOKEN_stkcvxcrvPlain3andSUSD = 134;
uint256 constant TOKEN_stkcvxgusd3CRV = 135;
uint256 constant TOKEN_stkcvxOHMFRAXBP = 136;
uint256 constant TOKEN_stkcvxMIM_3LP3CRV = 137;
uint256 constant TOKEN_stkcvxcrvCRVETH = 138;
uint256 constant TOKEN_stkcvxcrvCVXETH = 139;
uint256 constant TOKEN_stkcvxcrvUSDTWBTCWETH = 140;
uint256 constant TOKEN_stkcvxLDOETH = 141;
uint256 constant TOKEN_stkcvxcrvUSDUSDC = 142;
uint256 constant TOKEN_stkcvxcrvUSDUSDT = 143;
uint256 constant TOKEN_stkcvxcrvUSDFRAX = 144;
uint256 constant TOKEN_stkcvxcrvUSDETHCRV = 145;
uint256 constant TOKEN_stkcvxGHOcrvUSD = 146;
uint256 constant TOKEN_cvxcrvUSDT = 147;
uint256 constant TOKEN_yvDAI = 148;
uint256 constant TOKEN_yvUSDC = 149;
uint256 constant TOKEN_yvUSDC_e = 150;
uint256 constant TOKEN_yvWETH = 151;
uint256 constant TOKEN_yvWBTC = 152;
uint256 constant TOKEN_yvUSDT = 153;
uint256 constant TOKEN_yvOP = 154;
uint256 constant TOKEN_yvCurve_stETH = 155;
uint256 constant TOKEN_yvCurve_FRAX = 156;
uint256 constant TOKEN__50WETH_50AURA = 157;
uint256 constant TOKEN_B_80BAL_20WETH = 158;
uint256 constant TOKEN__50OHM_50DAI = 159;
uint256 constant TOKEN__50OHM_50WETH = 160;
uint256 constant TOKEN_OHM_wstETH = 161;
uint256 constant TOKEN_USDC_DAI_USDT = 162;
uint256 constant TOKEN_B_rETH_STABLE = 163;
uint256 constant TOKEN_weETH_rETH = 164;
uint256 constant TOKEN_osETH_wETH_BPT = 165;
uint256 constant TOKEN_ezETH_WETH_BPT = 166;
uint256 constant TOKEN_trenSTETH = 167;
uint256 constant TOKEN_weETH_ezETH_rswETH = 168;
uint256 constant TOKEN_GHO_USDT_USDC = 169;
uint256 constant TOKEN_rsETH_WETH = 170;
uint256 constant TOKEN_rsETH_wETH_Arb = 171;
uint256 constant TOKEN_BPT_rETH_ETH = 172;
uint256 constant TOKEN_BPT_WSTETH_ETH = 173;
uint256 constant TOKEN_BPT_ROAD = 174;
uint256 constant TOKEN_ECLP_wstETH_WETH = 175;
uint256 constant TOKEN_wstETH_WETH_BPT = 176;
uint256 constant TOKEN_wstETH_rETH_sfrxETH = 177;
uint256 constant TOKEN_wstETH_rETH_cbETH = 178;
uint256 constant TOKEN_cbETH_rETH_wstETH = 179;
uint256 constant TOKEN_rETH_WETH_BPT_deprecated = 180;
uint256 constant TOKEN_rETH_wETH_BPT = 181;
uint256 constant TOKEN__33AURA_33ARB_33BAL = 182;
uint256 constant TOKEN_ezETH_wstETH = 183;
uint256 constant TOKEN_bpt_ethtri = 184;
uint256 constant TOKEN_aDAI = 185;
uint256 constant TOKEN_aUSDC = 186;
uint256 constant TOKEN_aUSDT = 187;
uint256 constant TOKEN_aWETH = 188;
uint256 constant TOKEN_waDAI = 189;
uint256 constant TOKEN_waUSDC = 190;
uint256 constant TOKEN_waUSDT = 191;
uint256 constant TOKEN_waWETH = 192;
uint256 constant TOKEN_cDAI = 193;
uint256 constant TOKEN_cUSDC = 194;
uint256 constant TOKEN_cUSDT = 195;
uint256 constant TOKEN_cETH = 196;
uint256 constant TOKEN_cLINK = 197;
uint256 constant TOKEN_fUSDC = 198;
uint256 constant TOKEN_sDAI = 199;
uint256 constant TOKEN_YieldETH = 200;
uint256 constant TOKEN_sUSDe = 201;
uint256 constant TOKEN_sUSDS = 202;
uint256 constant TOKEN_auraB_rETH_STABLE = 203;
uint256 constant TOKEN_auraosETH_wETH_BPT = 204;
uint256 constant TOKEN_auraweETH_rETH = 205;
uint256 constant TOKEN_auraBPT_rETH_ETH = 206;
uint256 constant TOKEN_auraBPT_WSTETH_ETH = 207;
uint256 constant TOKEN_aurawstETH_WETH_BPT = 208;
uint256 constant TOKEN_aurawstETH_rETH_sfrxETH = 209;
uint256 constant TOKEN_auracbETH_rETH_wstETH = 210;
uint256 constant TOKEN_aurarETH_wETH_BPT = 211;
uint256 constant TOKEN_auraB_rETH_STABLE_vault = 212;
uint256 constant TOKEN_auraosETH_wETH_BPT_vault = 213;
uint256 constant TOKEN_auraweETH_rETH_vault = 214;
uint256 constant TOKEN_auraBPT_rETH_ETH_vault = 215;
uint256 constant TOKEN_auraBPT_WSTETH_ETH_vault = 216;
uint256 constant TOKEN_aurawstETH_WETH_BPT_vault = 217;
uint256 constant TOKEN_aurawstETH_rETH_sfrxETH_vault = 218;
uint256 constant TOKEN_auracbETH_rETH_wstETH_vault = 219;
uint256 constant TOKEN_aurarETH_wETH_BPT_vault = 220;
uint256 constant TOKEN_zpufETH = 221;
uint256 constant TOKEN_stkUSDS = 222;
uint256 constant TOKEN_dDAI = 223;
uint256 constant TOKEN_dUSDC = 224;
uint256 constant TOKEN_dWBTC = 225;
uint256 constant TOKEN_dWETH = 226;
uint256 constant TOKEN_dwstETH = 227;
uint256 constant TOKEN_dFRAX = 228;
uint256 constant TOKEN_dUSDCV3 = 229;
uint256 constant TOKEN_dUSDC_eV3 = 230;
uint256 constant TOKEN_dWBTCV3 = 231;
uint256 constant TOKEN_dWETHV3 = 232;
uint256 constant TOKEN_dUSDTV3 = 233;
uint256 constant TOKEN_dGHOV3 = 234;
uint256 constant TOKEN_dDAIV3 = 235;
uint256 constant TOKEN_dcrvUSDV3 = 236;
uint256 constant TOKEN_sdUSDCV3 = 237;
uint256 constant TOKEN_sdUSDC_eV3 = 238;
uint256 constant TOKEN_sdWBTCV3 = 239;
uint256 constant TOKEN_sdWETHV3 = 240;
uint256 constant TOKEN_sdWETHV3_OLD = 241;
uint256 constant TOKEN_sdUSDTV3 = 242;
uint256 constant TOKEN_sdGHOV3 = 243;
uint256 constant TOKEN_sdDAIV3 = 244;
uint256 constant TOKEN_sdcrvUSDV3 = 245;
uint256 constant TOKEN_GEAR = 246;
uint256 constant NUM_TOKENS = 247;

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
