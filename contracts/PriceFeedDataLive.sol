// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

import {Tokens} from "./Tokens.sol";
import {Contracts} from "./SupportedContracts.sol";

import {TokensLib} from "./TokensLib.sol";

struct ChainlinkPriceFeedData {
    Tokens token;
    address priceFeed;
    uint32 stalenessPeriod;
}

struct CurvePriceFeedData {
    Tokens lpToken;
    Tokens[] assets;
    Contracts pool;
}

struct CrvUsdPriceFeedData {
    Tokens token;
    Tokens underlying;
    Contracts pool;
}

struct TheSamePriceFeedData {
    Tokens token;
    Tokens tokenHasSamePriceFeed;
}

struct SingeTokenPriceFeedData {
    Tokens token;
}

struct CompositePriceFeedData {
    Tokens token;
    address targetToBaseFeed;
    uint32 targetStalenessPeriod;
    address baseToUSDFeed;
    uint32 baseStalenessPeriod;
}

struct BoundedPriceFeedData {
    Tokens token;
    address priceFeed;
    uint32 stalenessPeriod;
    uint256 upperBound;
}

struct GenericLPPriceFeedData {
    Tokens lpToken;
    Tokens underlying;
}

struct BalancerLPPriceFeedData {
    Tokens lpToken;
    Tokens[] assets;
}

struct RedStonePriceFeedData {
    Tokens token;
    string dataServiceId;
    bytes32 dataFeedId;
    address[10] signers;
    uint8 signersThreshold;
}

