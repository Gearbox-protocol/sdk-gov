// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

/// @dev c-Tokens and LUNA are added for unit test purposes
uint256 constant TOKEN_NO_TOKEN = 0;
uint256 constant TOKEN_LUNA = 1;
uint256 constant TOKEN__1INCH = 2;
uint256 constant TOKEN_AAVE = 3;
uint256 constant TOKEN_CRV = 4;
uint256 constant TOKEN_DAI = 5;
uint256 constant TOKEN_LINK = 6;
uint256 constant TOKEN_SNX = 7;
uint256 constant TOKEN_UNI = 8;
uint256 constant TOKEN_USDC = 9;
uint256 constant TOKEN_USDC_e = 10;
uint256 constant TOKEN_USDT = 11;
uint256 constant TOKEN_DOLA = 12;
uint256 constant TOKEN_WBTC = 13;
uint256 constant TOKEN_WETH = 14;
uint256 constant TOKEN_YFI = 15;
uint256 constant TOKEN_WLD = 16;
uint256 constant TOKEN_OP = 17;
uint256 constant TOKEN_STETH = 18;
uint256 constant TOKEN_CVX = 19;
uint256 constant TOKEN_FRAX = 20;
uint256 constant TOKEN_FXS = 21;
uint256 constant TOKEN_LDO = 22;
uint256 constant TOKEN_LUSD = 23;
uint256 constant TOKEN_sUSD = 24;
uint256 constant TOKEN_GUSD = 25;
uint256 constant TOKEN_LQTY = 26;
uint256 constant TOKEN_GMX = 27;
uint256 constant TOKEN_ARB = 28;
uint256 constant TOKEN_BAL = 29;
uint256 constant TOKEN_SHIB = 30;
uint256 constant TOKEN_crvUSD = 31;
uint256 constant TOKEN_MKR = 32;
uint256 constant TOKEN_RPL = 33;
uint256 constant TOKEN_APE = 34;
uint256 constant TOKEN_LBTC = 35;
uint256 constant TOKEN_eBTC = 36;
uint256 constant TOKEN_solvBTC = 37;
uint256 constant TOKEN_pumpBTC = 38;
uint256 constant TOKEN_rETH = 39;
uint256 constant TOKEN_AURA = 40;
uint256 constant TOKEN_osETH = 41;
uint256 constant TOKEN_weETH = 42;
uint256 constant TOKEN_SWISE = 43;
uint256 constant TOKEN_ezETH = 44;
uint256 constant TOKEN_rsETH = 45;
uint256 constant TOKEN_frxETH = 46;
uint256 constant TOKEN_PENDLE = 47;
uint256 constant TOKEN_cbETH = 48;
uint256 constant TOKEN_rswETH = 49;
uint256 constant TOKEN_USDe = 50;
uint256 constant TOKEN_GHO = 51;
uint256 constant TOKEN_pufETH = 52;
uint256 constant TOKEN_wstETH = 53;
uint256 constant TOKEN_steakLRT = 54;
uint256 constant TOKEN_Re7LRT = 55;
uint256 constant TOKEN_amphrETH = 56;
uint256 constant TOKEN_rstETH = 57;
uint256 constant TOKEN_pzETH = 58;
uint256 constant TOKEN_PT_rsETH_26SEP2024 = 59;
uint256 constant TOKEN_USDS = 60;
uint256 constant TOKEN_SKY = 61;
uint256 constant TOKEN_PT_sUSDe_26DEC2024 = 62;
uint256 constant TOKEN_PT_eETH_26DEC2024 = 63;
uint256 constant TOKEN_PT_ezETH_26DEC2024 = 64;
uint256 constant TOKEN_PT_eBTC_26DEC2024 = 65;
uint256 constant TOKEN_PT_LBTC_27MAR2025 = 66;
uint256 constant TOKEN_PT_corn_solvBTC_BBN_26DEC2024 = 67;
uint256 constant TOKEN_PT_corn_pumpBTC_26DEC2024 = 68;
uint256 constant TOKEN_PT_cornLBTC_26DEC2024 = 69;
uint256 constant TOKEN_PT_corn_eBTC_27MAR2025 = 70;
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
uint256 constant TOKEN_crvUsUSDe = 82;
uint256 constant TOKEN_scrvUsUSDe = 83;
uint256 constant TOKEN_crvUSDFRAX = 84;
uint256 constant TOKEN_crvUSDETHCRV = 85;
uint256 constant TOKEN_rETH_f = 86;
uint256 constant TOKEN_DOLAFRAXBP3CRV_f = 87;
uint256 constant TOKEN_crvUSDDOLA_f = 88;
uint256 constant TOKEN_USDeUSDC = 89;
uint256 constant TOKEN_FRAXUSDe = 90;
uint256 constant TOKEN_USDecrvUSD = 91;
uint256 constant TOKEN_FRAXsDAI = 92;
uint256 constant TOKEN_DOLAsUSDe = 93;
uint256 constant TOKEN_USDeDAI = 94;
uint256 constant TOKEN_MtEthena = 95;
uint256 constant TOKEN_GHOUSDe = 96;
uint256 constant TOKEN_pufETHwstE = 97;
uint256 constant TOKEN_GHOcrvUSD = 98;
uint256 constant TOKEN_wstETHCRV = 99;
uint256 constant TOKEN__2CRV = 100;
uint256 constant TOKEN__3c_crvUSD = 101;
uint256 constant TOKEN_crvUSDC = 102;
uint256 constant TOKEN_crvUSDT = 103;
uint256 constant TOKEN_crvUSDC_e = 104;
uint256 constant TOKEN_USDEUSDC = 105;
uint256 constant TOKEN__3CRV = 106;
uint256 constant TOKEN_ezETHWETH = 107;
uint256 constant TOKEN_ezpzETH = 108;
uint256 constant TOKEN_LBTCWBTC = 109;
uint256 constant TOKEN_eBTCWBTC = 110;
uint256 constant TOKEN_TriBTC = 111;
uint256 constant TOKEN_FRAX3CRV = 112;
uint256 constant TOKEN_LUSD3CRV = 113;
uint256 constant TOKEN_gusd3CRV = 114;
uint256 constant TOKEN_cvx3Crv = 115;
uint256 constant TOKEN_cvxcrvFRAX = 116;
uint256 constant TOKEN_cvxsteCRV = 117;
uint256 constant TOKEN_cvxFRAX3CRV = 118;
uint256 constant TOKEN_cvxLUSD3CRV = 119;
uint256 constant TOKEN_cvxcrvPlain3andSUSD = 120;
uint256 constant TOKEN_cvxgusd3CRV = 121;
uint256 constant TOKEN_cvxcrvCRVETH = 122;
uint256 constant TOKEN_cvxcrvCVXETH = 123;
uint256 constant TOKEN_cvxcrvUSDTWBTCWETH = 124;
uint256 constant TOKEN_cvxLDOETH = 125;
uint256 constant TOKEN_cvxcrvUSDUSDC = 126;
uint256 constant TOKEN_cvxcrvUSDUSDT = 127;
uint256 constant TOKEN_cvxcrvUSDFRAX = 128;
uint256 constant TOKEN_cvxcrvUSDETHCRV = 129;
uint256 constant TOKEN_cvxGHOcrvUSD = 130;
uint256 constant TOKEN_stkcvx3Crv = 131;
uint256 constant TOKEN_stkcvxcrvFRAX = 132;
uint256 constant TOKEN_stkcvxsteCRV = 133;
uint256 constant TOKEN_stkcvxFRAX3CRV = 134;
uint256 constant TOKEN_stkcvxLUSD3CRV = 135;
uint256 constant TOKEN_stkcvxcrvPlain3andSUSD = 136;
uint256 constant TOKEN_stkcvxgusd3CRV = 137;
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
uint256 constant TOKEN_USDC_DAI_USDT = 159;
uint256 constant TOKEN_B_rETH_STABLE = 160;
uint256 constant TOKEN_weETH_rETH = 161;
uint256 constant TOKEN_osETH_wETH_BPT = 162;
uint256 constant TOKEN_ezETH_WETH_BPT = 163;
uint256 constant TOKEN_sUSDe_USDC_BPT = 164;
uint256 constant TOKEN_trenSTETH = 165;
uint256 constant TOKEN_weETH_ezETH_rswETH = 166;
uint256 constant TOKEN_GHO_USDT_USDC = 167;
uint256 constant TOKEN_rsETH_WETH = 168;
uint256 constant TOKEN_rsETH_wETH_Arb = 169;
uint256 constant TOKEN_BPT_rETH_ETH = 170;
uint256 constant TOKEN_BPT_WSTETH_ETH = 171;
uint256 constant TOKEN_BPT_ROAD = 172;
uint256 constant TOKEN_ECLP_wstETH_WETH = 173;
uint256 constant TOKEN_wstETH_WETH_BPT = 174;
uint256 constant TOKEN_wstETH_rETH_sfrxETH = 175;
uint256 constant TOKEN_wstETH_rETH_cbETH = 176;
uint256 constant TOKEN_cbETH_rETH_wstETH = 177;
uint256 constant TOKEN_rETH_WETH_BPT_deprecated = 178;
uint256 constant TOKEN_rETH_wETH_BPT = 179;
uint256 constant TOKEN__33AURA_33ARB_33BAL = 180;
uint256 constant TOKEN_ezETH_wstETH = 181;
uint256 constant TOKEN_bpt_ethtri = 182;
uint256 constant TOKEN_aDAI = 183;
uint256 constant TOKEN_aUSDC = 184;
uint256 constant TOKEN_aUSDT = 185;
uint256 constant TOKEN_aWETH = 186;
uint256 constant TOKEN_waDAI = 187;
uint256 constant TOKEN_waUSDC = 188;
uint256 constant TOKEN_waUSDT = 189;
uint256 constant TOKEN_waWETH = 190;
uint256 constant TOKEN_cDAI = 191;
uint256 constant TOKEN_cUSDC = 192;
uint256 constant TOKEN_cUSDT = 193;
uint256 constant TOKEN_cETH = 194;
uint256 constant TOKEN_cLINK = 195;
uint256 constant TOKEN_fUSDC = 196;
uint256 constant TOKEN_sDAI = 197;
uint256 constant TOKEN_YieldETH = 198;
uint256 constant TOKEN_sUSDe = 199;
uint256 constant TOKEN_sUSDS = 200;
uint256 constant TOKEN_scrvUSD = 201;
uint256 constant TOKEN_auraB_rETH_STABLE = 202;
uint256 constant TOKEN_auraosETH_wETH_BPT = 203;
uint256 constant TOKEN_auraweETH_rETH = 204;
uint256 constant TOKEN_auraBPT_rETH_ETH = 205;
uint256 constant TOKEN_auraBPT_WSTETH_ETH = 206;
uint256 constant TOKEN_aurawstETH_WETH_BPT = 207;
uint256 constant TOKEN_aurawstETH_rETH_sfrxETH = 208;
uint256 constant TOKEN_auracbETH_rETH_wstETH = 209;
uint256 constant TOKEN_aurarETH_wETH_BPT = 210;
uint256 constant TOKEN_auraB_rETH_STABLE_vault = 211;
uint256 constant TOKEN_auraosETH_wETH_BPT_vault = 212;
uint256 constant TOKEN_auraweETH_rETH_vault = 213;
uint256 constant TOKEN_auraBPT_rETH_ETH_vault = 214;
uint256 constant TOKEN_auraBPT_WSTETH_ETH_vault = 215;
uint256 constant TOKEN_aurawstETH_WETH_BPT_vault = 216;
uint256 constant TOKEN_aurawstETH_rETH_sfrxETH_vault = 217;
uint256 constant TOKEN_auracbETH_rETH_wstETH_vault = 218;
uint256 constant TOKEN_aurarETH_wETH_BPT_vault = 219;
uint256 constant TOKEN_zpufETH = 220;
uint256 constant TOKEN_stkUSDS = 221;
uint256 constant TOKEN_dDAI = 222;
uint256 constant TOKEN_dUSDC = 223;
uint256 constant TOKEN_dWBTC = 224;
uint256 constant TOKEN_dWETH = 225;
uint256 constant TOKEN_dwstETH = 226;
uint256 constant TOKEN_dFRAX = 227;
uint256 constant TOKEN_dUSDCV3 = 228;
uint256 constant TOKEN_dUSDC_eV3 = 229;
uint256 constant TOKEN_dWBTCV3 = 230;
uint256 constant TOKEN_dWETHV3 = 231;
uint256 constant TOKEN_dUSDTV3 = 232;
uint256 constant TOKEN_dGHOV3 = 233;
uint256 constant TOKEN_dDAIV3 = 234;
uint256 constant TOKEN_dcrvUSDV3 = 235;
uint256 constant TOKEN_dDOLAV3 = 236;
uint256 constant TOKEN_sdUSDCV3 = 237;
uint256 constant TOKEN_sdUSDC_eV3 = 238;
uint256 constant TOKEN_sdWBTCV3 = 239;
uint256 constant TOKEN_sdWETHV3 = 240;
uint256 constant TOKEN_sdWETHV3_OLD = 241;
uint256 constant TOKEN_sdUSDTV3 = 242;
uint256 constant TOKEN_sdGHOV3 = 243;
uint256 constant TOKEN_sdDAIV3 = 244;
uint256 constant TOKEN_sdcrvUSDV3 = 245;
uint256 constant TOKEN_sdDOLAV3 = 246;
uint256 constant TOKEN_GEAR = 247;
uint256 constant NUM_TOKENS = 248;

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
