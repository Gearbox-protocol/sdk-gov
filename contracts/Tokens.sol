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
uint256 constant TOKEN_tBTC = 14;
uint256 constant TOKEN_WETH = 15;
uint256 constant TOKEN_YFI = 16;
uint256 constant TOKEN_WLD = 17;
uint256 constant TOKEN_OP = 18;
uint256 constant TOKEN_STETH = 19;
uint256 constant TOKEN_CVX = 20;
uint256 constant TOKEN_FRAX = 21;
uint256 constant TOKEN_FXS = 22;
uint256 constant TOKEN_LDO = 23;
uint256 constant TOKEN_LUSD = 24;
uint256 constant TOKEN_sUSD = 25;
uint256 constant TOKEN_GUSD = 26;
uint256 constant TOKEN_LQTY = 27;
uint256 constant TOKEN_GMX = 28;
uint256 constant TOKEN_ARB = 29;
uint256 constant TOKEN_BAL = 30;
uint256 constant TOKEN_SHIB = 31;
uint256 constant TOKEN_crvUSD = 32;
uint256 constant TOKEN_MKR = 33;
uint256 constant TOKEN_RPL = 34;
uint256 constant TOKEN_APE = 35;
uint256 constant TOKEN_LBTC = 36;
uint256 constant TOKEN_eBTC = 37;
uint256 constant TOKEN_solvBTC = 38;
uint256 constant TOKEN_pumpBTC = 39;
uint256 constant TOKEN_rETH = 40;
uint256 constant TOKEN_AURA = 41;
uint256 constant TOKEN_osETH = 42;
uint256 constant TOKEN_weETH = 43;
uint256 constant TOKEN_SWISE = 44;
uint256 constant TOKEN_ezETH = 45;
uint256 constant TOKEN_rsETH = 46;
uint256 constant TOKEN_beraSTONE = 47;
uint256 constant TOKEN_frxETH = 48;
uint256 constant TOKEN_PENDLE = 49;
uint256 constant TOKEN_cbETH = 50;
uint256 constant TOKEN_rswETH = 51;
uint256 constant TOKEN_USDe = 52;
uint256 constant TOKEN_GHO = 53;
uint256 constant TOKEN_pufETH = 54;
uint256 constant TOKEN_wstETH = 55;
uint256 constant TOKEN_tETH = 56;
uint256 constant TOKEN_steakLRT = 57;
uint256 constant TOKEN_Re7LRT = 58;
uint256 constant TOKEN_amphrETH = 59;
uint256 constant TOKEN_rstETH = 60;
uint256 constant TOKEN_pzETH = 61;
uint256 constant TOKEN_DVstETH = 62;
uint256 constant TOKEN_PT_rsETH_26SEP2024 = 63;
uint256 constant TOKEN_USDS = 64;
uint256 constant TOKEN_SKY = 65;
uint256 constant TOKEN_T = 66;
uint256 constant TOKEN_PT_sUSDe_26DEC2024 = 67;
uint256 constant TOKEN_PT_eETH_26DEC2024 = 68;
uint256 constant TOKEN_PT_ezETH_26DEC2024 = 69;
uint256 constant TOKEN_PT_eBTC_26DEC2024 = 70;
uint256 constant TOKEN_PT_LBTC_27MAR2025 = 71;
uint256 constant TOKEN_PT_corn_solvBTC_BBN_26DEC2024 = 72;
uint256 constant TOKEN_PT_corn_pumpBTC_26DEC2024 = 73;
uint256 constant TOKEN_PT_cornLBTC_26DEC2024 = 74;
uint256 constant TOKEN_PT_corn_eBTC_27MAR2025 = 75;
uint256 constant TOKEN_PT_sUSDe_27MAR2025 = 76;
uint256 constant TOKEN_PT_sUSDe_29MAY2025 = 77;
uint256 constant TOKEN_PT_beraSTONE_10APR2025 = 78;
uint256 constant TOKEN_rstETH_Lido_wstETH = 79;
uint256 constant TOKEN_DVstETH_Prime_wstETH = 80;
uint256 constant TOKEN_sfrxETH = 81;
uint256 constant TOKEN__3Crv = 82;
uint256 constant TOKEN_crvFRAX = 83;
uint256 constant TOKEN_steCRV = 84;
uint256 constant TOKEN_crvPlain3andSUSD = 85;
uint256 constant TOKEN_crvCRVETH = 86;
uint256 constant TOKEN_crvCVXETH = 87;
uint256 constant TOKEN_crvUSDTWBTCWETH = 88;
uint256 constant TOKEN_LDOETH = 89;
uint256 constant TOKEN_crvUSDUSDC = 90;
uint256 constant TOKEN_crvUSDUSDT = 91;
uint256 constant TOKEN_crvUsUSDe = 92;
uint256 constant TOKEN_llamathena = 93;
uint256 constant TOKEN_crvUSDFRAX = 94;
uint256 constant TOKEN_crvUSDETHCRV = 95;
uint256 constant TOKEN_rETH_f = 96;
uint256 constant TOKEN_DOLAFRAXBP3CRV_f = 97;
uint256 constant TOKEN_crvUSDDOLA_f = 98;
uint256 constant TOKEN_USDeUSDC = 99;
uint256 constant TOKEN_FRAXUSDe = 100;
uint256 constant TOKEN_USDecrvUSD = 101;
uint256 constant TOKEN_FRAXsDAI = 102;
uint256 constant TOKEN_DOLAsUSDe = 103;
uint256 constant TOKEN_USDeDAI = 104;
uint256 constant TOKEN_MtEthena = 105;
uint256 constant TOKEN_GHOUSDe = 106;
uint256 constant TOKEN_pufETHwstE = 107;
uint256 constant TOKEN_GHOcrvUSD = 108;
uint256 constant TOKEN_wstETHCRV = 109;
uint256 constant TOKEN__2CRV = 110;
uint256 constant TOKEN__3c_crvUSD = 111;
uint256 constant TOKEN_crvUSDC = 112;
uint256 constant TOKEN_crvUSDT = 113;
uint256 constant TOKEN_crvUSDC_e = 114;
uint256 constant TOKEN_USDEUSDC = 115;
uint256 constant TOKEN__3CRV = 116;
uint256 constant TOKEN_ezETHWETH = 117;
uint256 constant TOKEN_ezpzETH = 118;
uint256 constant TOKEN_LBTCWBTC = 119;
uint256 constant TOKEN_eBTCWBTC = 120;
uint256 constant TOKEN_pumpBTCWBTC = 121;
uint256 constant TOKEN_TriBTC = 122;
uint256 constant TOKEN__2BTC_f = 123;
uint256 constant TOKEN_tETHwstETH = 124;
uint256 constant TOKEN_tETHweETH = 125;
uint256 constant TOKEN_pzETHstETH = 126;
uint256 constant TOKEN_FRAX3CRV = 127;
uint256 constant TOKEN_LUSD3CRV = 128;
uint256 constant TOKEN_gusd3CRV = 129;
uint256 constant TOKEN_cvx3Crv = 130;
uint256 constant TOKEN_cvxcrvFRAX = 131;
uint256 constant TOKEN_cvxsteCRV = 132;
uint256 constant TOKEN_cvxFRAX3CRV = 133;
uint256 constant TOKEN_cvxLUSD3CRV = 134;
uint256 constant TOKEN_cvxcrvPlain3andSUSD = 135;
uint256 constant TOKEN_cvxgusd3CRV = 136;
uint256 constant TOKEN_cvxcrvCRVETH = 137;
uint256 constant TOKEN_cvxcrvCVXETH = 138;
uint256 constant TOKEN_cvxcrvUSDTWBTCWETH = 139;
uint256 constant TOKEN_cvxLDOETH = 140;
uint256 constant TOKEN_cvxcrvUSDUSDC = 141;
uint256 constant TOKEN_cvxcrvUSDUSDT = 142;
uint256 constant TOKEN_cvxcrvUSDFRAX = 143;
uint256 constant TOKEN_cvxcrvUSDETHCRV = 144;
uint256 constant TOKEN_cvxGHOcrvUSD = 145;
uint256 constant TOKEN_cvxllamathena = 146;
uint256 constant TOKEN_stkcvx3Crv = 147;
uint256 constant TOKEN_stkcvxcrvFRAX = 148;
uint256 constant TOKEN_stkcvxsteCRV = 149;
uint256 constant TOKEN_stkcvxFRAX3CRV = 150;
uint256 constant TOKEN_stkcvxLUSD3CRV = 151;
uint256 constant TOKEN_stkcvxcrvPlain3andSUSD = 152;
uint256 constant TOKEN_stkcvxgusd3CRV = 153;
uint256 constant TOKEN_stkcvxcrvCRVETH = 154;
uint256 constant TOKEN_stkcvxcrvCVXETH = 155;
uint256 constant TOKEN_stkcvxcrvUSDTWBTCWETH = 156;
uint256 constant TOKEN_stkcvxLDOETH = 157;
uint256 constant TOKEN_stkcvxcrvUSDUSDC = 158;
uint256 constant TOKEN_stkcvxcrvUSDUSDT = 159;
uint256 constant TOKEN_stkcvxcrvUSDFRAX = 160;
uint256 constant TOKEN_stkcvxcrvUSDETHCRV = 161;
uint256 constant TOKEN_stkcvxGHOcrvUSD = 162;
uint256 constant TOKEN_stkcvxllamathena = 163;
uint256 constant TOKEN_cvxcrvUSDT = 164;
uint256 constant TOKEN_yvDAI = 165;
uint256 constant TOKEN_yvUSDC = 166;
uint256 constant TOKEN_yvUSDC_e = 167;
uint256 constant TOKEN_yvWETH = 168;
uint256 constant TOKEN_yvWBTC = 169;
uint256 constant TOKEN_yvUSDT = 170;
uint256 constant TOKEN_yvOP = 171;
uint256 constant TOKEN_yvCurve_stETH = 172;
uint256 constant TOKEN_yvCurve_FRAX = 173;
uint256 constant TOKEN__50WETH_50AURA = 174;
uint256 constant TOKEN_B_80BAL_20WETH = 175;
uint256 constant TOKEN_USDC_DAI_USDT = 176;
uint256 constant TOKEN_B_rETH_STABLE = 177;
uint256 constant TOKEN_weETH_rETH = 178;
uint256 constant TOKEN_osETH_wETH_BPT = 179;
uint256 constant TOKEN_ezETH_WETH_BPT = 180;
uint256 constant TOKEN_sUSDe_USDC_BPT = 181;
uint256 constant TOKEN_pumpBTC_WBTC_BPT = 182;
uint256 constant TOKEN_eBTC_WBTC_BPT = 183;
uint256 constant TOKEN_trenSTETH = 184;
uint256 constant TOKEN_weETH_ezETH_rswETH = 185;
uint256 constant TOKEN_GHO_USDT_USDC = 186;
uint256 constant TOKEN_rsETH_WETH = 187;
uint256 constant TOKEN_B_50WBTC_50WETH = 188;
uint256 constant TOKEN_rsETH_wETH_Arb = 189;
uint256 constant TOKEN_BPT_rETH_ETH = 190;
uint256 constant TOKEN_BPT_WSTETH_ETH = 191;
uint256 constant TOKEN_BPT_ROAD = 192;
uint256 constant TOKEN_ECLP_wstETH_WETH = 193;
uint256 constant TOKEN_wstETH_WETH_BPT = 194;
uint256 constant TOKEN_wstETH_rETH_sfrxETH = 195;
uint256 constant TOKEN_wstETH_rETH_cbETH = 196;
uint256 constant TOKEN_cbETH_rETH_wstETH = 197;
uint256 constant TOKEN_rETH_WETH_BPT_deprecated = 198;
uint256 constant TOKEN_rETH_wETH_BPT = 199;
uint256 constant TOKEN__33AURA_33ARB_33BAL = 200;
uint256 constant TOKEN_ezETH_wstETH = 201;
uint256 constant TOKEN_bpt_ethtri = 202;
uint256 constant TOKEN_tETH_wstETH_BPT = 203;
uint256 constant TOKEN_aDAI = 204;
uint256 constant TOKEN_aUSDC = 205;
uint256 constant TOKEN_aUSDT = 206;
uint256 constant TOKEN_aWETH = 207;
uint256 constant TOKEN_waDAI = 208;
uint256 constant TOKEN_waUSDC = 209;
uint256 constant TOKEN_waUSDT = 210;
uint256 constant TOKEN_waWETH = 211;
uint256 constant TOKEN_cDAI = 212;
uint256 constant TOKEN_cUSDC = 213;
uint256 constant TOKEN_cUSDT = 214;
uint256 constant TOKEN_cETH = 215;
uint256 constant TOKEN_cLINK = 216;
uint256 constant TOKEN_fUSDC = 217;
uint256 constant TOKEN_sDAI = 218;
uint256 constant TOKEN_YieldETH = 219;
uint256 constant TOKEN_sUSDe = 220;
uint256 constant TOKEN_sUSDS = 221;
uint256 constant TOKEN_scrvUSD = 222;
uint256 constant TOKEN_waEthLidowstETH = 223;
uint256 constant TOKEN_auraB_rETH_STABLE = 224;
uint256 constant TOKEN_auraosETH_wETH_BPT = 225;
uint256 constant TOKEN_auraweETH_rETH = 226;
uint256 constant TOKEN_auraBPT_rETH_ETH = 227;
uint256 constant TOKEN_auraBPT_WSTETH_ETH = 228;
uint256 constant TOKEN_aurawstETH_WETH_BPT = 229;
uint256 constant TOKEN_aurawstETH_rETH_sfrxETH = 230;
uint256 constant TOKEN_auracbETH_rETH_wstETH = 231;
uint256 constant TOKEN_aurarETH_wETH_BPT = 232;
uint256 constant TOKEN_auraB_rETH_STABLE_vault = 233;
uint256 constant TOKEN_auraosETH_wETH_BPT_vault = 234;
uint256 constant TOKEN_auraweETH_rETH_vault = 235;
uint256 constant TOKEN_auraBPT_rETH_ETH_vault = 236;
uint256 constant TOKEN_auraBPT_WSTETH_ETH_vault = 237;
uint256 constant TOKEN_aurawstETH_WETH_BPT_vault = 238;
uint256 constant TOKEN_aurawstETH_rETH_sfrxETH_vault = 239;
uint256 constant TOKEN_auracbETH_rETH_wstETH_vault = 240;
uint256 constant TOKEN_aurarETH_wETH_BPT_vault = 241;
uint256 constant TOKEN_zpufETH = 242;
uint256 constant TOKEN_stkUSDS = 243;
uint256 constant TOKEN_dDAI = 244;
uint256 constant TOKEN_dUSDC = 245;
uint256 constant TOKEN_dWBTC = 246;
uint256 constant TOKEN_dWETH = 247;
uint256 constant TOKEN_dwstETH = 248;
uint256 constant TOKEN_dFRAX = 249;
uint256 constant TOKEN_dDOLAV3 = 250;
uint256 constant TOKEN_dtBTCV3 = 251;
uint256 constant TOKEN_dwstETHV3 = 252;
uint256 constant TOKEN_dUSDCV3 = 253;
uint256 constant TOKEN_dUSDC_eV3 = 254;
uint256 constant TOKEN_dWBTCV3 = 255;
uint256 constant TOKEN_dWETHV3 = 256;
uint256 constant TOKEN_dUSDTV3 = 257;
uint256 constant TOKEN_dGHOV3 = 258;
uint256 constant TOKEN_dDAIV3 = 259;
uint256 constant TOKEN_dcrvUSDV3 = 260;
uint256 constant TOKEN_sdUSDCV3 = 261;
uint256 constant TOKEN_sdUSDC_eV3 = 262;
uint256 constant TOKEN_sdWBTCV3 = 263;
uint256 constant TOKEN_sdWETHV3 = 264;
uint256 constant TOKEN_sdWETHV3_OLD = 265;
uint256 constant TOKEN_sdUSDTV3 = 266;
uint256 constant TOKEN_sdGHOV3 = 267;
uint256 constant TOKEN_sdDAIV3 = 268;
uint256 constant TOKEN_sdcrvUSDV3 = 269;
uint256 constant TOKEN_GEAR = 270;
uint256 constant NUM_TOKENS = 271;

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
