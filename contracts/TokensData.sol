// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

import "./Tokens.sol";

interface IERC20Check {
    function totalSupply() external view returns (uint256);
}

struct TokenData {
    uint256 id;
    address addr;
    string symbol;
    TokenType tokenType;
}

contract TokensDataLive {
    mapping(uint256 => TokenData[]) tokenDataByNetwork;

    constructor() {
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN__1INCH,
                addr: 0x111111111117dC0aa78b770fA6A738034120C302,
                symbol: "1INCH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_AAVE,
                addr: 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9,
                symbol: "AAVE",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_CRV,
                addr: 0xD533a949740bb3306d119CC777fa900bA034cd52,
                symbol: "CRV",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_DAI,
                addr: 0x6B175474E89094C44Da98b954EedeAC495271d0F,
                symbol: "DAI",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_LINK,
                addr: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
                symbol: "LINK",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_SNX,
                addr: 0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F,
                symbol: "SNX",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_UNI,
                addr: 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984,
                symbol: "UNI",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_USDC,
                addr: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,
                symbol: "USDC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_USDT,
                addr: 0xdAC17F958D2ee523a2206206994597C13D831ec7,
                symbol: "USDT",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_DOLA,
                addr: 0x865377367054516e17014CcdED1e7d814EDC9ce4,
                symbol: "DOLA",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_WBTC,
                addr: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599,
                symbol: "WBTC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_WETH,
                addr: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
                symbol: "WETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_YFI,
                addr: 0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e,
                symbol: "YFI",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_WLD,
                addr: 0x163f8C2467924be0ae7B5347228CABF260318753,
                symbol: "WLD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_STETH,
                addr: 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84,
                symbol: "STETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_CVX,
                addr: 0x4e3FBD56CD56c3e72c1403e103b45Db9da5B9D2B,
                symbol: "CVX",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_FRAX,
                addr: 0x853d955aCEf822Db058eb8505911ED77F175b99e,
                symbol: "FRAX",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_FXS,
                addr: 0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0,
                symbol: "FXS",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_LDO,
                addr: 0x5A98FcBEA516Cf06857215779Fd812CA3beF1B32,
                symbol: "LDO",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_LUSD,
                addr: 0x5f98805A4E8be255a32880FDeC7F6728C6568bA0,
                symbol: "LUSD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sUSD,
                addr: 0x57Ab1ec28D129707052df4dF418D58a2D46d5f51,
                symbol: "sUSD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_GUSD,
                addr: 0x056Fd409E1d7A124BD7017459dFEa2F387b6d5Cd,
                symbol: "GUSD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_LQTY,
                addr: 0x6DEA81C8171D0bA574754EF6F8b412F2Ed88c54D,
                symbol: "LQTY",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_ARB,
                addr: 0xB50721BCf8d664c30412Cfbc6cf7a15145234ad1,
                symbol: "ARB",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_BAL,
                addr: 0xba100000625a3754423978a60c9317c58a424e3D,
                symbol: "BAL",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_SHIB,
                addr: 0x95aD61b0a150d79219dCF64E1E6Cc01f0B64C4cE,
                symbol: "SHIB",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvUSD,
                addr: 0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E,
                symbol: "crvUSD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_MKR,
                addr: 0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2,
                symbol: "MKR",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_RPL,
                addr: 0xB4EFd85c19999D84251304bDA99E90B92300Bd93,
                symbol: "RPL",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_APE,
                addr: 0x4d224452801ACEd8B2F0aebE155379bb5D594381,
                symbol: "APE",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_LBTC,
                addr: 0x8236a87084f8B84306f72007F36F2618A5634494,
                symbol: "LBTC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_eBTC,
                addr: 0x657e8C867D8B37dCC18fA4Caead9C45EB088C642,
                symbol: "eBTC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_solvBTC,
                addr: 0xd9D920AA40f578ab794426F5C90F6C731D159DEf,
                symbol: "solvBTC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_pumpBTC,
                addr: 0xF469fBD2abcd6B9de8E169d128226C0Fc90a012e,
                symbol: "pumpBTC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_rETH,
                addr: 0xae78736Cd615f374D3085123A210448E74Fc6393,
                symbol: "rETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_AURA,
                addr: 0xC0c293ce456fF0ED870ADd98a0828Dd4d2903DBF,
                symbol: "AURA",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_osETH,
                addr: 0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38,
                symbol: "osETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_weETH,
                addr: 0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee,
                symbol: "weETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_SWISE,
                addr: 0x48C3399719B582dD63eB5AADf12A40B4C3f52FA2,
                symbol: "SWISE",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_ezETH,
                addr: 0xbf5495Efe5DB9ce00f80364C8B423567e58d2110,
                symbol: "ezETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_rsETH,
                addr: 0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7,
                symbol: "rsETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_frxETH,
                addr: 0x5E8422345238F34275888049021821E8E08CAa1f,
                symbol: "frxETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PENDLE,
                addr: 0x808507121B80c02388fAd14726482e061B8da827,
                symbol: "PENDLE",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cbETH,
                addr: 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704,
                symbol: "cbETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_rswETH,
                addr: 0xFAe103DC9cf190eD75350761e95403b7b8aFa6c0,
                symbol: "rswETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_USDe,
                addr: 0x4c9EDD5852cd905f086C759E8383e09bff1E68B3,
                symbol: "USDe",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_GHO,
                addr: 0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f,
                symbol: "GHO",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_pufETH,
                addr: 0xD9A442856C234a39a81a089C06451EBAa4306a72,
                symbol: "pufETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_wstETH,
                addr: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0,
                symbol: "wstETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_steakLRT,
                addr: 0xBEEF69Ac7870777598A04B2bd4771c71212E6aBc,
                symbol: "steakLRT",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_Re7LRT,
                addr: 0x84631c0d0081FDe56DeB72F6DE77abBbF6A9f93a,
                symbol: "Re7LRT",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_amphrETH,
                addr: 0x5fD13359Ba15A84B76f7F87568309040176167cd,
                symbol: "amphrETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_rstETH,
                addr: 0x7a4EffD87C2f3C55CA251080b1343b605f327E3a,
                symbol: "rstETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_pzETH,
                addr: 0x8c9532a60E0E7C6BbD2B2c1303F63aCE1c3E9811,
                symbol: "pzETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PT_rsETH_26SEP2024,
                addr: 0x7bAf258049cc8B9A78097723dc19a8b103D4098F,
                symbol: "PT_rsETH_26SEP2024",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_USDS,
                addr: 0xdC035D45d973E3EC169d2276DDab16f1e407384F,
                symbol: "USDS",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_SKY,
                addr: 0x56072C95FAA701256059aa122697B133aDEd9279,
                symbol: "SKY",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PT_sUSDe_26DEC2024,
                addr: 0xEe9085fC268F6727d5D4293dBABccF901ffDCC29,
                symbol: "PT_sUSDe_26DEC2024",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PT_eETH_26DEC2024,
                addr: 0x6ee2b5E19ECBa773a352E5B21415Dc419A700d1d,
                symbol: "PT_eETH_26DEC2024",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PT_ezETH_26DEC2024,
                addr: 0xf7906F274c174A52d444175729E3fa98f9bde285,
                symbol: "PT_ezETH_26DEC2024",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PT_eBTC_26DEC2024,
                addr: 0xB997B3418935A1Df0F914Ee901ec83927c1509A0,
                symbol: "PT_eBTC_26DEC2024",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PT_LBTC_27MAR2025,
                addr: 0xEc5a52C685CC3Ad79a6a347aBACe330d69e0b1eD,
                symbol: "PT_LBTC_27MAR2025",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PT_corn_solvBTC_BBN_26DEC2024,
                addr: 0x23e479ddcda990E8523494895759bD98cD2fDBF6,
                symbol: "PT_corn_solvBTC_BBN_26DEC2024",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PT_corn_pumpBTC_26DEC2024,
                addr: 0xa76f0C6e5f286bFF151b891d2A0245077F1Ad74c,
                symbol: "PT_corn_pumpBTC_26DEC2024",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PT_cornLBTC_26DEC2024,
                addr: 0x332A8ee60EdFf0a11CF3994b1b846BBC27d3DcD6,
                symbol: "PT_cornLBTC_26DEC2024",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_PT_corn_eBTC_27MAR2025,
                addr: 0x44A7876cA99460ef3218bf08b5f52E2dbE199566,
                symbol: "PT_corn_eBTC_27MAR2025",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sfrxETH,
                addr: 0xac3E018457B222d93114458476f3E3416Abbe38F,
                symbol: "sfrxETH",
                tokenType: TokenType.WRAPPED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN__3Crv,
                addr: 0x6c3F90f043a72FA612cbac8115EE7e52BDe6E490,
                symbol: "3Crv",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvFRAX,
                addr: 0x3175Df0976dFA876431C2E9eE6Bc45b65d3473CC,
                symbol: "crvFRAX",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_steCRV,
                addr: 0x06325440D014e39736583c165C2963BA99fAf14E,
                symbol: "steCRV",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvPlain3andSUSD,
                addr: 0xC25a3A3b969415c80451098fa907EC722572917F,
                symbol: "crvPlain3andSUSD",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvCRVETH,
                addr: 0xEd4064f376cB8d68F770FB1Ff088a3d0F3FF5c4d,
                symbol: "crvCRVETH",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvCVXETH,
                addr: 0x3A283D9c08E8b55966afb64C515f5143cf907611,
                symbol: "crvCVXETH",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvUSDTWBTCWETH,
                addr: 0xf5f5B97624542D72A9E06f04804Bf81baA15e2B4,
                symbol: "crvUSDTWBTCWETH",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_LDOETH,
                addr: 0xb79565c01b7Ae53618d9B847b9443aAf4f9011e7,
                symbol: "LDOETH",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvUSDUSDC,
                addr: 0x4DEcE678ceceb27446b35C672dC7d61F30bAD69E,
                symbol: "crvUSDUSDC",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvUSDUSDT,
                addr: 0x390f3595bCa2Df7d23783dFd126427CCeb997BF4,
                symbol: "crvUSDUSDT",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvUsUSDe,
                addr: 0x57064F49Ad7123C92560882a45518374ad982e85,
                symbol: "crvUsUSDe",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_scrvUsUSDe,
                addr: 0xd29f8980852c2c76fC3f6E96a7Aa06E0BedCC1B1,
                symbol: "scrvUsUSDe",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvUSDFRAX,
                addr: 0x0CD6f267b2086bea681E922E19D40512511BE538,
                symbol: "crvUSDFRAX",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvUSDETHCRV,
                addr: 0x4eBdF703948ddCEA3B11f675B4D1Fba9d2414A14,
                symbol: "crvUSDETHCRV",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_rETH_f,
                addr: 0x6c38cE8984a890F5e46e6dF6117C26b3F1EcfC9C,
                symbol: "rETH_f",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_DOLAFRAXBP3CRV_f,
                addr: 0xE57180685E3348589E9521aa53Af0BCD497E884d,
                symbol: "DOLAFRAXBP3CRV_f",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_crvUSDDOLA_f,
                addr: 0x8272E1A3dBef607C04AA6e5BD3a1A134c8ac063B,
                symbol: "crvUSDDOLA_f",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_USDeUSDC,
                addr: 0x02950460E2b9529D0E00284A5fA2d7bDF3fA4d72,
                symbol: "USDeUSDC",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_FRAXUSDe,
                addr: 0x5dc1BF6f1e983C0b21EfB003c105133736fA0743,
                symbol: "FRAXUSDe",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_USDecrvUSD,
                addr: 0xF55B0f6F2Da5ffDDb104b58a60F2862745960442,
                symbol: "USDecrvUSD",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_FRAXsDAI,
                addr: 0xcE6431D21E3fb1036CE9973a3312368ED96F5CE7,
                symbol: "FRAXsDAI",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_DOLAsUSDe,
                addr: 0x744793B5110f6ca9cC7CDfe1CE16677c3Eb192ef,
                symbol: "DOLAsUSDe",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_USDeDAI,
                addr: 0xF36a4BA50C603204c3FC6d2dA8b78A7b69CBC67d,
                symbol: "USDeDAI",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_MtEthena,
                addr: 0x167478921b907422F8E88B43C4Af2B8BEa278d3A,
                symbol: "MtEthena",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_GHOUSDe,
                addr: 0x670a72e6D22b0956C0D2573288F82DCc5d6E3a61,
                symbol: "GHOUSDe",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_pufETHwstE,
                addr: 0xEEda34A377dD0ca676b9511EE1324974fA8d980D,
                symbol: "pufETHwstE",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_GHOcrvUSD,
                addr: 0x635EF0056A597D13863B73825CcA297236578595,
                symbol: "GHOcrvUSD",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_ezETHWETH,
                addr: 0x85dE3ADd465a219EE25E04d22c39aB027cF5C12E,
                symbol: "ezETHWETH",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_ezpzETH,
                addr: 0x8c65CeC3847ad99BdC02621bDBC89F2acE56934B,
                symbol: "ezpzETH",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_LBTCWBTC,
                addr: 0x2f3bC4c27A4437AeCA13dE0e37cdf1028f3706F0,
                symbol: "LBTCWBTC",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_eBTCWBTC,
                addr: 0x7704D01908afD31bf647d969c295BB45230cD2d6,
                symbol: "eBTCWBTC",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_TriBTC,
                addr: 0xabaf76590478F2fE0b396996f55F0b61101e9502,
                symbol: "TriBTC",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_FRAX3CRV,
                addr: 0xd632f22692FaC7611d2AA1C0D552930D43CAEd3B,
                symbol: "FRAX3CRV",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_LUSD3CRV,
                addr: 0xEd279fDD11cA84bEef15AF5D39BB4d4bEE23F0cA,
                symbol: "LUSD3CRV",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_gusd3CRV,
                addr: 0xD2967f45c4f384DEEa880F807Be904762a3DeA07,
                symbol: "gusd3CRV",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvx3Crv,
                addr: 0x30D9410ED1D5DA1F6C8391af5338C93ab8d4035C,
                symbol: "cvx3Crv",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxcrvFRAX,
                addr: 0x117A0bab81F25e60900787d98061cCFae023560c,
                symbol: "cvxcrvFRAX",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxsteCRV,
                addr: 0x9518c9063eB0262D791f38d8d6Eb0aca33c63ed0,
                symbol: "cvxsteCRV",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxFRAX3CRV,
                addr: 0xbE0F6478E0E4894CFb14f32855603A083A57c7dA,
                symbol: "cvxFRAX3CRV",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxLUSD3CRV,
                addr: 0xFB9B2f06FDb404Fd3E2278E9A9edc8f252F273d0,
                symbol: "cvxLUSD3CRV",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxcrvPlain3andSUSD,
                addr: 0x11D200ef1409cecA8D6d23e6496550f707772F11,
                symbol: "cvxcrvPlain3andSUSD",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxgusd3CRV,
                addr: 0x15c2471ef46Fa721990730cfa526BcFb45574576,
                symbol: "cvxgusd3CRV",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxcrvCRVETH,
                addr: 0x0Fb8dcdD95e4C48D3dD0eFA4086512f6F8FD4565,
                symbol: "cvxcrvCRVETH",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxcrvCVXETH,
                addr: 0x0bC857f97c0554d1d0D602b56F2EEcE682016fBA,
                symbol: "cvxcrvCVXETH",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxcrvUSDTWBTCWETH,
                addr: 0xB77BA8B4b9d981269466eE95796A9Af57d4E82DB,
                symbol: "cvxcrvUSDTWBTCWETH",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxLDOETH,
                addr: 0x4eBE557ae39F87D2a014719777FD4cF4d01Dc8Ee,
                symbol: "cvxLDOETH",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxcrvUSDUSDC,
                addr: 0x75A2F59eC37c18962c53b0244D60B53f749DF25E,
                symbol: "cvxcrvUSDUSDC",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxcrvUSDUSDT,
                addr: 0x939e4C11E391a28CD81248163f3a2e595f12CE5E,
                symbol: "cvxcrvUSDUSDT",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxcrvUSDFRAX,
                addr: 0x01CcDe1dFb6c84e1Cc13a6Bf777aa2160ABd11BA,
                symbol: "cvxcrvUSDFRAX",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxcrvUSDETHCRV,
                addr: 0xa11a2c04D62b4A2324Fc857Fa14762Ad94751b4F,
                symbol: "cvxcrvUSDETHCRV",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cvxGHOcrvUSD,
                addr: 0x53f4474c06c699307514bd55FB1607005F46a889,
                symbol: "cvxGHOcrvUSD",
                tokenType: TokenType.CONVEX_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvx3Crv,
                addr: 0xbAc7a431146aeAf3F57A16b9954f332Fd292F270,
                symbol: "stkcvx3Crv",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxcrvFRAX,
                addr: 0x276187f24D41745513cbE2Bd5dFC33a4d8CDc9ed,
                symbol: "stkcvxcrvFRAX",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxsteCRV,
                addr: 0xe15B7D80a51e1fe54aC355CaBE848Efce5289BDB,
                symbol: "stkcvxsteCRV",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxFRAX3CRV,
                addr: 0xaF314b088B53835d5cF4e4CB81beABa5934a61fe,
                symbol: "stkcvxFRAX3CRV",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxLUSD3CRV,
                addr: 0x0A1D4A25d0390899b90bCD22E1Ef155003EA76d7,
                symbol: "stkcvxLUSD3CRV",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxcrvPlain3andSUSD,
                addr: 0x7e1992A7F28dAA5f6a2d34e2cd40f962f37B172C,
                symbol: "stkcvxcrvPlain3andSUSD",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxgusd3CRV,
                addr: 0x34fB99abBAFb4e87e256960D572664c6ADc301B8,
                symbol: "stkcvxgusd3CRV",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxcrvCRVETH,
                addr: 0xfC4b109D46e12170DF31AF8ba39403fAC2b8c0cf,
                symbol: "stkcvxcrvCRVETH",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxcrvCVXETH,
                addr: 0x948bEd0211076b05d22e98929217d0f04D068C5c,
                symbol: "stkcvxcrvCVXETH",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxcrvUSDTWBTCWETH,
                addr: 0xEE3EE8373384BBfea3227E527C1B9b4e7821273E,
                symbol: "stkcvxcrvUSDTWBTCWETH",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxLDOETH,
                addr: 0x2Fd6bD5b81c1060039D619E76e4e1f924B173006,
                symbol: "stkcvxLDOETH",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxcrvUSDUSDC,
                addr: 0xDb4217B9C8DB788Aa3871d45B4BE6ac5D1FF8C49,
                symbol: "stkcvxcrvUSDUSDC",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxcrvUSDUSDT,
                addr: 0x5C5e5117E26374870c80a5FA04c3f75a821440D6,
                symbol: "stkcvxcrvUSDUSDT",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxcrvUSDFRAX,
                addr: 0x7376AD488AB2bd8dF7665d619A4148f0E5094813,
                symbol: "stkcvxcrvUSDFRAX",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxcrvUSDETHCRV,
                addr: 0x0Bf1626d4925F8A872801968be11c052862AC2D3,
                symbol: "stkcvxcrvUSDETHCRV",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkcvxGHOcrvUSD,
                addr: 0xa19Da509625f0e36050eA2906E991A99B29D3221,
                symbol: "stkcvxGHOcrvUSD",
                tokenType: TokenType.CONVEX_STAKED_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_yvDAI,
                addr: 0xdA816459F1AB5631232FE5e97a05BBBb94970c95,
                symbol: "yvDAI",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_yvUSDC,
                addr: 0xa354F35829Ae975e850e23e9615b11Da1B3dC4DE,
                symbol: "yvUSDC",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_yvWETH,
                addr: 0xa258C4606Ca8206D8aA700cE2143D7db854D168c,
                symbol: "yvWETH",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_yvWBTC,
                addr: 0xA696a63cc78DfFa1a63E9E50587C197387FF6C7E,
                symbol: "yvWBTC",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_yvUSDT,
                addr: 0x3B27F92C0e212C671EA351827EDF93DB27cc0c65,
                symbol: "yvUSDT",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_yvCurve_stETH,
                addr: 0xdCD90C7f6324cfa40d7169ef80b12031770B4325,
                symbol: "yvCurve_stETH",
                tokenType: TokenType.YEARN_ON_CURVE_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_yvCurve_FRAX,
                addr: 0xB4AdA607B9d6b2c9Ee07A275e9616B84AC560139,
                symbol: "yvCurve_FRAX",
                tokenType: TokenType.YEARN_ON_CURVE_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN__50WETH_50AURA,
                addr: 0xCfCA23cA9CA720B6E98E3Eb9B6aa0fFC4a5C08B9,
                symbol: "50WETH_50AURA",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_B_80BAL_20WETH,
                addr: 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56,
                symbol: "B_80BAL_20WETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_USDC_DAI_USDT,
                addr: 0x79c58f70905F734641735BC61e45c19dD9Ad60bC,
                symbol: "USDC_DAI_USDT",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_B_rETH_STABLE,
                addr: 0x1E19CF2D73a72Ef1332C882F20534B6519Be0276,
                symbol: "B_rETH_STABLE",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_weETH_rETH,
                addr: 0x05ff47AFADa98a98982113758878F9A8B9FddA0a,
                symbol: "weETH_rETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_osETH_wETH_BPT,
                addr: 0xDACf5Fa19b1f720111609043ac67A9818262850c,
                symbol: "osETH_wETH_BPT",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_ezETH_WETH_BPT,
                addr: 0x596192bB6e41802428Ac943D2f1476C1Af25CC0E,
                symbol: "ezETH_WETH_BPT",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sUSDe_USDC_BPT,
                addr: 0xb819feeF8F0fcDC268AfE14162983A69f6BF179E,
                symbol: "sUSDe_USDC_BPT",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_trenSTETH,
                addr: 0x4216d5900a6109bba48418b5e2AB6cc4e61Cf477,
                symbol: "trenSTETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_weETH_ezETH_rswETH,
                addr: 0x848a5564158d84b8A8fb68ab5D004Fae11619A54,
                symbol: "weETH_ezETH_rswETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_GHO_USDT_USDC,
                addr: 0x8353157092ED8Be69a9DF8F95af097bbF33Cb2aF,
                symbol: "GHO_USDT_USDC",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_rsETH_WETH,
                addr: 0x58AAdFB1Afac0ad7fca1148f3cdE6aEDF5236B6D,
                symbol: "rsETH_WETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_aDAI,
                addr: 0x028171bCA77440897B824Ca71D1c56caC55b68A3,
                symbol: "aDAI",
                tokenType: TokenType.AAVE_V2_A_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_aUSDC,
                addr: 0xBcca60bB61934080951369a648Fb03DF4F96263C,
                symbol: "aUSDC",
                tokenType: TokenType.AAVE_V2_A_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_aUSDT,
                addr: 0x3Ed3B47Dd13EC9a98b44e6204A523E766B225811,
                symbol: "aUSDT",
                tokenType: TokenType.AAVE_V2_A_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_aWETH,
                addr: 0x030bA81f1c18d280636F32af80b9AAd02Cf0854e,
                symbol: "aWETH",
                tokenType: TokenType.AAVE_V2_A_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cDAI,
                addr: 0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643,
                symbol: "cDAI",
                tokenType: TokenType.COMPOUND_V2_C_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cUSDC,
                addr: 0x39AA39c021dfbaE8faC545936693aC917d5E7563,
                symbol: "cUSDC",
                tokenType: TokenType.COMPOUND_V2_C_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cUSDT,
                addr: 0xf650C3d88D12dB855b8bf7D11Be6C55A4e07dCC9,
                symbol: "cUSDT",
                tokenType: TokenType.COMPOUND_V2_C_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cETH,
                addr: 0x4Ddc2D193948926D02f9B1fE9e1daa0718270ED5,
                symbol: "cETH",
                tokenType: TokenType.COMPOUND_V2_C_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_cLINK,
                addr: 0xFAce851a4921ce59e912d19329929CE6da6EB0c7,
                symbol: "cLINK",
                tokenType: TokenType.COMPOUND_V2_C_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_fUSDC,
                addr: 0x465a5a630482f3abD6d3b84B39B29b07214d19e5,
                symbol: "fUSDC",
                tokenType: TokenType.COMPOUND_V2_C_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sDAI,
                addr: 0x83F20F44975D03b1b09e64809B757c47f942BEeA,
                symbol: "sDAI",
                tokenType: TokenType.ERC4626_VAULT_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_YieldETH,
                addr: 0xb5b29320d2Dde5BA5BAFA1EbcD270052070483ec,
                symbol: "YieldETH",
                tokenType: TokenType.ERC4626_VAULT_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sUSDe,
                addr: 0x9D39A5DE30e57443BfF2A8307A4256c8797A3497,
                symbol: "sUSDe",
                tokenType: TokenType.ERC4626_VAULT_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sUSDS,
                addr: 0xa3931d71877C0E7a3148CB7Eb4463524FEc27fbD,
                symbol: "sUSDS",
                tokenType: TokenType.ERC4626_VAULT_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_scrvUSD,
                addr: 0x0655977FEb2f289A4aB78af67BAB0d17aAb84367,
                symbol: "scrvUSD",
                tokenType: TokenType.ERC4626_VAULT_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_auraB_rETH_STABLE,
                addr: 0x9497df26e5bD669Cb925eC68E730492b9300c482,
                symbol: "auraB_rETH_STABLE",
                tokenType: TokenType.AURA_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_auraosETH_wETH_BPT,
                addr: 0x7d7a8889F4277234335F86f18df3b7c0AC5F6aed,
                symbol: "auraosETH_wETH_BPT",
                tokenType: TokenType.AURA_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_auraweETH_rETH,
                addr: 0xb2912397566Dafc9cDee555a38e980661858a61a,
                symbol: "auraweETH_rETH",
                tokenType: TokenType.AURA_LP_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_auraB_rETH_STABLE_vault,
                addr: 0xDd1fE5AD401D4777cE89959b7fa587e569Bf125D,
                symbol: "auraB_rETH_STABLE_vault",
                tokenType: TokenType.AURA_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_auraosETH_wETH_BPT_vault,
                addr: 0x5F032f15B4e910252EDaDdB899f7201E89C8cD6b,
                symbol: "auraosETH_wETH_BPT_vault",
                tokenType: TokenType.AURA_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_auraweETH_rETH_vault,
                addr: 0x07A319A023859BbD49CC9C38ee891c3EA9283Cc5,
                symbol: "auraweETH_rETH_vault",
                tokenType: TokenType.AURA_STAKED_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_zpufETH,
                addr: 0xF5740711F088DF1D2fBDb8F62D4852960c139cbA,
                symbol: "zpufETH",
                tokenType: TokenType.ZIRCUIT_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_stkUSDS,
                addr: 0xcB5D10A57Aeb622b92784D53F730eE2210ab370E,
                symbol: "stkUSDS",
                tokenType: TokenType.STAKING_REWARDS_PHANTOM_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dDAI,
                addr: 0x6CFaF95457d7688022FC53e7AbE052ef8DFBbdBA,
                symbol: "dDAI",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dUSDC,
                addr: 0xc411dB5f5Eb3f7d552F9B8454B2D74097ccdE6E3,
                symbol: "dUSDC",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dWBTC,
                addr: 0xe753260F1955e8678DCeA8887759e07aa57E8c54,
                symbol: "dWBTC",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dWETH,
                addr: 0xF21fc650C1B34eb0FDE786D52d23dA99Db3D6278,
                symbol: "dWETH",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dwstETH,
                addr: 0x2158034dB06f06dcB9A786D2F1F8c38781bA779d,
                symbol: "dwstETH",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dFRAX,
                addr: 0x8A1112AFef7F4FC7c066a77AABBc01b3Fff31D47,
                symbol: "dFRAX",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dUSDCV3,
                addr: 0xda00000035fef4082F78dEF6A8903bee419FbF8E,
                symbol: "dUSDCV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dWBTCV3,
                addr: 0xda00010eDA646913F273E10E7A5d1F659242757d,
                symbol: "dWBTCV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dWETHV3,
                addr: 0xda0002859B2d05F66a753d8241fCDE8623f26F4f,
                symbol: "dWETHV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dUSDTV3,
                addr: 0x05A811275fE9b4DE503B3311F51edF6A856D936e,
                symbol: "dUSDTV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dGHOV3,
                addr: 0x4d56c9cBa373AD39dF69Eb18F076b7348000AE09,
                symbol: "dGHOV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dDAIV3,
                addr: 0xe7146F53dBcae9D6Fa3555FE502648deb0B2F823,
                symbol: "dDAIV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dcrvUSDV3,
                addr: 0x8EF73f036fEEC873D0B2fd20892215Df5B8Bdd72,
                symbol: "dcrvUSDV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_dDOLAV3,
                addr: 0x31426271449F60d37Cc5C9AEf7bD12aF3BdC7A94,
                symbol: "dDOLAV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sdUSDCV3,
                addr: 0x9ef444a6d7F4A5adcd68FD5329aA5240C90E14d2,
                symbol: "sdUSDCV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sdWBTCV3,
                addr: 0xA8cE662E45E825DAF178DA2c8d5Fae97696A788A,
                symbol: "sdWBTCV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sdWETHV3,
                addr: 0x0418fEB7d0B25C411EB77cD654305d29FcbFf685,
                symbol: "sdWETHV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sdUSDTV3,
                addr: 0x16adAb68bDEcE3089D4f1626Bb5AEDD0d02471aD,
                symbol: "sdUSDTV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sdGHOV3,
                addr: 0xE2037090f896A858E3168B978668F22026AC52e7,
                symbol: "sdGHOV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sdDAIV3,
                addr: 0xC853E4DA38d9Bd1d01675355b8c8f3BBC1451973,
                symbol: "sdDAIV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sdcrvUSDV3,
                addr: 0xfBCA378AeA93EADD6882299A3d74D8641Cc0C4BC,
                symbol: "sdcrvUSDV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_sdDOLAV3,
                addr: 0xb3289a45497027a2Aee88Acc89fB3dcB5C71001D,
                symbol: "sdDOLAV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[1].push(
            TokenData({
                id: TOKEN_GEAR,
                addr: 0xBa3335588D9403515223F109EdC4eB7269a9Ab5D,
                symbol: "GEAR",
                tokenType: TokenType.GEAR_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_AAVE,
                addr: 0xba5DdD1f9d7F570dc94a51479a000E3BCE967196,
                symbol: "AAVE",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_CRV,
                addr: 0x11cDb42B0EB46D95f990BeDD4695A6e3fA034978,
                symbol: "CRV",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_DAI,
                addr: 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1,
                symbol: "DAI",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_LINK,
                addr: 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4,
                symbol: "LINK",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_SNX,
                addr: 0xcBA56Cd8216FCBBF3fA6DF6137F3147cBcA37D60,
                symbol: "SNX",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_UNI,
                addr: 0xFa7F8980b0f1E64A2062791cc3b0871572f1F7f0,
                symbol: "UNI",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_USDC,
                addr: 0xaf88d065e77c8cC2239327C5EDb3A432268e5831,
                symbol: "USDC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_USDC_e,
                addr: 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8,
                symbol: "USDC_e",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_USDT,
                addr: 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9,
                symbol: "USDT",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_WBTC,
                addr: 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f,
                symbol: "WBTC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_WETH,
                addr: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1,
                symbol: "WETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_YFI,
                addr: 0x82e3A8F066a6989666b031d916c43672085b1582,
                symbol: "YFI",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_CVX,
                addr: 0xaAFcFD42c9954C6689ef1901e03db742520829c5,
                symbol: "CVX",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_FRAX,
                addr: 0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F,
                symbol: "FRAX",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_FXS,
                addr: 0x9d2F299715D94d8A7E6F5eaa8E654E8c74a988A7,
                symbol: "FXS",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_LDO,
                addr: 0x13Ad51ed4F1B7e9Dc168d8a00cB3f4dDD85EfA60,
                symbol: "LDO",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_LUSD,
                addr: 0x93b346b6BC2548dA6A1E7d98E9a421B42541425b,
                symbol: "LUSD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_sUSD,
                addr: 0xA970AF1a584579B618be4d69aD6F73459D112F95,
                symbol: "sUSD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_LQTY,
                addr: 0xfb9E5D956D889D91a82737B9bFCDaC1DCE3e1449,
                symbol: "LQTY",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_GMX,
                addr: 0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a,
                symbol: "GMX",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_ARB,
                addr: 0x912CE59144191C1204E64559FE8253a0e49E6548,
                symbol: "ARB",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_BAL,
                addr: 0x040d1EdC9569d4Bab2D15287Dc5A4F10F56a56B8,
                symbol: "BAL",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_crvUSD,
                addr: 0x498Bf2B1e120FeD3ad3D42EA2165E9b73f99C1e5,
                symbol: "crvUSD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_RPL,
                addr: 0xB766039cc6DB368759C1E56B79AFfE831d0Cc507,
                symbol: "RPL",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_rETH,
                addr: 0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8,
                symbol: "rETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_AURA,
                addr: 0x1509706a6c66CA549ff0cB464de88231DDBe213B,
                symbol: "AURA",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_weETH,
                addr: 0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe,
                symbol: "weETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_ezETH,
                addr: 0x2416092f143378750bb29b79eD961ab195CcEea5,
                symbol: "ezETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_rsETH,
                addr: 0x4186BFC76E2E237523CBC30FD220FE055156b41F,
                symbol: "rsETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_frxETH,
                addr: 0x178412e79c25968a32e89b11f63B33F733770c2A,
                symbol: "frxETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_PENDLE,
                addr: 0x0c880f6761F1af8d9Aa9C466984b80DAb9a8c9e8,
                symbol: "PENDLE",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_cbETH,
                addr: 0x1DEBd73E752bEaF79865Fd6446b0c970EaE7732f,
                symbol: "cbETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_USDe,
                addr: 0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34,
                symbol: "USDe",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_wstETH,
                addr: 0x5979D7b546E38E414F7E9822514be443A4800529,
                symbol: "wstETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_sfrxETH,
                addr: 0x95aB45875cFFdba1E5f451B950bC2E42c0053f39,
                symbol: "sfrxETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_crvUSDFRAX,
                addr: 0x2FE7AE43591E534C256A1594D326e5779E302Ff4,
                symbol: "crvUSDFRAX",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN__2CRV,
                addr: 0x7f90122BF0700F9E7e1F688fe926940E8839F353,
                symbol: "2CRV",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN__3c_crvUSD,
                addr: 0x82670f35306253222F8a165869B28c64739ac62e,
                symbol: "3c-crvUSD",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_crvUSDC,
                addr: 0xec090cf6DD891D2d014beA6edAda6e05E025D93d,
                symbol: "crvUSDC",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_crvUSDT,
                addr: 0x73aF1150F265419Ef8a5DB41908B700C32D49135,
                symbol: "crvUSDT",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_crvUSDC_e,
                addr: 0x3aDf984c937FA6846E5a24E0A68521Bdaf767cE1,
                symbol: "crvUSDC_e",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_USDEUSDC,
                addr: 0x1c34204FCFE5314Dcf53BE2671C02c35DB58B4e3,
                symbol: "USDEUSDC",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_cvxcrvUSDT,
                addr: 0xf74d4C9b0F49fb70D8Ff6706ddF39e3a16D61E67,
                symbol: "cvxcrvUSDT",
                tokenType: TokenType.CONVEX_L2_STAKED_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_rsETH_wETH_Arb,
                addr: 0x90e6CB5249f5e1572afBF8A96D8A1ca6aCFFd739,
                symbol: "rsETH_wETH_Arb",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_wstETH_WETH_BPT,
                addr: 0x9791d590788598535278552EEcD4b211bFc790CB,
                symbol: "wstETH_WETH_BPT",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_wstETH_rETH_sfrxETH,
                addr: 0x0c8972437a38b389ec83d1E666b69b8a4fcf8bfd,
                symbol: "wstETH_rETH_sfrxETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_wstETH_rETH_cbETH,
                addr: 0x4a2F6Ae7F3e5D715689530873ec35593Dc28951B,
                symbol: "wstETH_rETH_cbETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_cbETH_rETH_wstETH,
                addr: 0x2d6CeD12420a9AF5a83765a8c48Be2aFcD1A8FEb,
                symbol: "cbETH_rETH_wstETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_rETH_WETH_BPT_deprecated,
                addr: 0xadE4A71BB62bEc25154CFc7e6ff49A513B491E81,
                symbol: "rETH_WETH_BPT_deprecated",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_rETH_wETH_BPT,
                addr: 0xd0EC47c54cA5e20aaAe4616c25C825c7f48D4069,
                symbol: "rETH_wETH_BPT",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN__33AURA_33ARB_33BAL,
                addr: 0xbcaA6c053cab3Dd73a2E898d89A4f84a180ae1CA,
                symbol: "33AURA_33ARB_33BAL",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_ezETH_wstETH,
                addr: 0xB61371Ab661B1ACec81C699854D2f911070C059E,
                symbol: "ezETH_wstETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_aDAI,
                addr: 0x82E64f49Ed5EC1bC6e43DAD4FC8Af9bb3A2312EE,
                symbol: "aDAI",
                tokenType: TokenType.AAVE_V2_A_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_aUSDC,
                addr: 0x724dc807b04555b71ed48a6896b6F41593b8C637,
                symbol: "aUSDC",
                tokenType: TokenType.AAVE_V2_A_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_aUSDT,
                addr: 0x6ab707Aca953eDAeFBc4fD23bA73294241490620,
                symbol: "aUSDT",
                tokenType: TokenType.AAVE_V2_A_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_aWETH,
                addr: 0xe50fA9b3c56FfB159cB0FCA61F5c9D750e8128c8,
                symbol: "aWETH",
                tokenType: TokenType.AAVE_V2_A_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_aurawstETH_WETH_BPT,
                addr: 0xc99B6fD0486448F100891CA43C015fD6f09c8bD0,
                symbol: "aurawstETH_WETH_BPT",
                tokenType: TokenType.AURA_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_aurawstETH_rETH_sfrxETH,
                addr: 0x5db70B93942936c01e5a1A1D19ABc442A9C967e3,
                symbol: "aurawstETH_rETH_sfrxETH",
                tokenType: TokenType.AURA_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_auracbETH_rETH_wstETH,
                addr: 0x7A1b7f30a98d4C8BDB66AaDc6E13Be4AcdD4DE2C,
                symbol: "auracbETH_rETH_wstETH",
                tokenType: TokenType.AURA_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_aurarETH_wETH_BPT,
                addr: 0xE23B5EC0100d446E4086D03e3546D6ef6F6Bcf1c,
                symbol: "aurarETH_wETH_BPT",
                tokenType: TokenType.AURA_LP_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_aurawstETH_WETH_BPT_vault,
                addr: 0xa7BdaD177D474f946f3cDEB4bcea9d24Cf017471,
                symbol: "aurawstETH_WETH_BPT_vault",
                tokenType: TokenType.AURA_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_aurawstETH_rETH_sfrxETH_vault,
                addr: 0xa427B131059A503b5fC9C7e1a130585ca3b32e3d,
                symbol: "aurawstETH_rETH_sfrxETH_vault",
                tokenType: TokenType.AURA_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_auracbETH_rETH_wstETH_vault,
                addr: 0x8cA64Bd82AbFE138E195ce5Cb7268CA285D42245,
                symbol: "auracbETH_rETH_wstETH_vault",
                tokenType: TokenType.AURA_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_aurarETH_wETH_BPT_vault,
                addr: 0x129A44AC6ff0f965C907579F96F2eD682E52c84A,
                symbol: "aurarETH_wETH_BPT_vault",
                tokenType: TokenType.AURA_STAKED_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_dUSDCV3,
                addr: 0x890A69EF363C9c7BdD5E36eb95Ceb569F63ACbF6,
                symbol: "dUSDCV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_dUSDC_eV3,
                addr: 0xa76c604145D7394DEc36C49Af494C144Ff327861,
                symbol: "dUSDC_eV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_dWETHV3,
                addr: 0x04419d3509f13054f60d253E0c79491d9E683399,
                symbol: "dWETHV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_sdUSDCV3,
                addr: 0xD0181a36B0566a8645B7eECFf2148adE7Ecf2BE9,
                symbol: "sdUSDCV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_sdUSDC_eV3,
                addr: 0x608F9e2E8933Ce6b39A8CddBc34a1e3E8D21cE75,
                symbol: "sdUSDC_eV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_sdWETHV3,
                addr: 0xf3b7994e4dA53E04155057Fd61dc501599d57877,
                symbol: "sdWETHV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_sdWETHV3_OLD,
                addr: 0x6773fF780Dd38175247795545Ee37adD6ab6139a,
                symbol: "sdWETHV3_OLD",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[42161].push(
            TokenData({
                id: TOKEN_GEAR,
                addr: 0x2F26337576127efabEEc1f62BE79dB1bcA9148A4,
                symbol: "GEAR",
                tokenType: TokenType.GEAR_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_AAVE,
                addr: 0x76FB31fb4af56892A25e32cFC43De717950c9278,
                symbol: "AAVE",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_CRV,
                addr: 0x0994206dfE8De6Ec6920FF4D779B0d950605Fb53,
                symbol: "CRV",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_DAI,
                addr: 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1,
                symbol: "DAI",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_LINK,
                addr: 0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6,
                symbol: "LINK",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_SNX,
                addr: 0x8700dAec35aF8Ff88c16BdF0418774CB3D7599B4,
                symbol: "SNX",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_UNI,
                addr: 0x6fd9d7AD17242c41f7131d257212c54A0e816691,
                symbol: "UNI",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_USDC,
                addr: 0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85,
                symbol: "USDC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_USDC_e,
                addr: 0x7F5c764cBc14f9669B88837ca1490cCa17c31607,
                symbol: "USDC_e",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_USDT,
                addr: 0x94b008aA00579c1307B0EF2c499aD98a8ce58e58,
                symbol: "USDT",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_WBTC,
                addr: 0x68f180fcCe6836688e9084f035309E29Bf0A2095,
                symbol: "WBTC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_WETH,
                addr: 0x4200000000000000000000000000000000000006,
                symbol: "WETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_YFI,
                addr: 0x9046D36440290FfDE54FE0DD84Db8b1CfEE9107B,
                symbol: "YFI",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_WLD,
                addr: 0xdC6fF44d5d932Cbd77B52E5612Ba0529DC6226F1,
                symbol: "WLD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_OP,
                addr: 0x4200000000000000000000000000000000000042,
                symbol: "OP",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_FRAX,
                addr: 0x2E3D870790dC77A83DD1d18184Acc7439A53f475,
                symbol: "FRAX",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_FXS,
                addr: 0x67CCEA5bb16181E7b4109c9c2143c24a1c2205Be,
                symbol: "FXS",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_LDO,
                addr: 0xFdb794692724153d1488CcdBE0C56c252596735F,
                symbol: "LDO",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_LUSD,
                addr: 0xc40F949F8a4e094D1b49a23ea9241D289B7b2819,
                symbol: "LUSD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_sUSD,
                addr: 0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9,
                symbol: "sUSD",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_BAL,
                addr: 0xFE8B128bA8C78aabC59d4c64cEE7fF28e9379921,
                symbol: "BAL",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_RPL,
                addr: 0xC81D1F0EB955B0c020E5d5b264E1FF72c14d1401,
                symbol: "RPL",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_rETH,
                addr: 0x9Bcef72be871e61ED4fBbc7630889beE758eb81D,
                symbol: "rETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_AURA,
                addr: 0x1509706a6c66CA549ff0cB464de88231DDBe213B,
                symbol: "AURA",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_ezETH,
                addr: 0x2416092f143378750bb29b79eD961ab195CcEea5,
                symbol: "ezETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_frxETH,
                addr: 0x6806411765Af15Bddd26f8f544A34cC40cb9838B,
                symbol: "frxETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_PENDLE,
                addr: 0xBC7B1Ff1c6989f006a1185318eD4E7b5796e66E1,
                symbol: "PENDLE",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_cbETH,
                addr: 0xadDb6A0412DE1BA0F936DCaeb8Aaa24578dcF3B2,
                symbol: "cbETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_wstETH,
                addr: 0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb,
                symbol: "wstETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_sfrxETH,
                addr: 0x484c2D6e3cDd945a8B2DF735e079178C1036578c,
                symbol: "sfrxETH",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_wstETHCRV,
                addr: 0xEfDE221f306152971D8e9f181bFe998447975810,
                symbol: "wstETHCRV",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN__3CRV,
                addr: 0x15F52286C0FF1d7A7dDbC9E300dd66628D46D4e6,
                symbol: "3CRV",
                tokenType: TokenType.CURVE_LP_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_yvDAI,
                addr: 0x65343F414FFD6c97b0f6add33d16F6845Ac22BAc,
                symbol: "yvDAI",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_yvUSDC_e,
                addr: 0xaD17A225074191d5c8a37B50FdA1AE278a2EE6A2,
                symbol: "yvUSDC_e",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_yvWETH,
                addr: 0x5B977577Eb8a480f63e11FC615D6753adB8652Ae,
                symbol: "yvWETH",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_yvWBTC,
                addr: 0x7Edf16076e56FA4c111055fbA1fF5556b8757cFB,
                symbol: "yvWBTC",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_yvUSDT,
                addr: 0xFaee21D0f0Af88EE72BB6d68E54a90E6EC2616de,
                symbol: "yvUSDT",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_yvOP,
                addr: 0x7D2382b1f8Af621229d33464340541Db362B4907,
                symbol: "yvOP",
                tokenType: TokenType.YEARN_ON_NORMAL_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_BPT_rETH_ETH,
                addr: 0x4Fd63966879300caFafBB35D157dC5229278Ed23,
                symbol: "BPT_rETH_ETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_BPT_WSTETH_ETH,
                addr: 0x7B50775383d3D6f0215A8F290f2C9e2eEBBEceb2,
                symbol: "BPT_WSTETH_ETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_BPT_ROAD,
                addr: 0x39965c9dAb5448482Cf7e002F583c812Ceb53046,
                symbol: "BPT_ROAD",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_ECLP_wstETH_WETH,
                addr: 0x7Ca75bdEa9dEde97F8B13C6641B768650CB83782,
                symbol: "ECLP_wstETH_WETH",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_bpt_ethtri,
                addr: 0x5F8893506Ddc4C271837187d14A9C87964a074Dc,
                symbol: "bpt_ethtri",
                tokenType: TokenType.BALANCER_LP_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_auraBPT_rETH_ETH,
                addr: 0x094C6846Fb2801b4753182ADFac336AAE8030A46,
                symbol: "auraBPT_rETH_ETH",
                tokenType: TokenType.AURA_LP_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_auraBPT_WSTETH_ETH,
                addr: 0x4c7E79c921144eBf7eBdbf0D3156bf192cDBe5f5,
                symbol: "auraBPT_WSTETH_ETH",
                tokenType: TokenType.AURA_LP_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_auraBPT_rETH_ETH_vault,
                addr: 0x61ac9315a1Ae71633E95Fb35601B59180eC8d61d,
                symbol: "auraBPT_rETH_ETH_vault",
                tokenType: TokenType.AURA_STAKED_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_auraBPT_WSTETH_ETH_vault,
                addr: 0xe110b862E4D076596707892c0C5163BC183eb161,
                symbol: "auraBPT_WSTETH_ETH_vault",
                tokenType: TokenType.AURA_STAKED_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_dUSDCV3,
                addr: 0xa210BB193Ca352Fa81fBd0e81Cb800580b0762eE,
                symbol: "dUSDCV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_dUSDC_eV3,
                addr: 0x5520dAa93A187f4Ec67344e6D2C4FC9B080B6A35,
                symbol: "dUSDC_eV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_dWETHV3,
                addr: 0x42dB77B3103c71059F4b997d6441cFB299FD0d94,
                symbol: "dWETHV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_sdUSDCV3,
                addr: 0x3ee44B2D6AD1CDF8f3Ce26Fc65f3945716Bb1492,
                symbol: "sdUSDCV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );
        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_sdUSDC_eV3,
                addr: 0x73302b63Ad4a16C498f26dB89cb27F37a72E4E04,
                symbol: "sdUSDC_eV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_sdWETHV3,
                addr: 0x704c4C9F0d29257E5b0E526b20b48EfFC8f758b2,
                symbol: "sdWETHV3",
                tokenType: TokenType.DIESEL_LP_TOKEN
            })
        );

        tokenDataByNetwork[10].push(
            TokenData({
                id: TOKEN_GEAR,
                addr: 0x39E6C2E1757ae4354087266E2C3EA9aC4257C1eb,
                symbol: "GEAR",
                tokenType: TokenType.GEAR_TOKEN
            })
        );

        tokenDataByNetwork[8453].push(
            TokenData({
                id: TOKEN_USDC,
                addr: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913,
                symbol: "USDC",
                tokenType: TokenType.NORMAL_TOKEN
            })
        );
    }

    function getTokenData(uint256 chainId) external view returns (TokenData[] memory) {
        return tokenDataByNetwork[chainId];
    }
}
