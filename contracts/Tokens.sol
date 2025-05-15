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
uint256 constant TOKEN_wS = 48;
uint256 constant TOKEN_stS = 49;
uint256 constant TOKEN_scUSD = 50;
uint256 constant TOKEN_frxETH = 51;
uint256 constant TOKEN_PENDLE = 52;
uint256 constant TOKEN_MORPHO = 53;
uint256 constant TOKEN_cbETH = 54;
uint256 constant TOKEN_rswETH = 55;
uint256 constant TOKEN_USDe = 56;
uint256 constant TOKEN_GHO = 57;
uint256 constant TOKEN_pufETH = 58;
uint256 constant TOKEN_wstETH = 59;
uint256 constant TOKEN_tETH = 60;
uint256 constant TOKEN_USDL = 61;
uint256 constant TOKEN_wUSDL = 62;
uint256 constant TOKEN_RLUSD = 63;
uint256 constant TOKEN_lvlUSD = 64;
uint256 constant TOKEN_slvlUSD = 65;
uint256 constant TOKEN_steakLRT = 66;
uint256 constant TOKEN_Re7LRT = 67;
uint256 constant TOKEN_amphrETH = 68;
uint256 constant TOKEN_rstETH = 69;
uint256 constant TOKEN_pzETH = 70;
uint256 constant TOKEN_DVstETH = 71;
uint256 constant TOKEN_waEthLidowstETH = 72;
uint256 constant TOKEN_PT_rsETH_26SEP2024 = 73;
uint256 constant TOKEN_USDS = 74;
uint256 constant TOKEN_SKY = 75;
uint256 constant TOKEN_T = 76;
uint256 constant TOKEN_PT_sUSDe_26DEC2024 = 77;
uint256 constant TOKEN_PT_eETH_26DEC2024 = 78;
uint256 constant TOKEN_PT_ezETH_26DEC2024 = 79;
uint256 constant TOKEN_PT_eBTC_26DEC2024 = 80;
uint256 constant TOKEN_PT_LBTC_27MAR2025 = 81;
uint256 constant TOKEN_PT_corn_solvBTC_BBN_26DEC2024 = 82;
uint256 constant TOKEN_PT_corn_pumpBTC_26DEC2024 = 83;
uint256 constant TOKEN_PT_cornLBTC_26DEC2024 = 84;
uint256 constant TOKEN_PT_corn_eBTC_27MAR2025 = 85;
uint256 constant TOKEN_PT_sUSDe_27MAR2025 = 86;
uint256 constant TOKEN_PT_sUSDe_29MAY2025 = 87;
uint256 constant TOKEN_PT_beraSTONE_10APR2025 = 88;
uint256 constant TOKEN_PT_slvlUSD_25SEP2025 = 89;
uint256 constant TOKEN_rstETH_Lido_wstETH = 90;
uint256 constant TOKEN_DVstETH_Prime_wstETH = 91;
uint256 constant TOKEN_sfrxETH = 92;
uint256 constant TOKEN__3Crv = 93;
uint256 constant TOKEN_crvFRAX = 94;
uint256 constant TOKEN_steCRV = 95;
uint256 constant TOKEN_crvPlain3andSUSD = 96;
uint256 constant TOKEN_crvCRVETH = 97;
uint256 constant TOKEN_crvCVXETH = 98;
uint256 constant TOKEN_crvUSDTWBTCWETH = 99;
uint256 constant TOKEN_LDOETH = 100;
uint256 constant TOKEN_crvUSDUSDC = 101;
uint256 constant TOKEN_crvUSDUSDT = 102;
uint256 constant TOKEN_crvUsUSDe = 103;
uint256 constant TOKEN_llamathena = 104;
uint256 constant TOKEN_dolaSave = 105;
uint256 constant TOKEN_lvlUSDUSDC = 106;
uint256 constant TOKEN_slvlUSDlvlUSDNG = 107;
uint256 constant TOKEN_slvlUSDlvlUSD = 108;
uint256 constant TOKEN_crvUSDFRAX = 109;
uint256 constant TOKEN_crvUSDETHCRV = 110;
uint256 constant TOKEN_rETH_f = 111;
uint256 constant TOKEN_DOLAFRAXBP3CRV_f = 112;
uint256 constant TOKEN_crvUSDDOLA_f = 113;
uint256 constant TOKEN_USDeUSDC = 114;
uint256 constant TOKEN_FRAXUSDe = 115;
uint256 constant TOKEN_USDecrvUSD = 116;
uint256 constant TOKEN_FRAXsDAI = 117;
uint256 constant TOKEN_DOLAsUSDe = 118;
uint256 constant TOKEN_USDeDAI = 119;
uint256 constant TOKEN_MtEthena = 120;
uint256 constant TOKEN_GHOUSDe = 121;
uint256 constant TOKEN_pufETHwstE = 122;
uint256 constant TOKEN_GHOcrvUSD = 123;
uint256 constant TOKEN_wstETHCRV = 124;
uint256 constant TOKEN__2CRV = 125;
uint256 constant TOKEN__3c_crvUSD = 126;
uint256 constant TOKEN_crvUSDC = 127;
uint256 constant TOKEN_crvUSDT = 128;
uint256 constant TOKEN_crvUSDC_e = 129;
uint256 constant TOKEN_USDEUSDC = 130;
uint256 constant TOKEN__3CRV = 131;
uint256 constant TOKEN_ezETHWETH = 132;
uint256 constant TOKEN_ezpzETH = 133;
uint256 constant TOKEN_LBTCWBTC = 134;
uint256 constant TOKEN_eBTCWBTC = 135;
uint256 constant TOKEN_pumpBTCWBTC = 136;
uint256 constant TOKEN_TriBTC = 137;
uint256 constant TOKEN__2BTC_f = 138;
uint256 constant TOKEN_tETHwstETH = 139;
uint256 constant TOKEN_tETHweETH = 140;
uint256 constant TOKEN_pzETHstETH = 141;
uint256 constant TOKEN_USDLUSDC = 142;
uint256 constant TOKEN_RLUSDUSDC = 143;
uint256 constant TOKEN_FRAX3CRV = 144;
uint256 constant TOKEN_LUSD3CRV = 145;
uint256 constant TOKEN_gusd3CRV = 146;
uint256 constant TOKEN_cvx3Crv = 147;
uint256 constant TOKEN_cvxcrvFRAX = 148;
uint256 constant TOKEN_cvxsteCRV = 149;
uint256 constant TOKEN_cvxFRAX3CRV = 150;
uint256 constant TOKEN_cvxLUSD3CRV = 151;
uint256 constant TOKEN_cvxcrvPlain3andSUSD = 152;
uint256 constant TOKEN_cvxgusd3CRV = 153;
uint256 constant TOKEN_cvxcrvCRVETH = 154;
uint256 constant TOKEN_cvxcrvCVXETH = 155;
uint256 constant TOKEN_cvxcrvUSDTWBTCWETH = 156;
uint256 constant TOKEN_cvxLDOETH = 157;
uint256 constant TOKEN_cvxcrvUSDUSDC = 158;
uint256 constant TOKEN_cvxcrvUSDUSDT = 159;
uint256 constant TOKEN_cvxcrvUSDFRAX = 160;
uint256 constant TOKEN_cvxcrvUSDETHCRV = 161;
uint256 constant TOKEN_cvxGHOcrvUSD = 162;
uint256 constant TOKEN_cvxllamathena = 163;
uint256 constant TOKEN_cvxRLUSDUSDC = 164;
uint256 constant TOKEN_stkcvx3Crv = 165;
uint256 constant TOKEN_stkcvxcrvFRAX = 166;
uint256 constant TOKEN_stkcvxsteCRV = 167;
uint256 constant TOKEN_stkcvxFRAX3CRV = 168;
uint256 constant TOKEN_stkcvxLUSD3CRV = 169;
uint256 constant TOKEN_stkcvxcrvPlain3andSUSD = 170;
uint256 constant TOKEN_stkcvxgusd3CRV = 171;
uint256 constant TOKEN_stkcvxcrvCRVETH = 172;
uint256 constant TOKEN_stkcvxcrvCVXETH = 173;
uint256 constant TOKEN_stkcvxcrvUSDTWBTCWETH = 174;
uint256 constant TOKEN_stkcvxLDOETH = 175;
uint256 constant TOKEN_stkcvxcrvUSDUSDC = 176;
uint256 constant TOKEN_stkcvxcrvUSDUSDT = 177;
uint256 constant TOKEN_stkcvxcrvUSDFRAX = 178;
uint256 constant TOKEN_stkcvxcrvUSDETHCRV = 179;
uint256 constant TOKEN_stkcvxGHOcrvUSD = 180;
uint256 constant TOKEN_stkcvxllamathena = 181;
uint256 constant TOKEN_stkcvxRLUSDUSDC = 182;
uint256 constant TOKEN_cvxcrvUSDT = 183;
uint256 constant TOKEN_yvDAI = 184;
uint256 constant TOKEN_yvUSDC = 185;
uint256 constant TOKEN_yvUSDC_e = 186;
uint256 constant TOKEN_yvWETH = 187;
uint256 constant TOKEN_yvWBTC = 188;
uint256 constant TOKEN_yvUSDT = 189;
uint256 constant TOKEN_yvOP = 190;
uint256 constant TOKEN_yvCurve_stETH = 191;
uint256 constant TOKEN_yvCurve_FRAX = 192;
uint256 constant TOKEN__50WETH_50AURA = 193;
uint256 constant TOKEN_B_80BAL_20WETH = 194;
uint256 constant TOKEN_USDC_DAI_USDT = 195;
uint256 constant TOKEN_B_rETH_STABLE = 196;
uint256 constant TOKEN_weETH_rETH = 197;
uint256 constant TOKEN_osETH_wETH_BPT = 198;
uint256 constant TOKEN_ezETH_WETH_BPT = 199;
uint256 constant TOKEN_sUSDe_USDC_BPT = 200;
uint256 constant TOKEN_pumpBTC_WBTC_BPT = 201;
uint256 constant TOKEN_eBTC_WBTC_BPT = 202;
uint256 constant TOKEN_trenSTETH = 203;
uint256 constant TOKEN_weETH_ezETH_rswETH = 204;
uint256 constant TOKEN_GHO_USDT_USDC = 205;
uint256 constant TOKEN_rsETH_WETH = 206;
uint256 constant TOKEN_B_50WBTC_50WETH = 207;
uint256 constant TOKEN_rsETH_wETH_Arb = 208;
uint256 constant TOKEN_BPT_rETH_ETH = 209;
uint256 constant TOKEN_BPT_WSTETH_ETH = 210;
uint256 constant TOKEN_BPT_ROAD = 211;
uint256 constant TOKEN_ECLP_wstETH_WETH = 212;
uint256 constant TOKEN_wstETH_WETH_BPT = 213;
uint256 constant TOKEN_wstETH_rETH_sfrxETH = 214;
uint256 constant TOKEN_wstETH_rETH_cbETH = 215;
uint256 constant TOKEN_cbETH_rETH_wstETH = 216;
uint256 constant TOKEN_rETH_WETH_BPT_deprecated = 217;
uint256 constant TOKEN_rETH_wETH_BPT = 218;
uint256 constant TOKEN__33AURA_33ARB_33BAL = 219;
uint256 constant TOKEN_ezETH_wstETH = 220;
uint256 constant TOKEN_bpt_ethtri = 221;
uint256 constant TOKEN_bpt_rsb = 222;
uint256 constant TOKEN_bpt_sss = 223;
uint256 constant TOKEN_BPT_scUSD_stS = 224;
uint256 constant TOKEN_BPT_USDCe_stS = 225;
uint256 constant TOKEN_tETH_wstETH_BPT = 226;
uint256 constant TOKEN_aDAI = 227;
uint256 constant TOKEN_aUSDC = 228;
uint256 constant TOKEN_aUSDT = 229;
uint256 constant TOKEN_aWETH = 230;
uint256 constant TOKEN_waDAI = 231;
uint256 constant TOKEN_waUSDC = 232;
uint256 constant TOKEN_waUSDT = 233;
uint256 constant TOKEN_waWETH = 234;
uint256 constant TOKEN_cDAI = 235;
uint256 constant TOKEN_cUSDC = 236;
uint256 constant TOKEN_cUSDT = 237;
uint256 constant TOKEN_cETH = 238;
uint256 constant TOKEN_cLINK = 239;
uint256 constant TOKEN_fUSDC = 240;
uint256 constant TOKEN_sDAI = 241;
uint256 constant TOKEN_YieldETH = 242;
uint256 constant TOKEN_sUSDe = 243;
uint256 constant TOKEN_sUSDS = 244;
uint256 constant TOKEN_scrvUSD = 245;
uint256 constant TOKEN_csUSDL = 246;
uint256 constant TOKEN_auraB_rETH_STABLE = 247;
uint256 constant TOKEN_auraosETH_wETH_BPT = 248;
uint256 constant TOKEN_auraweETH_rETH = 249;
uint256 constant TOKEN_auraBPT_rETH_ETH = 250;
uint256 constant TOKEN_auraBPT_WSTETH_ETH = 251;
uint256 constant TOKEN_aurawstETH_WETH_BPT = 252;
uint256 constant TOKEN_aurawstETH_rETH_sfrxETH = 253;
uint256 constant TOKEN_auracbETH_rETH_wstETH = 254;
uint256 constant TOKEN_aurarETH_wETH_BPT = 255;
uint256 constant TOKEN_auraB_rETH_STABLE_vault = 256;
uint256 constant TOKEN_auraosETH_wETH_BPT_vault = 257;
uint256 constant TOKEN_auraweETH_rETH_vault = 258;
uint256 constant TOKEN_auraBPT_rETH_ETH_vault = 259;
uint256 constant TOKEN_auraBPT_WSTETH_ETH_vault = 260;
uint256 constant TOKEN_aurawstETH_WETH_BPT_vault = 261;
uint256 constant TOKEN_aurawstETH_rETH_sfrxETH_vault = 262;
uint256 constant TOKEN_auracbETH_rETH_wstETH_vault = 263;
uint256 constant TOKEN_aurarETH_wETH_BPT_vault = 264;
uint256 constant TOKEN_zpufETH = 265;
uint256 constant TOKEN_stkUSDS = 266;
uint256 constant TOKEN_dDAI = 267;
uint256 constant TOKEN_dUSDC = 268;
uint256 constant TOKEN_dWBTC = 269;
uint256 constant TOKEN_dWETH = 270;
uint256 constant TOKEN_dwstETH = 271;
uint256 constant TOKEN_dFRAX = 272;
uint256 constant TOKEN_dDOLAV3 = 273;
uint256 constant TOKEN_dtBTCV3 = 274;
uint256 constant TOKEN_dwstETHV3 = 275;
uint256 constant TOKEN_dwSV3 = 276;
uint256 constant TOKEN_dUSDCV3 = 277;
uint256 constant TOKEN_dUSDC_eV3 = 278;
uint256 constant TOKEN_dWBTCV3 = 279;
uint256 constant TOKEN_dWETHV3 = 280;
uint256 constant TOKEN_dUSDTV3 = 281;
uint256 constant TOKEN_dGHOV3 = 282;
uint256 constant TOKEN_dDAIV3 = 283;
uint256 constant TOKEN_dcrvUSDV3 = 284;
uint256 constant TOKEN_sdUSDCV3 = 285;
uint256 constant TOKEN_sdUSDC_eV3 = 286;
uint256 constant TOKEN_sdWBTCV3 = 287;
uint256 constant TOKEN_sdWETHV3 = 288;
uint256 constant TOKEN_sdWETHV3_OLD = 289;
uint256 constant TOKEN_sdUSDTV3 = 290;
uint256 constant TOKEN_sdGHOV3 = 291;
uint256 constant TOKEN_sdDAIV3 = 292;
uint256 constant TOKEN_sdcrvUSDV3 = 293;
uint256 constant TOKEN_GEAR = 294;
uint256 constant NUM_TOKENS = 295;

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
