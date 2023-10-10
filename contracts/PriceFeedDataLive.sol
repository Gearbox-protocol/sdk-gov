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
                stalenessPeriod: 86400
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
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.DAI,
                priceFeed: 0xc5C8E77B397E531B8EC06BFb0048328B30E9eCfB,
                stalenessPeriod: 86400
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
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.LINK,
                priceFeed: 0x86E53CF1B870786351Da77A57575e79CB55812CB,
                stalenessPeriod: 86400
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

        // ------------------------ UNI ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.UNI,
                priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e,
                stalenessPeriod: 86400
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
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDC,
                priceFeed: 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ USDT ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDT,
                priceFeed: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDT,
                priceFeed: 0x3f3f5dF88dC9F13eac63DF89EC16ef6e7E25DdE7,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ WBTC ------------------------
        compositePriceFeedsByNetwork[1].push(
            CompositePriceFeedData({
                token: Tokens.WBTC,
                targetToBaseFeed: 0xfdFD9C85aD200c506Cf9e21F1FD8dd01932FBB23,
                targetStalenessPeriod: 864000,
                baseToUSDFeed: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c,
                baseStalenessPeriod: 864000
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

        // ------------------------ WETH ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.WETH,
                priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                stalenessPeriod: 86400
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.WETH,
                priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612,
                stalenessPeriod: 86400
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
                targetStalenessPeriod: 86400,
                baseToUSDFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                baseStalenessPeriod: 86400
            })
        );

        // ------------------------ wstETH ------------------------
        wstethPriceFeedByNetwork[1] = SingeTokenPriceFeedData({token: Tokens.wstETH});

        // ------------------------ CVX ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.CVX,
                priceFeed: 0xd962fC30A72A84cE50161031391756Bf2876Af5D,
                stalenessPeriod: 86400
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
                stalenessPeriod: 86400
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
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.sUSD,
                priceFeed: 0xad35Bd71b9aFE6e4bDc266B345c198eaDEf9Ad94,
                stalenessPeriod: 86400
            })
        );

        // ------------------------ FXS ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.FXS,
                priceFeed: 0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f,
                stalenessPeriod: 86400
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
                targetStalenessPeriod: 86400,
                baseToUSDFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                baseStalenessPeriod: 86400
            })
        );
        zeroPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.LDO}));

        // ------------------------ LQTY ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.LQTY}));
        zeroPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.LQTY}));

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
                dataServiceId: "redstone-main-demo",
                dataFeedId: "SHIB",
                signers: [
                    0x0C39486f770B26F5527BBBf942726537986Cd7eb,
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0)
                ],
                signersThreshold: 1
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.SHIB,
                dataServiceId: "redstone-main-demo",
                dataFeedId: "SHIB",
                signers: [
                    0x0C39486f770B26F5527BBBf942726537986Cd7eb,
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0)
                ],
                signersThreshold: 1
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

        // ------------------------ AURA ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.AURA}));
        zeroPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.AURA}));

        // ------------------------ yvDAI ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvDAI}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvDAI}));

        // ------------------------ yvUSDC ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvUSDC}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvUSDC}));

        // ------------------------ yvWETH ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvWETH}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvWETH}));

        // ------------------------ yvWBTC ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvWBTC}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvWBTC}));

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

        // ------------------------ crvUSDFRAX ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDFRAX,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.FRAX),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDFRAX,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.FRAX),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL
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

        // ------------------------ yvCurve_stETH ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvCurve_stETH}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvCurve_stETH}));

        // ------------------------ yvCurve_FRAX ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvCurve_FRAX}));
        yearnPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: Tokens.yvCurve_FRAX}));

        // ------------------------ cvx3Crv ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvx3Crv, tokenHasSamePriceFeed: Tokens._3Crv})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvx3Crv, tokenHasSamePriceFeed: Tokens._3Crv})
        );

        // ------------------------ cvxcrvFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvFRAX, tokenHasSamePriceFeed: Tokens.crvFRAX})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvFRAX, tokenHasSamePriceFeed: Tokens.crvFRAX})
        );

        // ------------------------ cvxsteCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxsteCRV, tokenHasSamePriceFeed: Tokens.steCRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxsteCRV, tokenHasSamePriceFeed: Tokens.steCRV})
        );

        // ------------------------ cvxFRAX3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxFRAX3CRV, tokenHasSamePriceFeed: Tokens.FRAX3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxFRAX3CRV, tokenHasSamePriceFeed: Tokens.FRAX3CRV})
        );

        // ------------------------ cvxLUSD3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxLUSD3CRV, tokenHasSamePriceFeed: Tokens.LUSD3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxLUSD3CRV, tokenHasSamePriceFeed: Tokens.LUSD3CRV})
        );

        // ------------------------ cvxcrvPlain3andSUSD ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvPlain3andSUSD, tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvPlain3andSUSD, tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD})
        );

        // ------------------------ cvxgusd3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxgusd3CRV, tokenHasSamePriceFeed: Tokens.gusd3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxgusd3CRV, tokenHasSamePriceFeed: Tokens.gusd3CRV})
        );

        // ------------------------ cvxOHMFRAXBP ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxOHMFRAXBP, tokenHasSamePriceFeed: Tokens.OHMFRAXBP})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxOHMFRAXBP, tokenHasSamePriceFeed: Tokens.OHMFRAXBP})
        );

        // ------------------------ cvxMIM_3LP3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxMIM_3LP3CRV, tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxMIM_3LP3CRV, tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV})
        );

        // ------------------------ cvxcrvCRVETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvCRVETH, tokenHasSamePriceFeed: Tokens.crvCRVETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvCRVETH, tokenHasSamePriceFeed: Tokens.crvCRVETH})
        );

        // ------------------------ cvxcrvCVXETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvCVXETH, tokenHasSamePriceFeed: Tokens.crvCVXETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvCVXETH, tokenHasSamePriceFeed: Tokens.crvCVXETH})
        );

        // ------------------------ cvxcrvUSDTWBTCWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDTWBTCWETH, tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDTWBTCWETH, tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH})
        );

        // ------------------------ cvxLDOETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxLDOETH, tokenHasSamePriceFeed: Tokens.LDOETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxLDOETH, tokenHasSamePriceFeed: Tokens.LDOETH})
        );

        // ------------------------ cvxcrvUSDETHCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDETHCRV, tokenHasSamePriceFeed: Tokens.crvUSDETHCRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.cvxcrvUSDETHCRV, tokenHasSamePriceFeed: Tokens.crvUSDETHCRV})
        );

        // ------------------------ stkcvx3Crv ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvx3Crv, tokenHasSamePriceFeed: Tokens._3Crv})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvx3Crv, tokenHasSamePriceFeed: Tokens._3Crv})
        );

        // ------------------------ stkcvxcrvFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvFRAX, tokenHasSamePriceFeed: Tokens.crvFRAX})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvFRAX, tokenHasSamePriceFeed: Tokens.crvFRAX})
        );

        // ------------------------ stkcvxsteCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxsteCRV, tokenHasSamePriceFeed: Tokens.steCRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxsteCRV, tokenHasSamePriceFeed: Tokens.steCRV})
        );

        // ------------------------ stkcvxFRAX3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxFRAX3CRV, tokenHasSamePriceFeed: Tokens.FRAX3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxFRAX3CRV, tokenHasSamePriceFeed: Tokens.FRAX3CRV})
        );

        // ------------------------ stkcvxLUSD3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxLUSD3CRV, tokenHasSamePriceFeed: Tokens.LUSD3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxLUSD3CRV, tokenHasSamePriceFeed: Tokens.LUSD3CRV})
        );

        // ------------------------ stkcvxcrvPlain3andSUSD ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvPlain3andSUSD, tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvPlain3andSUSD, tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD})
        );

        // ------------------------ stkcvxgusd3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxgusd3CRV, tokenHasSamePriceFeed: Tokens.gusd3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxgusd3CRV, tokenHasSamePriceFeed: Tokens.gusd3CRV})
        );

        // ------------------------ stkcvxOHMFRAXBP ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxOHMFRAXBP, tokenHasSamePriceFeed: Tokens.OHMFRAXBP})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxOHMFRAXBP, tokenHasSamePriceFeed: Tokens.OHMFRAXBP})
        );

        // ------------------------ stkcvxMIM_3LP3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxMIM_3LP3CRV, tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxMIM_3LP3CRV, tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV})
        );

        // ------------------------ stkcvxcrvCRVETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvCRVETH, tokenHasSamePriceFeed: Tokens.crvCRVETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvCRVETH, tokenHasSamePriceFeed: Tokens.crvCRVETH})
        );

        // ------------------------ stkcvxcrvCVXETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvCVXETH, tokenHasSamePriceFeed: Tokens.crvCVXETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvCVXETH, tokenHasSamePriceFeed: Tokens.crvCVXETH})
        );

        // ------------------------ stkcvxcrvUSDTWBTCWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDTWBTCWETH, tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDTWBTCWETH, tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH})
        );

        // ------------------------ stkcvxLDOETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxLDOETH, tokenHasSamePriceFeed: Tokens.LDOETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxLDOETH, tokenHasSamePriceFeed: Tokens.LDOETH})
        );

        // ------------------------ stkcvxcrvUSDETHCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDETHCRV, tokenHasSamePriceFeed: Tokens.crvUSDETHCRV})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.stkcvxcrvUSDETHCRV, tokenHasSamePriceFeed: Tokens.crvUSDETHCRV})
        );

        // ------------------------ 50OHM_50DAI ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({lpToken: Tokens._50OHM_50DAI, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.DAI)})
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({lpToken: Tokens._50OHM_50DAI, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.DAI)})
        );

        // ------------------------ 50OHM_50WETH ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({lpToken: Tokens._50OHM_50WETH, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.WETH)})
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({lpToken: Tokens._50OHM_50WETH, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.WETH)})
        );

        // ------------------------ OHM_wstETH ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({lpToken: Tokens.OHM_wstETH, assets: TokensLib.arrayOf(Tokens.OHM, Tokens.wstETH)})
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
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

        // ------------------------ B_rETH_STABLE ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({lpToken: Tokens.B_rETH_STABLE, assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH)})
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({lpToken: Tokens.B_rETH_STABLE, assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH)})
        );

        // ------------------------ dDAI ------------------------

        // ------------------------ dUSDC ------------------------

        // ------------------------ dWBTC ------------------------

        // ------------------------ dWETH ------------------------

        // ------------------------ dwstETH ------------------------

        // ------------------------ dFRAX ------------------------

        // ------------------------ GEAR ------------------------

        // ------------------------ aDAI ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.aDAI, tokenHasSamePriceFeed: Tokens.DAI})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.aDAI, tokenHasSamePriceFeed: Tokens.DAI})
        );

        // ------------------------ aUSDC ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.aUSDC, tokenHasSamePriceFeed: Tokens.USDC})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.aUSDC, tokenHasSamePriceFeed: Tokens.USDC})
        );

        // ------------------------ aUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.aUSDT, tokenHasSamePriceFeed: Tokens.USDT})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.aUSDT, tokenHasSamePriceFeed: Tokens.USDT})
        );

        // ------------------------ aWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.aWETH, tokenHasSamePriceFeed: Tokens.WETH})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.aWETH, tokenHasSamePriceFeed: Tokens.WETH})
        );

        // ------------------------ waDAI ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waDAI, underlying: Tokens.aDAI})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waDAI, underlying: Tokens.aDAI})
        );

        // ------------------------ waUSDC ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDC, underlying: Tokens.aUSDC})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDC, underlying: Tokens.aUSDC})
        );

        // ------------------------ waUSDT ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDT, underlying: Tokens.aUSDT})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDT, underlying: Tokens.aUSDT})
        );

        // ------------------------ waWETH ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waWETH, underlying: Tokens.aWETH})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waWETH, underlying: Tokens.aWETH})
        );

        // ------------------------ cDAI ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.cDAI, underlying: Tokens.DAI}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cDAI, underlying: Tokens.DAI})
        );

        // ------------------------ cUSDC ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.cUSDC, underlying: Tokens.USDC}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDC, underlying: Tokens.USDC})
        );

        // ------------------------ cUSDT ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.cUSDT, underlying: Tokens.USDT}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDT, underlying: Tokens.USDT})
        );

        // ------------------------ cLINK ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.cLINK, underlying: Tokens.LINK}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cLINK, underlying: Tokens.LINK})
        );

        // ------------------------ cETH ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.cETH, underlying: Tokens.WETH}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cETH, underlying: Tokens.WETH})
        );

        // ------------------------ fUSDC ------------------------
        compoundV2PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.fUSDC, underlying: Tokens.USDC}));
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.fUSDC, underlying: Tokens.USDC})
        );

        // ------------------------ MKR ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.MKR,
                priceFeed: 0xec1D1B3b0443256cc3860e24a46F108e699484Aa,
                stalenessPeriod: 86400
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
                stalenessPeriod: 86400
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

        // ------------------------ YieldETH ------------------------
        erc4626PriceFeedsByNetwork[1].push(GenericLPPriceFeedData({lpToken: Tokens.YieldETH, underlying: Tokens.WETH}));
        erc4626PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.YieldETH, underlying: Tokens.WETH})
        );

        // ------------------------ auraB_rETH_STABLE ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.auraB_rETH_STABLE, tokenHasSamePriceFeed: Tokens.B_rETH_STABLE})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.auraB_rETH_STABLE, tokenHasSamePriceFeed: Tokens.B_rETH_STABLE})
        );

        // ------------------------ auraB_rETH_STABLE_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.auraB_rETH_STABLE_vault, tokenHasSamePriceFeed: Tokens.B_rETH_STABLE})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.auraB_rETH_STABLE_vault, tokenHasSamePriceFeed: Tokens.B_rETH_STABLE})
        );
    }

    function chainlinkPriceFeeds(uint256 index) external view returns (ChainlinkPriceFeedData memory) {
        return chainlinkPriceFeedsByNetwork[block.chainid][index];
    }
}