contract PriceFeedDataLive {
    mapping(uint256 => ChainlinkPriceFeedData[]) chainlinkPriceFeedsByNetwork;
    mapping(uint256 => SingeTokenPriceFeedData[]) zeroPriceFeedsByNetwork;
    mapping(uint256 => CurvePriceFeedData[]) curvePriceFeedsByNetwork;
    mapping(uint256 => CurvePriceFeedData[]) curveCryptoPriceFeedsByNetwork;
    mapping(uint256 => TheSamePriceFeedData[]) theSamePriceFeedsByNetwork;
    mapping(uint256 => SingeTokenPriceFeedData[]) yearnPriceFeedsByNetwork;
    mapping(uint256 => BoundedPriceFeedData[]) boundedPriceFeedsByNetwork;
    mapping(uint256 => CompositePriceFeedData[]) compositePriceFeedsByNetwork;
    mapping(uint256 => SingeTokenPriceFeedData) wstethPriceFeedByNetwork;
    mapping(uint256 => GenericLPPriceFeedData[]) wrappedAaveV2PriceFeedsByNetwork;
    mapping(uint256 => GenericLPPriceFeedData[]) compoundV2PriceFeedsByNetwork;
    mapping(uint256 => GenericLPPriceFeedData[]) erc4626PriceFeedsByNetwork;
    mapping(uint256 => CrvUsdPriceFeedData[]) crvUSDPriceFeedsByNetwork;
    mapping(uint256 => RedStonePriceFeedData[]) redStonePriceFeedsByNetwork;
    mapping(address => string) redstoneServiceIdByPriceFeed;
    mapping(uint256 => BalancerLPPriceFeedData[]) balancerStableLPPriceFeedsByNetwork;
    mapping(uint256 => BalancerLPPriceFeedData[]) balancerWeightedLPPriceFeedsByNetwork;

    constructor() {
        // ------------------------ 1INCH ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens._1INCH,
                priceFeed: 0xc929ad75B72593967DE83E7F7Cda0493458261D9,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens._1INCH,
                priceFeed: 0x4bC735Ef24bf286983024CAd5D03f0738865Aaef,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ AAVE ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.AAVE,
                priceFeed: 0x547a514d5e3769680Ce22B2361c10Ea13619e8a9,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.AAVE,
                priceFeed: 0xaD1d5344AaDE45F43E596773Bcc4c423EAbdD034,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ COMP ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.COMP,
                priceFeed: 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.COMP,
                priceFeed: 0xe7C53FFd03Eb6ceF7d208bC4C13446c76d1E5884,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ CRV ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.CRV,
                priceFeed: 0xCd627aA160A6fA45Eb793D19Ef54f5062F20f33f,
                stalenessPeriod: 87300
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.CRV,
                priceFeed: 0xaebDA2c976cfd1eE1977Eac079B4382acb849325,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ DAI ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.DAI,
                priceFeed: 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9,
                stalenessPeriod: 4500
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.DAI,
                priceFeed: 0xc5C8E77B397E531B8EC06BFb0048328B30E9eCfB,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.DAI,
                priceFeed: 0x8dBa75e83DA73cc766A7e5a0ee71F656BAb470d6,
                stalenessPeriod: 86520
            })
        );

        // ------------------------ DPI ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.DPI,
                priceFeed: 0xD2A593BF7594aCE1faD597adb697b5645d5edDB2,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ FEI ------------------------

        // ------------------------ GUSD ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.GUSD,
                priceFeed: 0xa89f5d2365ce98B3cD68012b6f503ab1416245Fc,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ LINK ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.LINK,
                priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c,
                stalenessPeriod: 4500
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.LINK,
                priceFeed: 0x86E53CF1B870786351Da77A57575e79CB55812CB,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.LINK,
                priceFeed: 0xCc232dcFAAE6354cE191Bd574108c1aD03f86450,
                stalenessPeriod: 1320
            })
        );

        // ------------------------ SNX ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.SNX,
                priceFeed: 0xDC3EA94CD0AC27d9A86C180091e7f78C683d3699,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.SNX,
                priceFeed: 0x054296f0D036b95531B4E14aFB578B80CFb41252,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.SNX,
                priceFeed: 0x2FCF37343e916eAEd1f1DdaaF84458a359b53877,
                stalenessPeriod: 1320
            })
        );

        // ------------------------ WLD ------------------------
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.WLD,
                priceFeed: 0x4e1C6B168DCFD7758bC2Ab9d2865f1895813D236,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ OP ------------------------
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.OP,
                priceFeed: 0x0D276FC14719f9292D5C1eA2198673d1f4269246,
                stalenessPeriod: 1320
            })
        );

        // ------------------------ UNI ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.UNI,
                priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e,
                stalenessPeriod: 4500
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.UNI,
                priceFeed: 0x9C917083fDb403ab5ADbEC26Ee294f6EcAda2720,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ USDC ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDC,
                priceFeed: 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6,
                stalenessPeriod: 87300
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDC,
                priceFeed: 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDC,
                priceFeed: 0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3,
                stalenessPeriod: 86520
            })
        );

        // ------------------------ USDT ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDT,
                priceFeed: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D,
                stalenessPeriod: 87300
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDT,
                priceFeed: 0x3f3f5dF88dC9F13eac63DF89EC16ef6e7E25DdE7,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDT,
                priceFeed: 0xECef79E109e997bCA29c1c0897ec9d7b03647F5E,
                stalenessPeriod: 86520
            })
        );

        // ------------------------ WBTC ------------------------
        compositePriceFeedsByNetwork[1].push(
            CompositePriceFeedData({
                token: Tokens.WBTC,
                targetToBaseFeed: 0xfdFD9C85aD200c506Cf9e21F1FD8dd01932FBB23,
                targetStalenessPeriod: 87300,
                baseToUSDFeed: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c,
                baseStalenessPeriod: 4500
            })
        );
        compositePriceFeedsByNetwork[42161].push(
            CompositePriceFeedData({
                token: Tokens.WBTC,
                targetToBaseFeed: 0x0017abAc5b6f291F9164e35B1234CA1D697f9CF4,
                targetStalenessPeriod: 86400,
                baseToUSDFeed: 0x6ce185860a4963106506C203335A2910413708e9,
                baseStalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.WBTC,
                priceFeed: 0x718A5788b89454aAE3A028AE9c111A29Be6c2a6F,
                stalenessPeriod: 1320
            })
        );

        // ------------------------ WETH ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.WETH,
                priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                stalenessPeriod: 4500
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.WETH,
                priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.WETH,
                priceFeed: 0x13e3Ee699D1909E989722E753853AE30b17e08c5,
                stalenessPeriod: 1320
            })
        );

        // ------------------------ YFI ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.YFI,
                priceFeed: 0xA027702dbb89fbd58938e4324ac03B58d812b0E1,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.YFI,
                priceFeed: 0x745Ab5b69E01E2BE1104Ca84937Bb71f96f5fB21,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ STETH ------------------------
        compositePriceFeedsByNetwork[1].push(
            CompositePriceFeedData({
                token: Tokens.STETH,
                targetToBaseFeed: 0x86392dC19c0b719886221c78AB11eb8Cf5c52812,
                targetStalenessPeriod: 87300,
                baseToUSDFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                baseStalenessPeriod: 4500
            })
        );

        // ------------------------ wstETH ------------------------
        wstethPriceFeedByNetwork[1] = SingeTokenPriceFeedData({token: Tokens.wstETH});
        compositePriceFeedsByNetwork[10].push(
            CompositePriceFeedData({
                token: Tokens.wstETH,
                targetToBaseFeed: 0x524299Ab0987a7c4B3c8022a35669DdcdC715a10,
                targetStalenessPeriod: 86520,
                baseToUSDFeed: 0x13e3Ee699D1909E989722E753853AE30b17e08c5,
                baseStalenessPeriod: 1320
            })
        );

        // ------------------------ CVX ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.CVX,
                priceFeed: 0xd962fC30A72A84cE50161031391756Bf2876Af5D,
                stalenessPeriod: 87300
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.CVX,
                priceFeed: 0x851175a919f36c8e30197c09a9A49dA932c2CC00,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ FRAX ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.FRAX,
                priceFeed: 0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD,
                stalenessPeriod: 4500
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.FRAX,
                priceFeed: 0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ LUSD ------------------------
        boundedPriceFeedsByNetwork[1].push(
            BoundedPriceFeedData({
                token: Tokens.LUSD,
                priceFeed: 0x3D7aE7E594f2f2091Ad8798313450130d0Aba3a0,
                stalenessPeriod: 86400,
                upperBound: 110000000
            })
        );
        boundedPriceFeedsByNetwork[42161].push(
            BoundedPriceFeedData({
                token: Tokens.LUSD,
                priceFeed: 0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF,
                stalenessPeriod: 86400,
                upperBound: 110000000
            })
        );

        // ------------------------ sUSD ------------------------
        compositePriceFeedsByNetwork[1].push(
            CompositePriceFeedData({
                token: Tokens.sUSD,
                targetToBaseFeed: 0x8e0b7e6062272B5eF4524250bFFF8e5Bd3497757,
                targetStalenessPeriod: 86400,
                baseToUSDFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                baseStalenessPeriod: 86400
            })
        );

        // ------------------------ FXS ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.FXS,
                priceFeed: 0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f,
                stalenessPeriod: 87300
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.FXS,
                priceFeed: 0x36a121448D74Fa81450c992A1a44B9b7377CD3a5,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ LDO ------------------------
        compositePriceFeedsByNetwork[1].push(
            CompositePriceFeedData({
                token: Tokens.LDO,
                targetToBaseFeed: 0x4e844125952D32AcdF339BE976c98E22F6F318dB,
                targetStalenessPeriod: 87300,
                baseToUSDFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                baseStalenessPeriod: 4500
            })
        );
        zeroPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.LDO}));

        // ------------------------ LQTY ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.LQTY}));
        zeroPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.LQTY}));
        zeroPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.LQTY}));

        // ------------------------ OHM ------------------------
        compositePriceFeedsByNetwork[1].push(
            CompositePriceFeedData({
                token: Tokens.OHM,
                targetToBaseFeed: 0x9a72298ae3886221820B1c878d12D872087D3a23,
                targetStalenessPeriod: 86400,
                baseToUSDFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                baseStalenessPeriod: 86400
            })
        );
        zeroPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.OHM}));

        // ------------------------ MIM ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.MIM,
                priceFeed: 0x7A364e8770418566e3eb2001A96116E6138Eb32F,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ SPELL ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.SPELL,
                priceFeed: 0x8c110B94C5f1d347fAcF5E1E938AB2db60E3c9a8,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.SPELL,
                priceFeed: 0x383b3624478124697BEF675F07cA37570b73992f,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ GMX ------------------------
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.GMX,
                priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ ARB ------------------------
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.ARB,
                priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ SHIB ------------------------
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.SHIB,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "SHIB",
                signers: [
                    0x8BB8F32Df04c8b654987DAaeD53D6B6091e3B774,
                    0xdEB22f54738d54976C4c0fe5ce6d408E40d88499,
                    0x51Ce04Be4b3E32572C4Ec9135221d0691Ba7d202,
                    0xDD682daEC5A90dD295d14DA4b0bec9281017b5bE,
                    0x9c5AE89C4Af6aA32cE58588DBaF90d18a855B6de,
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0)
                ],
                signersThreshold: 5
            })
        );

        // ------------------------ RDNT ------------------------
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.RDNT,
                priceFeed: 0x20d0Fcab0ECFD078B036b6CAf1FaC69A6453b352,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ BAL ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.BAL,
                priceFeed: 0xdF2917806E30300537aEB49A7663062F4d1F2b5F,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.BAL,
                priceFeed: 0xBE5eA816870D11239c543F84b71439511D70B94f,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ rETH ------------------------
        compositePriceFeedsByNetwork[1].push(
            CompositePriceFeedData({
                token: Tokens.rETH,
                targetToBaseFeed: 0x536218f9E9Eb48863970252233c8F271f554C2d0,
                targetStalenessPeriod: 86400,
                baseToUSDFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                baseStalenessPeriod: 86400
            })
        );
        compositePriceFeedsByNetwork[10].push(
            CompositePriceFeedData({
                token: Tokens.rETH,
                targetToBaseFeed: 0xb429DE60943a8e6DeD356dca2F93Cd31201D9ed0,
                targetStalenessPeriod: 86520,
                baseToUSDFeed: 0x13e3Ee699D1909E989722E753853AE30b17e08c5,
                baseStalenessPeriod: 1320
            })
        );

        // ------------------------ AURA ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.AURA}));
        zeroPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.AURA}));
        zeroPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.AURA}));

        // ------------------------ yvDAI ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvDAI}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvDAI}));
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.yvDAI}));

        // ------------------------ yvUSDC ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvUSDC}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvUSDC}));
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.yvUSDC}));

        // ------------------------ yvUSDT ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvUSDT}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvUSDT}));
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.yvUSDT}));

        // ------------------------ yvWETH ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvWETH}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvWETH}));
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.yvWETH}));

        // ------------------------ yvWBTC ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvWBTC}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvWBTC}));
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.yvWBTC}));

        // ------------------------ yvOP ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvOP}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvOP}));
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.yvOP}));

        // ------------------------ 3Crv ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens._3Crv,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens._3Crv,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens._3Crv,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL
            })
        );

        // ------------------------ crvFRAX ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvFRAX,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvFRAX,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvFRAX,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL
            })
        );

        // ------------------------ steCRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.steCRV,
                assets: TokensLib.arrayOf(Tokens.STETH, Tokens.WETH),
                pool: Contracts.CURVE_STETH_GATEWAY
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.steCRV,
                assets: TokensLib.arrayOf(Tokens.STETH, Tokens.WETH),
                pool: Contracts.CURVE_STETH_GATEWAY
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.steCRV,
                assets: TokensLib.arrayOf(Tokens.STETH, Tokens.WETH),
                pool: Contracts.CURVE_STETH_GATEWAY
            })
        );

        // ------------------------ FRAX3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAX3CRV,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_FRAX_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAX3CRV,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_FRAX_POOL
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAX3CRV,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_FRAX_POOL
            })
        );

        // ------------------------ LUSD3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.LUSD3CRV,
                assets: TokensLib.arrayOf(Tokens.LUSD, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_LUSD_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.LUSD3CRV,
                assets: TokensLib.arrayOf(Tokens.LUSD, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_LUSD_POOL
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.LUSD3CRV,
                assets: TokensLib.arrayOf(Tokens.LUSD, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_LUSD_POOL
            })
        );

        // ------------------------ crvPlain3andSUSD ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvPlain3andSUSD,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT, Tokens.sUSD),
                pool: Contracts.CURVE_SUSD_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvPlain3andSUSD,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT, Tokens.sUSD),
                pool: Contracts.CURVE_SUSD_POOL
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvPlain3andSUSD,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT, Tokens.sUSD),
                pool: Contracts.CURVE_SUSD_POOL
            })
        );

        // ------------------------ gusd3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.gusd3CRV,
                assets: TokensLib.arrayOf(Tokens.GUSD, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_GUSD_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.gusd3CRV,
                assets: TokensLib.arrayOf(Tokens.GUSD, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_GUSD_POOL
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.gusd3CRV,
                assets: TokensLib.arrayOf(Tokens.GUSD, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_GUSD_POOL
            })
        );

        // ------------------------ MIM_3LP3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.MIM_3LP3CRV,
                assets: TokensLib.arrayOf(Tokens.MIM, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_MIM_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.MIM_3LP3CRV,
                assets: TokensLib.arrayOf(Tokens.MIM, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_MIM_POOL
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.MIM_3LP3CRV,
                assets: TokensLib.arrayOf(Tokens.MIM, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_MIM_POOL
            })
        );

        // ------------------------ OHMFRAXBP ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.OHMFRAXBP,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.crvFRAX),
                pool: Contracts.CURVE_OHMFRAXBP_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.OHMFRAXBP,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.crvFRAX),
                pool: Contracts.CURVE_OHMFRAXBP_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.OHMFRAXBP,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.crvFRAX),
                pool: Contracts.CURVE_OHMFRAXBP_POOL
            })
        );

        // ------------------------ crvCRVETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCRVETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_CRVETH_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCRVETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_CRVETH_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCRVETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_CRVETH_POOL
            })
        );

        // ------------------------ crvCVXETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCVXETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CVX),
                pool: Contracts.CURVE_CVXETH_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCVXETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CVX),
                pool: Contracts.CURVE_CVXETH_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCVXETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CVX),
                pool: Contracts.CURVE_CVXETH_POOL
            })
        );

        // ------------------------ crvUSDTWBTCWETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(Tokens.USDT, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(Tokens.USDT, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(Tokens.USDT, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL
            })
        );

        // ------------------------ LDOETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.LDOETH,
                assets: TokensLib.arrayOf(Tokens.LDO, Tokens.WETH),
                pool: Contracts.CURVE_LDOETH_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.LDOETH,
                assets: TokensLib.arrayOf(Tokens.LDO, Tokens.WETH),
                pool: Contracts.CURVE_LDOETH_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.LDOETH,
                assets: TokensLib.arrayOf(Tokens.LDO, Tokens.WETH),
                pool: Contracts.CURVE_LDOETH_POOL
            })
        );

        // ------------------------ crvUSD ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.crvUSD,
                priceFeed: 0xEEf0C605546958c1f899b6fB336C20671f9cD49F,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ crvUSDUSDC ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL
            })
        );

        // ------------------------ crvUSDUSDT ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL
            })
        );

        // ------------------------ crvUSDFRAX ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDFRAX,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDFRAX,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDFRAX,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL
            })
        );

        // ------------------------ crvUSDETHCRV ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDETHCRV,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDETHCRV,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDETHCRV,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL
            })
        );

        // ------------------------ rETH_f ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.rETH_f,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.rETH_f,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.rETH_f,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL
            })
        );

        // ------------------------ wstETHCRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.wstETHCRV,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.wstETH),
                pool: Contracts.CURVE_ETH_WSTETH_GATEWAY
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.wstETHCRV,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.wstETH),
                pool: Contracts.CURVE_ETH_WSTETH_GATEWAY
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.wstETHCRV,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.wstETH),
                pool: Contracts.CURVE_ETH_WSTETH_GATEWAY
            })
        );

        // ------------------------ yvCurve_stETH ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvCurve_stETH}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvCurve_stETH}));
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.yvCurve_stETH}));

        // ------------------------ yvCurve_FRAX ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvCurve_FRAX}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvCurve_FRAX}));
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.yvCurve_FRAX}));

        // ------------------------ cvx3Crv ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvx3Crv, tokenHasSamePriceFeed: Tokens._3Crv})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvx3Crv, tokenHasSamePriceFeed: Tokens._3Crv})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvx3Crv, tokenHasSamePriceFeed: Tokens._3Crv})
        );

        // ------------------------ cvxcrvFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvFRAX, tokenHasSamePriceFeed: Tokens.crvFRAX})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvFRAX, tokenHasSamePriceFeed: Tokens.crvFRAX})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvFRAX, tokenHasSamePriceFeed: Tokens.crvFRAX})
        );

        // ------------------------ cvxsteCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxsteCRV, tokenHasSamePriceFeed: Tokens.steCRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxsteCRV, tokenHasSamePriceFeed: Tokens.steCRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxsteCRV, tokenHasSamePriceFeed: Tokens.steCRV})
        );

        // ------------------------ cvxFRAX3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxFRAX3CRV, tokenHasSamePriceFeed: Tokens.FRAX3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxFRAX3CRV, tokenHasSamePriceFeed: Tokens.FRAX3CRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxFRAX3CRV, tokenHasSamePriceFeed: Tokens.FRAX3CRV})
        );

        // ------------------------ cvxLUSD3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxLUSD3CRV, tokenHasSamePriceFeed: Tokens.LUSD3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxLUSD3CRV, tokenHasSamePriceFeed: Tokens.LUSD3CRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxLUSD3CRV, tokenHasSamePriceFeed: Tokens.LUSD3CRV})
        );

        // ------------------------ cvxcrvPlain3andSUSD ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvPlain3andSUSD, tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvPlain3andSUSD, tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvPlain3andSUSD, tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD})
        );

        // ------------------------ cvxgusd3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxgusd3CRV, tokenHasSamePriceFeed: Tokens.gusd3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxgusd3CRV, tokenHasSamePriceFeed: Tokens.gusd3CRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxgusd3CRV, tokenHasSamePriceFeed: Tokens.gusd3CRV})
        );

        // ------------------------ cvxOHMFRAXBP ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxOHMFRAXBP, tokenHasSamePriceFeed: Tokens.OHMFRAXBP})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxOHMFRAXBP, tokenHasSamePriceFeed: Tokens.OHMFRAXBP})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxOHMFRAXBP, tokenHasSamePriceFeed: Tokens.OHMFRAXBP})
        );

        // ------------------------ cvxMIM_3LP3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxMIM_3LP3CRV, tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxMIM_3LP3CRV, tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxMIM_3LP3CRV, tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV})
        );

        // ------------------------ cvxcrvCRVETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvCRVETH, tokenHasSamePriceFeed: Tokens.crvCRVETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvCRVETH, tokenHasSamePriceFeed: Tokens.crvCRVETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvCRVETH, tokenHasSamePriceFeed: Tokens.crvCRVETH})
        );

        // ------------------------ cvxcrvCVXETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvCVXETH, tokenHasSamePriceFeed: Tokens.crvCVXETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvCVXETH, tokenHasSamePriceFeed: Tokens.crvCVXETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvCVXETH, tokenHasSamePriceFeed: Tokens.crvCVXETH})
        );

        // ------------------------ cvxcrvUSDTWBTCWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDTWBTCWETH, tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDTWBTCWETH, tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDTWBTCWETH, tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH})
        );

        // ------------------------ cvxLDOETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxLDOETH, tokenHasSamePriceFeed: Tokens.LDOETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxLDOETH, tokenHasSamePriceFeed: Tokens.LDOETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxLDOETH, tokenHasSamePriceFeed: Tokens.LDOETH})
        );

        // ------------------------ cvxcrvUSDUSDC ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDUSDC, tokenHasSamePriceFeed: Tokens.crvUSDUSDC})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDUSDC, tokenHasSamePriceFeed: Tokens.crvUSDUSDC})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDUSDC, tokenHasSamePriceFeed: Tokens.crvUSDUSDC})
        );

        // ------------------------ cvxcrvUSDUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDUSDT, tokenHasSamePriceFeed: Tokens.crvUSDUSDT})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDUSDT, tokenHasSamePriceFeed: Tokens.crvUSDUSDT})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDUSDT, tokenHasSamePriceFeed: Tokens.crvUSDUSDT})
        );

        // ------------------------ cvxcrvUSDFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDFRAX, tokenHasSamePriceFeed: Tokens.crvUSDFRAX})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDFRAX, tokenHasSamePriceFeed: Tokens.crvUSDFRAX})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDFRAX, tokenHasSamePriceFeed: Tokens.crvUSDFRAX})
        );

        // ------------------------ cvxcrvUSDETHCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDETHCRV, tokenHasSamePriceFeed: Tokens.crvUSDETHCRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDETHCRV, tokenHasSamePriceFeed: Tokens.crvUSDETHCRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDETHCRV, tokenHasSamePriceFeed: Tokens.crvUSDETHCRV})
        );

        // ------------------------ stkcvx3Crv ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvx3Crv, tokenHasSamePriceFeed: Tokens._3Crv})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvx3Crv, tokenHasSamePriceFeed: Tokens._3Crv})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvx3Crv, tokenHasSamePriceFeed: Tokens._3Crv})
        );

        // ------------------------ stkcvxcrvFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvFRAX, tokenHasSamePriceFeed: Tokens.crvFRAX})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvFRAX, tokenHasSamePriceFeed: Tokens.crvFRAX})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvFRAX, tokenHasSamePriceFeed: Tokens.crvFRAX})
        );

        // ------------------------ stkcvxsteCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxsteCRV, tokenHasSamePriceFeed: Tokens.steCRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxsteCRV, tokenHasSamePriceFeed: Tokens.steCRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxsteCRV, tokenHasSamePriceFeed: Tokens.steCRV})
        );

        // ------------------------ stkcvxFRAX3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxFRAX3CRV, tokenHasSamePriceFeed: Tokens.FRAX3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxFRAX3CRV, tokenHasSamePriceFeed: Tokens.FRAX3CRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxFRAX3CRV, tokenHasSamePriceFeed: Tokens.FRAX3CRV})
        );

        // ------------------------ stkcvxLUSD3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxLUSD3CRV, tokenHasSamePriceFeed: Tokens.LUSD3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxLUSD3CRV, tokenHasSamePriceFeed: Tokens.LUSD3CRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxLUSD3CRV, tokenHasSamePriceFeed: Tokens.LUSD3CRV})
        );

        // ------------------------ stkcvxcrvPlain3andSUSD ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvPlain3andSUSD, tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvPlain3andSUSD, tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvPlain3andSUSD, tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD})
        );

        // ------------------------ stkcvxgusd3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxgusd3CRV, tokenHasSamePriceFeed: Tokens.gusd3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxgusd3CRV, tokenHasSamePriceFeed: Tokens.gusd3CRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxgusd3CRV, tokenHasSamePriceFeed: Tokens.gusd3CRV})
        );

        // ------------------------ stkcvxOHMFRAXBP ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxOHMFRAXBP, tokenHasSamePriceFeed: Tokens.OHMFRAXBP})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxOHMFRAXBP, tokenHasSamePriceFeed: Tokens.OHMFRAXBP})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxOHMFRAXBP, tokenHasSamePriceFeed: Tokens.OHMFRAXBP})
        );

        // ------------------------ stkcvxMIM_3LP3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxMIM_3LP3CRV, tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxMIM_3LP3CRV, tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxMIM_3LP3CRV, tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV})
        );

        // ------------------------ stkcvxcrvCRVETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvCRVETH, tokenHasSamePriceFeed: Tokens.crvCRVETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvCRVETH, tokenHasSamePriceFeed: Tokens.crvCRVETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvCRVETH, tokenHasSamePriceFeed: Tokens.crvCRVETH})
        );

        // ------------------------ stkcvxcrvCVXETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvCVXETH, tokenHasSamePriceFeed: Tokens.crvCVXETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvCVXETH, tokenHasSamePriceFeed: Tokens.crvCVXETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvCVXETH, tokenHasSamePriceFeed: Tokens.crvCVXETH})
        );

        // ------------------------ stkcvxcrvUSDTWBTCWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDTWBTCWETH, tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDTWBTCWETH, tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDTWBTCWETH, tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH})
        );

        // ------------------------ stkcvxLDOETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxLDOETH, tokenHasSamePriceFeed: Tokens.LDOETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxLDOETH, tokenHasSamePriceFeed: Tokens.LDOETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxLDOETH, tokenHasSamePriceFeed: Tokens.LDOETH})
        );

        // ------------------------ stkcvxcrvUSDUSDC ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDUSDC, tokenHasSamePriceFeed: Tokens.crvUSDUSDC})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDUSDC, tokenHasSamePriceFeed: Tokens.crvUSDUSDC})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDUSDC, tokenHasSamePriceFeed: Tokens.crvUSDUSDC})
        );

        // ------------------------ stkcvxcrvUSDUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDUSDT, tokenHasSamePriceFeed: Tokens.crvUSDUSDT})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDUSDT, tokenHasSamePriceFeed: Tokens.crvUSDUSDT})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDUSDT, tokenHasSamePriceFeed: Tokens.crvUSDUSDT})
        );

        // ------------------------ stkcvxcrvUSDFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDFRAX, tokenHasSamePriceFeed: Tokens.crvUSDFRAX})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDFRAX, tokenHasSamePriceFeed: Tokens.crvUSDFRAX})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDFRAX, tokenHasSamePriceFeed: Tokens.crvUSDFRAX})
        );

        // ------------------------ stkcvxcrvUSDETHCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDETHCRV, tokenHasSamePriceFeed: Tokens.crvUSDETHCRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDETHCRV, tokenHasSamePriceFeed: Tokens.crvUSDETHCRV})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDETHCRV, tokenHasSamePriceFeed: Tokens.crvUSDETHCRV})
        );

        // ------------------------ 50OHM_50DAI ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({lpToken: Tokens._50OHM_50DAI, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.DAI)})
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({lpToken: Tokens._50OHM_50DAI, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.DAI)})
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({lpToken: Tokens._50OHM_50DAI, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.DAI)})
        );

        // ------------------------ 50OHM_50WETH ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({lpToken: Tokens._50OHM_50WETH, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.WETH)})
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({lpToken: Tokens._50OHM_50WETH, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.WETH)})
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({lpToken: Tokens._50OHM_50WETH, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.WETH)})
        );

        // ------------------------ OHM_wstETH ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({lpToken: Tokens.OHM_wstETH, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.wstETH)})
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({lpToken: Tokens.OHM_wstETH, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.wstETH)})
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({lpToken: Tokens.OHM_wstETH, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.wstETH)})
        );

        // ------------------------ USDC_DAI_USDT ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.USDC_DAI_USDT,
                assets: TokensLib.arrayOf(Tokens.USDC, Tokens.DAI, Tokens.USDT)
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.USDC_DAI_USDT,
                assets: TokensLib.arrayOf(Tokens.USDC, Tokens.DAI, Tokens.USDT)
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.USDC_DAI_USDT,
                assets: TokensLib.arrayOf(Tokens.USDC, Tokens.DAI, Tokens.USDT)
            })
        );

        // ------------------------ B_rETH_STABLE ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({lpToken: Tokens.B_rETH_STABLE, assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH)})
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({lpToken: Tokens.B_rETH_STABLE, assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH)})
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({lpToken: Tokens.B_rETH_STABLE, assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH)})
        );

        // ------------------------ BPT_rETH_ETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({lpToken: Tokens.BPT_rETH_ETH, assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH)})
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({lpToken: Tokens.BPT_rETH_ETH, assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH)})
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({lpToken: Tokens.BPT_rETH_ETH, assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH)})
        );

        // ------------------------ BPT_WSTETH_ETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH)
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH)
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH)
            })
        );

        // ------------------------ BPT_ROAD ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_ROAD,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.OP, Tokens.USDC)
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_ROAD,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.OP, Tokens.USDC)
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_ROAD,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.OP, Tokens.USDC)
            })
        );

        // ------------------------ dDAI ------------------------

        // ------------------------ dUSDC ------------------------

        // ------------------------ dWBTC ------------------------

        // ------------------------ dWETH ------------------------

        // ------------------------ dwstETH ------------------------

        // ------------------------ dFRAX ------------------------

        // ------------------------ dUSDCV3 ------------------------

        // ------------------------ dWBTCV3 ------------------------

        // ------------------------ dWETHV3 ------------------------

        // ------------------------ sdUSDCV3 ------------------------

        // ------------------------ sdWBTCV3 ------------------------

        // ------------------------ sdWETHV3 ------------------------

        // ------------------------ GEAR ------------------------

        // ------------------------ aDAI ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.aDAI, tokenHasSamePriceFeed: Tokens.DAI})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.aDAI, tokenHasSamePriceFeed: Tokens.DAI})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.aDAI, tokenHasSamePriceFeed: Tokens.DAI})
        );

        // ------------------------ aUSDC ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.aUSDC, tokenHasSamePriceFeed: Tokens.USDC})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.aUSDC, tokenHasSamePriceFeed: Tokens.USDC})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.aUSDC, tokenHasSamePriceFeed: Tokens.USDC})
        );

        // ------------------------ aUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.aUSDT, tokenHasSamePriceFeed: Tokens.USDT})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.aUSDT, tokenHasSamePriceFeed: Tokens.USDT})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.aUSDT, tokenHasSamePriceFeed: Tokens.USDT})
        );

        // ------------------------ aWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.aWETH, tokenHasSamePriceFeed: Tokens.WETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.aWETH, tokenHasSamePriceFeed: Tokens.WETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.aWETH, tokenHasSamePriceFeed: Tokens.WETH})
        );

        // ------------------------ waDAI ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waDAI, underlying: Tokens.aDAI})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waDAI, underlying: Tokens.aDAI})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.waDAI, underlying: Tokens.aDAI})
        );

        // ------------------------ waUSDC ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDC, underlying: Tokens.aUSDC})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDC, underlying: Tokens.aUSDC})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDC, underlying: Tokens.aUSDC})
        );

        // ------------------------ waUSDT ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDT, underlying: Tokens.aUSDT})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDT, underlying: Tokens.aUSDT})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDT, underlying: Tokens.aUSDT})
        );

        // ------------------------ waWETH ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waWETH, underlying: Tokens.aWETH})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waWETH, underlying: Tokens.aWETH})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.waWETH, underlying: Tokens.aWETH})
        );

        // ------------------------ cDAI ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.cDAI, underlying: Tokens.DAI}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cDAI, underlying: Tokens.DAI})
        );
        compoundV2PriceFeedsByNetwork[10].push(GenericLPPriceFeedData({lpToken: Tokens.cDAI, underlying: Tokens.DAI}));

        // ------------------------ cUSDC ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.cUSDC, underlying: Tokens.USDC}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDC, underlying: Tokens.USDC})
        );
        compoundV2PriceFeedsByNetwork[10].push(GenericLPPriceFeedData({lpToken: Tokens.cUSDC, underlying: Tokens.USDC}));

        // ------------------------ cUSDT ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.cUSDT, underlying: Tokens.USDT}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDT, underlying: Tokens.USDT})
        );
        compoundV2PriceFeedsByNetwork[10].push(GenericLPPriceFeedData({lpToken: Tokens.cUSDT, underlying: Tokens.USDT}));

        // ------------------------ cLINK ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.cLINK, underlying: Tokens.LINK}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cLINK, underlying: Tokens.LINK})
        );
        compoundV2PriceFeedsByNetwork[10].push(GenericLPPriceFeedData({lpToken: Tokens.cLINK, underlying: Tokens.LINK}));

        // ------------------------ cETH ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.cETH, underlying: Tokens.WETH}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cETH, underlying: Tokens.WETH})
        );
        compoundV2PriceFeedsByNetwork[10].push(GenericLPPriceFeedData({lpToken: Tokens.cETH, underlying: Tokens.WETH}));

        // ------------------------ fUSDC ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.fUSDC, underlying: Tokens.USDC}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.fUSDC, underlying: Tokens.USDC})
        );
        compoundV2PriceFeedsByNetwork[10].push(GenericLPPriceFeedData({lpToken: Tokens.fUSDC, underlying: Tokens.USDC}));

        // ------------------------ MKR ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.MKR,
                priceFeed: 0xec1D1B3b0443256cc3860e24a46F108e699484Aa,
                stalenessPeriod: 4500
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.MKR,
                priceFeed: 0xdE9f0894670c4EFcacF370426F10C3AD2Cdf147e,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ RPL ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.RPL,
                priceFeed: 0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.RPL,
                priceFeed: 0xF0b7159BbFc341Cc41E7Cb182216F62c6d40533D,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ APE ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.APE,
                priceFeed: 0xD10aBbC76679a20055E167BB80A24ac851b37056,
                stalenessPeriod: 87300
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.APE,
                priceFeed: 0x221912ce795669f628c51c69b7d0873eDA9C03bB,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ sDAI ------------------------
        erc4626PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.sDAI, underlying: Tokens.DAI}));
        erc4626PriceFeedsByNetwork[42161].push(GenericLPPriceFeedData({lpToken: Tokens.sDAI, underlying: Tokens.DAI}));
        erc4626PriceFeedsByNetwork[10].push(GenericLPPriceFeedData({lpToken: Tokens.sDAI, underlying: Tokens.DAI}));

        // ------------------------ YieldETH ------------------------
        erc4626PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.YieldETH, underlying: Tokens.WETH}));
        erc4626PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.YieldETH, underlying: Tokens.WETH})
        );
        erc4626PriceFeedsByNetwork[10].push(GenericLPPriceFeedData({lpToken: Tokens.YieldETH, underlying: Tokens.WETH}));

        // ------------------------ auraB_rETH_STABLE ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.auraB_rETH_STABLE, tokenHasSamePriceFeed: Tokens.B_rETH_STABLE})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.auraB_rETH_STABLE, tokenHasSamePriceFeed: Tokens.B_rETH_STABLE})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.auraB_rETH_STABLE, tokenHasSamePriceFeed: Tokens.B_rETH_STABLE})
        );

        // ------------------------ auraB_rETH_STABLE_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.auraB_rETH_STABLE_vault, tokenHasSamePriceFeed: Tokens.B_rETH_STABLE})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.auraB_rETH_STABLE_vault, tokenHasSamePriceFeed: Tokens.B_rETH_STABLE})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.auraB_rETH_STABLE_vault, tokenHasSamePriceFeed: Tokens.B_rETH_STABLE})
        );

        // ------------------------ auraBPT_rETH_ETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_rETH_ETH, tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_rETH_ETH, tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_rETH_ETH, tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH})
        );

        // ------------------------ auraBPT_rETH_ETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_rETH_ETH_vault, tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_rETH_ETH_vault, tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_rETH_ETH_vault, tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH})
        );

        // ------------------------ auraBPT_WSTETH_ETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_WSTETH_ETH, tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_WSTETH_ETH, tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_WSTETH_ETH, tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH})
        );

        // ------------------------ auraBPT_WSTETH_ETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_WSTETH_ETH_vault, tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_WSTETH_ETH_vault, tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.auraBPT_WSTETH_ETH_vault, tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH})
        );
    }

    function chainlinkPriceFeeds(uint256 index) external view returns (ChainlinkPriceFeedData memory) {
        return chainlinkPriceFeedsByNetwork[block.chainid][index];
    }
}
