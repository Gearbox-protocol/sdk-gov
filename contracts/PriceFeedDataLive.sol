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
    bool reserve;
    bool trusted;
}

struct CurvePriceFeedData {
    Tokens lpToken;
    Tokens[] assets;
    Contracts pool;
    bool reserve;
    bool trusted;
}

struct CrvUsdPriceFeedData {
    Tokens token;
    Tokens underlying;
    Contracts pool;
    bool reserve;
    bool trusted;
}

struct TheSamePriceFeedData {
    Tokens token;
    Tokens tokenHasSamePriceFeed;
    bool reserve;
    bool trusted;
}

struct SingeTokenPriceFeedData {
    Tokens token;
    bool reserve;
    bool trusted;
}

struct RedStonePriceFeedDataShort {
    string dataServiceId;
    bytes32 dataFeedId;
    address[10] signers;
    uint8 signersThreshold;
}

struct CompositePriceFeedDataShort {
    address targetToBaseFeed;
    uint32 targetStalenessPeriod;
    address baseToUSDFeed;
    uint32 baseStalenessPeriod;
}

struct CompositePriceFeedData {
    Tokens token;
    // Target data
    bool isTargetRedstone;
    RedStonePriceFeedDataShort redstoneTargetToBaseData;
    address targetToBaseFeed;
    uint32 targetStalenessPeriod;
    // Base data
    bool isBaseComposite;
    CompositePriceFeedDataShort compositeBaseToUSDData;
    address baseToUSDFeed;
    uint32 baseStalenessPeriod;
    // Misc
    bool reserve;
    bool trusted;
}

struct BoundedPriceFeedData {
    Tokens token;
    address priceFeed;
    uint32 stalenessPeriod;
    uint256 upperBound;
    bool reserve;
    bool trusted;
}

struct GenericLPPriceFeedData {
    Tokens lpToken;
    Tokens underlying;
    bool reserve;
    bool trusted;
}

struct BalancerLPPriceFeedData {
    Tokens lpToken;
    Tokens[] assets;
    bool reserve;
    bool trusted;
}

struct RedStonePriceFeedData {
    Tokens token;
    string dataServiceId;
    bytes32 dataFeedId;
    address[10] signers;
    uint8 signersThreshold;
    bool reserve;
    bool trusted;
}

struct PythPriceFeedData {
    Tokens token;
    bytes32 priceFeedId;
    string ticker;
    address pyth;
    bool reserve;
    bool trusted;
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
    mapping(uint256 => PythPriceFeedData[]) pythPriceFeedsByNetwork;
    mapping(address => string) redstoneServiceIdByPriceFeed;
    mapping(uint256 => BalancerLPPriceFeedData[]) balancerStableLPPriceFeedsByNetwork;
    mapping(uint256 => BalancerLPPriceFeedData[]) balancerWeightedLPPriceFeedsByNetwork;

    constructor() {
        // ------------------------ 1INCH ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens._1INCH,
                priceFeed: 0xc929ad75B72593967DE83E7F7Cda0493458261D9,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens._1INCH,
                priceFeed: 0x4bC735Ef24bf286983024CAd5D03f0738865Aaef,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ AAVE ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.AAVE,
                priceFeed: 0x547a514d5e3769680Ce22B2361c10Ea13619e8a9,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.AAVE,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "AAVE",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.AAVE,
                priceFeed: 0xaD1d5344AaDE45F43E596773Bcc4c423EAbdD034,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.AAVE,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "AAVE",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ COMP ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.COMP,
                priceFeed: 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.COMP,
                priceFeed: 0xe7C53FFd03Eb6ceF7d208bC4C13446c76d1E5884,
                stalenessPeriod: 3720,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ CRV ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.CRV,
                priceFeed: 0xCd627aA160A6fA45Eb793D19Ef54f5062F20f33f,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.CRV,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "CRV",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.CRV,
                priceFeed: 0xaebDA2c976cfd1eE1977Eac079B4382acb849325,
                stalenessPeriod: 3720,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.CRV,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "CRV",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ DAI ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.DAI,
                priceFeed: 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9,
                stalenessPeriod: 4500,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.DAI,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "DAI",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.DAI,
                priceFeed: 0xc5C8E77B397E531B8EC06BFb0048328B30E9eCfB,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.DAI,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "DAI",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.DAI,
                priceFeed: 0x8dBa75e83DA73cc766A7e5a0ee71F656BAb470d6,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: Tokens.DAI,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "DAI",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ DPI ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.DPI,
                priceFeed: 0xD2A593BF7594aCE1faD597adb697b5645d5edDB2,
                stalenessPeriod: 86400,
                trusted: false,
                reserve: false
            })
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.DPI, trusted: false, reserve: false})
        );

        // ------------------------ FEI ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.FEI, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.FEI, trusted: false, reserve: false})
        );

        // ------------------------ GUSD ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.GUSD, trusted: true, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.GUSD, trusted: false, reserve: false})
        );

        // ------------------------ LINK ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.LINK,
                priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c,
                stalenessPeriod: 4500,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.LINK,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "LINK",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.LINK,
                priceFeed: 0x86E53CF1B870786351Da77A57575e79CB55812CB,
                stalenessPeriod: 3720,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.LINK,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "LINK",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.LINK,
                priceFeed: 0xCc232dcFAAE6354cE191Bd574108c1aD03f86450,
                stalenessPeriod: 1320,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: Tokens.LINK,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "LINK",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ SNX ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.SNX,
                priceFeed: 0xDC3EA94CD0AC27d9A86C180091e7f78C683d3699,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.SNX,
                priceFeed: 0x054296f0D036b95531B4E14aFB578B80CFb41252,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.SNX,
                priceFeed: 0x2FCF37343e916eAEd1f1DdaaF84458a359b53877,
                stalenessPeriod: 1320,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ WLD ------------------------
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.WLD,
                priceFeed: 0x4e1C6B168DCFD7758bC2Ab9d2865f1895813D236,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ OP ------------------------
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.OP,
                priceFeed: 0x0D276FC14719f9292D5C1eA2198673d1f4269246,
                stalenessPeriod: 1320,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: Tokens.OP,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "OP",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ UNI ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.UNI,
                priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e,
                stalenessPeriod: 4500,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.UNI,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "UNI",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.UNI,
                priceFeed: 0x9C917083fDb403ab5ADbEC26Ee294f6EcAda2720,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.UNI,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "UNI",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ USDC ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDC,
                priceFeed: 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6,
                stalenessPeriod: 87300,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.USDC,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDC",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDC,
                priceFeed: 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3,
                stalenessPeriod: 86520,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.USDC,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDC",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDC,
                priceFeed: 0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: Tokens.USDC,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDC",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ USDC_e ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDC_e,
                priceFeed: 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6,
                stalenessPeriod: 87300,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.USDC_e,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDC",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDC_e,
                priceFeed: 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3,
                stalenessPeriod: 86520,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.USDC_e,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDC",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDC_e,
                priceFeed: 0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: Tokens.USDC_e,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDC",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ USDT ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDT,
                priceFeed: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.USDT,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDT",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDT,
                priceFeed: 0x3f3f5dF88dC9F13eac63DF89EC16ef6e7E25DdE7,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.USDT,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDT",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDT,
                priceFeed: 0xECef79E109e997bCA29c1c0897ec9d7b03647F5E,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: Tokens.USDT,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDT",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ WBTC ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.WBTC;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xfdFD9C85aD200c506Cf9e21F1FD8dd01932FBB23;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = true;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.WBTC,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "WBTC",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.WBTC;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x0017abAc5b6f291F9164e35B1234CA1D697f9CF4;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x6ce185860a4963106506C203335A2910413708e9;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = true;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.WBTC,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "WBTC",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.WBTC,
                priceFeed: 0x718A5788b89454aAE3A028AE9c111A29Be6c2a6F,
                stalenessPeriod: 1320,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: Tokens.WBTC,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "WBTC",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ WETH ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.WETH,
                priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                stalenessPeriod: 4500,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.WETH,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "ETH",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.WETH,
                priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612,
                stalenessPeriod: 86520,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.WETH,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "ETH",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.WETH,
                priceFeed: 0x13e3Ee699D1909E989722E753853AE30b17e08c5,
                stalenessPeriod: 1320,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: Tokens.WETH,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "ETH",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ YFI ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.YFI,
                priceFeed: 0xA027702dbb89fbd58938e4324ac03B58d812b0E1,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.YFI,
                priceFeed: 0x745Ab5b69E01E2BE1104Ca84937Bb71f96f5fB21,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ STETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.STETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x86392dC19c0b719886221c78AB11eb8Cf5c52812;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.STETH,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "stETH",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.STETH, trusted: false, reserve: false})
        );

        // ------------------------ wstETH ------------------------
        wstethPriceFeedByNetwork[1] = SingeTokenPriceFeedData({token: Tokens.wstETH, trusted: false, reserve: false});
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.wstETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xb523AE262D20A936BC152e6023996e46FDC2A95D;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.wstETH,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "wstETH",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[10].push();
            cpf.token = Tokens.wstETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x524299Ab0987a7c4B3c8022a35669DdcdC715a10;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x13e3Ee699D1909E989722E753853AE30b17e08c5;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: Tokens.wstETH,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "wstETH",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ CVX ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.CVX,
                priceFeed: 0xd962fC30A72A84cE50161031391756Bf2876Af5D,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.CVX,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "CVX",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.CVX,
                priceFeed: 0x851175a919f36c8e30197c09a9A49dA932c2CC00,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ FRAX ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.FRAX,
                priceFeed: 0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD,
                stalenessPeriod: 4500,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.FRAX,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "FRAX",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.FRAX,
                priceFeed: 0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ LUSD ------------------------
        boundedPriceFeedsByNetwork[1].push(
            BoundedPriceFeedData({
                token: Tokens.LUSD,
                priceFeed: 0x3D7aE7E594f2f2091Ad8798313450130d0Aba3a0,
                stalenessPeriod: 87300,
                upperBound: 110000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.LUSD,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "LUSD",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        boundedPriceFeedsByNetwork[42161].push(
            BoundedPriceFeedData({
                token: Tokens.LUSD,
                priceFeed: 0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF,
                stalenessPeriod: 86520,
                upperBound: 110000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.LUSD,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "LUSD",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ sUSD ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.sUSD;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x8e0b7e6062272B5eF4524250bFFF8e5Bd3497757;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 87300;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.sUSD, trusted: false, reserve: false})
        );

        // ------------------------ USDe ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.USDe,
                priceFeed: 0xbC5FBcf58CeAEa19D523aBc76515b9AEFb5cfd58,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ FXS ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.FXS,
                priceFeed: 0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.FXS,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "FXS",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.FXS,
                priceFeed: 0x36a121448D74Fa81450c992A1a44B9b7377CD3a5,
                stalenessPeriod: 3720,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.FXS,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "FXS",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ LDO ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.LDO;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x4e844125952D32AcdF339BE976c98E22F6F318dB;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.LDO, trusted: false, reserve: false})
        );

        // ------------------------ LQTY ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.LQTY, trusted: true, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.LQTY, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.LQTY, trusted: true, reserve: false}));
        zeroPriceFeedsByNetwork[8453].push(SingeTokenPriceFeedData({token: Tokens.LQTY, trusted: true, reserve: false}));

        // ------------------------ OHM ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.OHM;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x9a72298ae3886221820B1c878d12D872087D3a23;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 87300;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.OHM, trusted: false, reserve: false})
        );

        // ------------------------ MIM ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.MIM,
                priceFeed: 0x7A364e8770418566e3eb2001A96116E6138Eb32F,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.MIM, trusted: false, reserve: false})
        );

        // ------------------------ SPELL ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.SPELL,
                priceFeed: 0x8c110B94C5f1d347fAcF5E1E938AB2db60E3c9a8,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.SPELL,
                priceFeed: 0x383b3624478124697BEF675F07cA37570b73992f,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ GMX ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.GMX, trusted: false, reserve: false}));
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.GMX,
                priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.GMX,
                dataServiceId: "redstone-arbitrum-prod",
                dataFeedId: "GMX",
                signers: [
                    0x345Efd26098e173F811e3B9Af1B0e0a11872B38b,
                    0xbD0c5ccd85D5831B10E3e49527B8Cd67e2EFAf39,
                    0x2F3E8EC88C01593d10ca9461c807660fF2D8DB28,
                    0xb7f154bB5491565D215F4EB1c3fe3e84960627aF,
                    0xE6b0De8F4B31F137d3c59b5a0A71e66e7D504Ef9,
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0)
                ],
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ ARB ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.ARB, trusted: false, reserve: false}));
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.ARB,
                priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.ARB,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "ARB",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ SHIB ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.SHIB, trusted: false, reserve: false}));

        // ------------------------ RDNT ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.RDNT, trusted: false, reserve: false}));
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.RDNT,
                priceFeed: 0x20d0Fcab0ECFD078B036b6CAf1FaC69A6453b352,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ BAL ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.BAL,
                priceFeed: 0xdF2917806E30300537aEB49A7663062F4d1F2b5F,
                stalenessPeriod: 86400,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.BAL,
                dataServiceId: "redstone-arbitrum-prod",
                dataFeedId: "BAL",
                signers: [
                    0x345Efd26098e173F811e3B9Af1B0e0a11872B38b,
                    0xbD0c5ccd85D5831B10E3e49527B8Cd67e2EFAf39,
                    0x2F3E8EC88C01593d10ca9461c807660fF2D8DB28,
                    0xb7f154bB5491565D215F4EB1c3fe3e84960627aF,
                    0xE6b0De8F4B31F137d3c59b5a0A71e66e7D504Ef9,
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0)
                ],
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.BAL,
                priceFeed: 0xBE5eA816870D11239c543F84b71439511D70B94f,
                stalenessPeriod: 3720,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.BAL,
                dataServiceId: "redstone-arbitrum-prod",
                dataFeedId: "BAL",
                signers: [
                    0x345Efd26098e173F811e3B9Af1B0e0a11872B38b,
                    0xbD0c5ccd85D5831B10E3e49527B8Cd67e2EFAf39,
                    0x2F3E8EC88C01593d10ca9461c807660fF2D8DB28,
                    0xb7f154bB5491565D215F4EB1c3fe3e84960627aF,
                    0xE6b0De8F4B31F137d3c59b5a0A71e66e7D504Ef9,
                    address(0),
                    address(0),
                    address(0),
                    address(0),
                    address(0)
                ],
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ rETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.rETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x536218f9E9Eb48863970252233c8F271f554C2d0;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 87300;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.rETH,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "rETH",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.rETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xF3272CAfe65b190e76caAF483db13424a3e23dD2;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: Tokens.rETH,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "rETH",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[10].push();
            cpf.token = Tokens.rETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xb429DE60943a8e6DeD356dca2F93Cd31201D9ed0;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x13e3Ee699D1909E989722E753853AE30b17e08c5;
            cpf.baseStalenessPeriod = 1320;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: Tokens.rETH,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "rETH",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ osETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.osETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x66ac817f997Efd114EDFcccdce99F3268557B32C;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.osETH,
                tokenHasSamePriceFeed: Tokens.WETH,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ weETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.weETH;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "weETH_FUNDAMENTAL",
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
            });
            cpf.targetStalenessPeriod = 240;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.weETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x5c9C449BbC9a6075A2c061dF312a35fd1E05fF22;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = true;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.weETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xE141425bc1594b8039De6390db1cDaf4397EA22b;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.weETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xA736eAe8805dDeFFba40cAB8c99bCB309dEaBd9B;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = true;
        }

        // ------------------------ ezETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.ezETH;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "ezETH_FUNDAMENTAL",
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
            });
            cpf.targetStalenessPeriod = 240;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.ezETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x636A000262F6aA9e1F094ABF0aD8f645C44f641C;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = true;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.ezETH;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "ezETH_FUNDAMENTAL",
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
            });
            cpf.targetStalenessPeriod = 240;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.ezETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x11E1836bFF2ce9d6A5bec9cA79dc998210f3886d;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = true;
        }

        // ------------------------ rswETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.rswETH;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "rswETH_FUNDAMENTAL",
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
            });
            cpf.targetStalenessPeriod = 240;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.rswETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x3A236F67Fce401D87D7215695235e201966576E4;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = true;
        }

        // ------------------------ pufETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.pufETH;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "pufETH_FUNDAMENTAL",
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
            });
            cpf.targetStalenessPeriod = 240;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.pufETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x76A495b0bFfb53ef3F0E94ef0763e03cE410835C;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = true;
        }

        // ------------------------ rsETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.rsETH;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "rsETH_FUNDAMENTAL",
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
            });
            cpf.targetStalenessPeriod = 240;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.rsETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x03c68933f7a3F76875C0bc670a58e69294cDFD01;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = true;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.rsETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xb0EA543f9F8d4B818550365d13F66Da747e1476A;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.rsETH;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "rsETH/ETH",
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
            });
            cpf.targetStalenessPeriod = 240;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = true;
        }

        // ------------------------ frxETH ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.frxETH, trusted: false, reserve: false}));
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.frxETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x5C3e80763862CB777Aa07BDDBcCE0123104e1c34;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }

        // ------------------------ sfrxETH ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.sfrxETH, trusted: false, reserve: false})
        );
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.sfrxETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x98E5a52fB741347199C08a7a3fcF017364284431;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = true;
            cpf.compositeBaseToUSDData = CompositePriceFeedDataShort({
                targetToBaseFeed: 0x5C3e80763862CB777Aa07BDDBcCE0123104e1c34,
                targetStalenessPeriod: 86520,
                baseToUSDFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612,
                baseStalenessPeriod: 86520
            });

            cpf.trusted = false;
            cpf.reserve = false;
        }

        // ------------------------ cbETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = Tokens.cbETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xF017fcB346A1885194689bA23Eff2fE6fA5C483b;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = Tokens.cbETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xa668682974E3f121185a3cD94f00322beC674275;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[10].push();
            cpf.token = Tokens.cbETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x138b809B8472fF09Cd3E075E6EcbB2e42D41d870;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x13e3Ee699D1909E989722E753853AE30b17e08c5;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }

        // ------------------------ PENDLE ------------------------
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.PENDLE,
                priceFeed: 0x66853E19d73c0F9301fe099c324A1E9726953433,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: Tokens.PENDLE,
                priceFeed: 0x58F23F80bF389DB1af9e3aA8c59679806749A8a4,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ AURA ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.AURA, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.AURA, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.AURA, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.AURA, trusted: false, reserve: false})
        );

        // ------------------------ SWISE ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.SWISE, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.SWISE, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.SWISE, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.SWISE, trusted: false, reserve: false})
        );

        // ------------------------ GHO ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.GHO,
                priceFeed: 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.GHO,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "GHO",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ yvDAI ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvDAI, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.yvDAI, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.yvDAI, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.yvDAI, trusted: false, reserve: false})
        );

        // ------------------------ yvUSDC ------------------------
        yearnPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDC, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDC, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDC, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDC, trusted: false, reserve: false})
        );

        // ------------------------ yvUSDC_e ------------------------
        yearnPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDC_e, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDC_e, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDC_e, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDC_e, trusted: false, reserve: false})
        );

        // ------------------------ yvUSDT ------------------------
        yearnPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDT, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDT, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDT, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.yvUSDT, trusted: false, reserve: false})
        );

        // ------------------------ yvWETH ------------------------
        yearnPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.yvWETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.yvWETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.yvWETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.yvWETH, trusted: false, reserve: false})
        );

        // ------------------------ yvWBTC ------------------------
        yearnPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.yvWBTC, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.yvWBTC, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.yvWBTC, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.yvWBTC, trusted: false, reserve: false})
        );

        // ------------------------ yvOP ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.yvOP, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.yvOP, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: Tokens.yvOP, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.yvOP, trusted: false, reserve: false})
        );

        // ------------------------ 3Crv ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens._3Crv,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens._3Crv,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens._3Crv,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens._3Crv,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvFRAX ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvFRAX,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvFRAX,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvFRAX,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvFRAX,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ steCRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.steCRV,
                assets: TokensLib.arrayOf(Tokens.STETH, Tokens.WETH),
                pool: Contracts.CURVE_STETH_GATEWAY,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.steCRV,
                assets: TokensLib.arrayOf(Tokens.STETH, Tokens.WETH),
                pool: Contracts.CURVE_STETH_GATEWAY,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.steCRV,
                assets: TokensLib.arrayOf(Tokens.STETH, Tokens.WETH),
                pool: Contracts.CURVE_STETH_GATEWAY,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.steCRV,
                assets: TokensLib.arrayOf(Tokens.STETH, Tokens.WETH),
                pool: Contracts.CURVE_STETH_GATEWAY,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ FRAX3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAX3CRV,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAX3CRV,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAX3CRV,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAX3CRV,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ LUSD3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.LUSD3CRV,
                assets: TokensLib.arrayOf(Tokens.LUSD, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_LUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.LUSD3CRV,
                assets: TokensLib.arrayOf(Tokens.LUSD, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_LUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.LUSD3CRV,
                assets: TokensLib.arrayOf(Tokens.LUSD, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_LUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.LUSD3CRV,
                assets: TokensLib.arrayOf(Tokens.LUSD, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_LUSD_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvPlain3andSUSD ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvPlain3andSUSD,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT, Tokens.sUSD),
                pool: Contracts.CURVE_SUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvPlain3andSUSD,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT, Tokens.sUSD),
                pool: Contracts.CURVE_SUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvPlain3andSUSD,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT, Tokens.sUSD),
                pool: Contracts.CURVE_SUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvPlain3andSUSD,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC, Tokens.USDT, Tokens.sUSD),
                pool: Contracts.CURVE_SUSD_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ gusd3CRV ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.gusd3CRV, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.gusd3CRV, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.gusd3CRV, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.gusd3CRV, trusted: true, reserve: false})
        );

        // ------------------------ MIM_3LP3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.MIM_3LP3CRV,
                assets: TokensLib.arrayOf(Tokens.MIM, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_MIM_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.MIM_3LP3CRV,
                assets: TokensLib.arrayOf(Tokens.MIM, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_MIM_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.MIM_3LP3CRV,
                assets: TokensLib.arrayOf(Tokens.MIM, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_MIM_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.MIM_3LP3CRV,
                assets: TokensLib.arrayOf(Tokens.MIM, Tokens.DAI, Tokens.USDC, Tokens.USDT),
                pool: Contracts.CURVE_MIM_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ USDeUSDC ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDeUSDC,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.USDC),
                pool: Contracts.CURVE_USDE_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDeUSDC,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.USDC),
                pool: Contracts.CURVE_USDE_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDeUSDC,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.USDC),
                pool: Contracts.CURVE_USDE_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDeUSDC,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.USDC),
                pool: Contracts.CURVE_USDE_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ USDeDAI ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDeDAI,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.DAI),
                pool: Contracts.CURVE_USDE_DAI_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDeDAI,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.DAI),
                pool: Contracts.CURVE_USDE_DAI_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDeDAI,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.DAI),
                pool: Contracts.CURVE_USDE_DAI_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDeDAI,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.DAI),
                pool: Contracts.CURVE_USDE_DAI_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ MtEthena ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.MtEthena, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.MtEthena, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.MtEthena, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.MtEthena, trusted: true, reserve: false})
        );

        // ------------------------ GHOUSDe ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.GHOUSDe,
                assets: TokensLib.arrayOf(Tokens.GHO, Tokens.USDe),
                pool: Contracts.CURVE_GHO_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.GHOUSDe,
                assets: TokensLib.arrayOf(Tokens.GHO, Tokens.USDe),
                pool: Contracts.CURVE_GHO_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.GHOUSDe,
                assets: TokensLib.arrayOf(Tokens.GHO, Tokens.USDe),
                pool: Contracts.CURVE_GHO_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.GHOUSDe,
                assets: TokensLib.arrayOf(Tokens.GHO, Tokens.USDe),
                pool: Contracts.CURVE_GHO_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ FRAXUSDe ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAXUSDe,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDe),
                pool: Contracts.CURVE_FRAX_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAXUSDe,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDe),
                pool: Contracts.CURVE_FRAX_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAXUSDe,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDe),
                pool: Contracts.CURVE_FRAX_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.FRAXUSDe,
                assets: TokensLib.arrayOf(Tokens.FRAX, Tokens.USDe),
                pool: Contracts.CURVE_FRAX_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ USDecrvUSD ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDecrvUSD,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.crvUSD),
                pool: Contracts.CURVE_USDE_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDecrvUSD,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.crvUSD),
                pool: Contracts.CURVE_USDE_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDecrvUSD,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.crvUSD),
                pool: Contracts.CURVE_USDE_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.USDecrvUSD,
                assets: TokensLib.arrayOf(Tokens.USDe, Tokens.crvUSD),
                pool: Contracts.CURVE_USDE_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ OHMFRAXBP ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.OHMFRAXBP,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.crvFRAX),
                pool: Contracts.CURVE_OHMFRAXBP_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.OHMFRAXBP,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.crvFRAX),
                pool: Contracts.CURVE_OHMFRAXBP_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.OHMFRAXBP,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.crvFRAX),
                pool: Contracts.CURVE_OHMFRAXBP_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.OHMFRAXBP,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.crvFRAX),
                pool: Contracts.CURVE_OHMFRAXBP_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvCRVETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCRVETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_CRVETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCRVETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_CRVETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCRVETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_CRVETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCRVETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_CRVETH_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvCVXETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCVXETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CVX),
                pool: Contracts.CURVE_CVXETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCVXETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CVX),
                pool: Contracts.CURVE_CVXETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCVXETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CVX),
                pool: Contracts.CURVE_CVXETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvCVXETH,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.CVX),
                pool: Contracts.CURVE_CVXETH_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDTWBTCWETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(Tokens.USDT, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(Tokens.USDT, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(Tokens.USDT, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(Tokens.USDT, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ LDOETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.LDOETH,
                assets: TokensLib.arrayOf(Tokens.LDO, Tokens.WETH),
                pool: Contracts.CURVE_LDOETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.LDOETH,
                assets: TokensLib.arrayOf(Tokens.LDO, Tokens.WETH),
                pool: Contracts.CURVE_LDOETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.LDOETH,
                assets: TokensLib.arrayOf(Tokens.LDO, Tokens.WETH),
                pool: Contracts.CURVE_LDOETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.LDOETH,
                assets: TokensLib.arrayOf(Tokens.LDO, Tokens.WETH),
                pool: Contracts.CURVE_LDOETH_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSD ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.crvUSD,
                priceFeed: 0xEEf0C605546958c1f899b6fB336C20671f9cD49F,
                stalenessPeriod: 86400,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.crvUSD,
                priceFeed: 0x0a32255dd4BB6177C994bAAc73E0606fDD568f66,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDUSDC ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDUSDT ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDFRAX ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDFRAX,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDFRAX,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDFRAX,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDFRAX,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ wstETHCRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.wstETHCRV,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.wstETH),
                pool: Contracts.CURVE_ETH_WSTETH_GATEWAY_OP,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.wstETHCRV,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.wstETH),
                pool: Contracts.CURVE_ETH_WSTETH_GATEWAY_OP,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.wstETHCRV,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.wstETH),
                pool: Contracts.CURVE_ETH_WSTETH_GATEWAY_OP,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.wstETHCRV,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.wstETH),
                pool: Contracts.CURVE_ETH_WSTETH_GATEWAY_OP,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDETHCRV ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDETHCRV,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDETHCRV,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDETHCRV,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDETHCRV,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WETH, Tokens.CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ rETH_f ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.rETH_f,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.rETH_f,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.rETH_f,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.rETH_f,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ pufETHwstE ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.pufETHwstE, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.pufETHwstE, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.pufETHwstE, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.pufETHwstE, trusted: false, reserve: false})
        );

        // ------------------------ 2CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens._2CRV,
                assets: TokensLib.arrayOf(Tokens.USDC_e, Tokens.USDT),
                pool: Contracts.CURVE_2CRV_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens._2CRV,
                assets: TokensLib.arrayOf(Tokens.USDC_e, Tokens.USDT),
                pool: Contracts.CURVE_2CRV_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens._2CRV,
                assets: TokensLib.arrayOf(Tokens.USDC_e, Tokens.USDT),
                pool: Contracts.CURVE_2CRV_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens._2CRV,
                assets: TokensLib.arrayOf(Tokens.USDC_e, Tokens.USDT),
                pool: Contracts.CURVE_2CRV_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ 3c-crvUSD ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens._3c_crvUSD,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens._3c_crvUSD,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens._3c_crvUSD,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens._3c_crvUSD,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.WBTC, Tokens.WETH),
                pool: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDC ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDC,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDC_e ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDC_e,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC_e),
                pool: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDC_e,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC_e),
                pool: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDC_e,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC_e),
                pool: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDC_e,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDC_e),
                pool: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ 3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens._3CRV,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC_e, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL_OP,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens._3CRV,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC_e, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL_OP,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens._3CRV,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC_e, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL_OP,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens._3CRV,
                assets: TokensLib.arrayOf(Tokens.DAI, Tokens.USDC_e, Tokens.USDT),
                pool: Contracts.CURVE_3CRV_POOL_OP,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDT ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: Tokens.crvUSDT,
                assets: TokensLib.arrayOf(Tokens.crvUSD, Tokens.USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ yvCurve_stETH ------------------------
        yearnPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.yvCurve_stETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.yvCurve_stETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.yvCurve_stETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.yvCurve_stETH, trusted: false, reserve: false})
        );

        // ------------------------ yvCurve_FRAX ------------------------
        yearnPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.yvCurve_FRAX, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.yvCurve_FRAX, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.yvCurve_FRAX, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.yvCurve_FRAX, trusted: false, reserve: false})
        );

        // ------------------------ cvx3Crv ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvx3Crv,
                tokenHasSamePriceFeed: Tokens._3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvx3Crv,
                tokenHasSamePriceFeed: Tokens._3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvx3Crv,
                tokenHasSamePriceFeed: Tokens._3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvx3Crv,
                tokenHasSamePriceFeed: Tokens._3Crv,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvFRAX,
                tokenHasSamePriceFeed: Tokens.crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvFRAX,
                tokenHasSamePriceFeed: Tokens.crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvFRAX,
                tokenHasSamePriceFeed: Tokens.crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvFRAX,
                tokenHasSamePriceFeed: Tokens.crvFRAX,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxsteCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxsteCRV,
                tokenHasSamePriceFeed: Tokens.steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxsteCRV,
                tokenHasSamePriceFeed: Tokens.steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxsteCRV,
                tokenHasSamePriceFeed: Tokens.steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxsteCRV,
                tokenHasSamePriceFeed: Tokens.steCRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxFRAX3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxFRAX3CRV,
                tokenHasSamePriceFeed: Tokens.FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxFRAX3CRV,
                tokenHasSamePriceFeed: Tokens.FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxFRAX3CRV,
                tokenHasSamePriceFeed: Tokens.FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxFRAX3CRV,
                tokenHasSamePriceFeed: Tokens.FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxLUSD3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxLUSD3CRV,
                tokenHasSamePriceFeed: Tokens.LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxLUSD3CRV,
                tokenHasSamePriceFeed: Tokens.LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxLUSD3CRV,
                tokenHasSamePriceFeed: Tokens.LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxLUSD3CRV,
                tokenHasSamePriceFeed: Tokens.LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvPlain3andSUSD ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxgusd3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxgusd3CRV,
                tokenHasSamePriceFeed: Tokens.gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxgusd3CRV,
                tokenHasSamePriceFeed: Tokens.gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxgusd3CRV,
                tokenHasSamePriceFeed: Tokens.gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxgusd3CRV,
                tokenHasSamePriceFeed: Tokens.gusd3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxOHMFRAXBP ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxOHMFRAXBP,
                tokenHasSamePriceFeed: Tokens.OHMFRAXBP,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxOHMFRAXBP,
                tokenHasSamePriceFeed: Tokens.OHMFRAXBP,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxOHMFRAXBP,
                tokenHasSamePriceFeed: Tokens.OHMFRAXBP,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxOHMFRAXBP,
                tokenHasSamePriceFeed: Tokens.OHMFRAXBP,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxMIM_3LP3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxMIM_3LP3CRV,
                tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxMIM_3LP3CRV,
                tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxMIM_3LP3CRV,
                tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxMIM_3LP3CRV,
                tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvCRVETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvCRVETH,
                tokenHasSamePriceFeed: Tokens.crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvCRVETH,
                tokenHasSamePriceFeed: Tokens.crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvCRVETH,
                tokenHasSamePriceFeed: Tokens.crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvCRVETH,
                tokenHasSamePriceFeed: Tokens.crvCRVETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvCVXETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvCVXETH,
                tokenHasSamePriceFeed: Tokens.crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvCVXETH,
                tokenHasSamePriceFeed: Tokens.crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvCVXETH,
                tokenHasSamePriceFeed: Tokens.crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvCVXETH,
                tokenHasSamePriceFeed: Tokens.crvCVXETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDTWBTCWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxLDOETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxLDOETH,
                tokenHasSamePriceFeed: Tokens.LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxLDOETH,
                tokenHasSamePriceFeed: Tokens.LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxLDOETH,
                tokenHasSamePriceFeed: Tokens.LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxLDOETH,
                tokenHasSamePriceFeed: Tokens.LDOETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDUSDC ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDUSDC,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDUSDC,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDUSDC,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDUSDC,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDFRAX,
                tokenHasSamePriceFeed: Tokens.crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDFRAX,
                tokenHasSamePriceFeed: Tokens.crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDFRAX,
                tokenHasSamePriceFeed: Tokens.crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDFRAX,
                tokenHasSamePriceFeed: Tokens.crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDETHCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: Tokens.crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: Tokens.crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: Tokens.crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: Tokens.crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvx3Crv ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvx3Crv,
                tokenHasSamePriceFeed: Tokens._3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvx3Crv,
                tokenHasSamePriceFeed: Tokens._3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvx3Crv,
                tokenHasSamePriceFeed: Tokens._3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvx3Crv,
                tokenHasSamePriceFeed: Tokens._3Crv,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvFRAX,
                tokenHasSamePriceFeed: Tokens.crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvFRAX,
                tokenHasSamePriceFeed: Tokens.crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvFRAX,
                tokenHasSamePriceFeed: Tokens.crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvFRAX,
                tokenHasSamePriceFeed: Tokens.crvFRAX,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxsteCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxsteCRV,
                tokenHasSamePriceFeed: Tokens.steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxsteCRV,
                tokenHasSamePriceFeed: Tokens.steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxsteCRV,
                tokenHasSamePriceFeed: Tokens.steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxsteCRV,
                tokenHasSamePriceFeed: Tokens.steCRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxFRAX3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxFRAX3CRV,
                tokenHasSamePriceFeed: Tokens.FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxFRAX3CRV,
                tokenHasSamePriceFeed: Tokens.FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxFRAX3CRV,
                tokenHasSamePriceFeed: Tokens.FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxFRAX3CRV,
                tokenHasSamePriceFeed: Tokens.FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxLUSD3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxLUSD3CRV,
                tokenHasSamePriceFeed: Tokens.LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxLUSD3CRV,
                tokenHasSamePriceFeed: Tokens.LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxLUSD3CRV,
                tokenHasSamePriceFeed: Tokens.LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxLUSD3CRV,
                tokenHasSamePriceFeed: Tokens.LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvPlain3andSUSD ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: Tokens.crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxgusd3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxgusd3CRV,
                tokenHasSamePriceFeed: Tokens.gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxgusd3CRV,
                tokenHasSamePriceFeed: Tokens.gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxgusd3CRV,
                tokenHasSamePriceFeed: Tokens.gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxgusd3CRV,
                tokenHasSamePriceFeed: Tokens.gusd3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxOHMFRAXBP ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxOHMFRAXBP,
                tokenHasSamePriceFeed: Tokens.OHMFRAXBP,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxOHMFRAXBP,
                tokenHasSamePriceFeed: Tokens.OHMFRAXBP,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxOHMFRAXBP,
                tokenHasSamePriceFeed: Tokens.OHMFRAXBP,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxOHMFRAXBP,
                tokenHasSamePriceFeed: Tokens.OHMFRAXBP,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxMIM_3LP3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxMIM_3LP3CRV,
                tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxMIM_3LP3CRV,
                tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxMIM_3LP3CRV,
                tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxMIM_3LP3CRV,
                tokenHasSamePriceFeed: Tokens.MIM_3LP3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvCRVETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvCRVETH,
                tokenHasSamePriceFeed: Tokens.crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvCRVETH,
                tokenHasSamePriceFeed: Tokens.crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvCRVETH,
                tokenHasSamePriceFeed: Tokens.crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvCRVETH,
                tokenHasSamePriceFeed: Tokens.crvCRVETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvCVXETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvCVXETH,
                tokenHasSamePriceFeed: Tokens.crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvCVXETH,
                tokenHasSamePriceFeed: Tokens.crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvCVXETH,
                tokenHasSamePriceFeed: Tokens.crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvCVXETH,
                tokenHasSamePriceFeed: Tokens.crvCVXETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvUSDTWBTCWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: Tokens.crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxLDOETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxLDOETH,
                tokenHasSamePriceFeed: Tokens.LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxLDOETH,
                tokenHasSamePriceFeed: Tokens.LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxLDOETH,
                tokenHasSamePriceFeed: Tokens.LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxLDOETH,
                tokenHasSamePriceFeed: Tokens.LDOETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvUSDUSDC ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvUSDUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvUSDFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDFRAX,
                tokenHasSamePriceFeed: Tokens.crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDFRAX,
                tokenHasSamePriceFeed: Tokens.crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDFRAX,
                tokenHasSamePriceFeed: Tokens.crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDFRAX,
                tokenHasSamePriceFeed: Tokens.crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvUSDETHCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: Tokens.crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: Tokens.crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: Tokens.crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.stkcvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: Tokens.crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.cvxcrvUSDT,
                tokenHasSamePriceFeed: Tokens.crvUSDT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ 50OHM_50DAI ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens._50OHM_50DAI,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.DAI),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens._50OHM_50DAI,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.DAI),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens._50OHM_50DAI,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.DAI),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens._50OHM_50DAI,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.DAI),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ 50OHM_50WETH ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens._50OHM_50WETH,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens._50OHM_50WETH,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens._50OHM_50WETH,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens._50OHM_50WETH,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ B_80BAL_20WETH ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.B_80BAL_20WETH,
                assets: TokensLib.arrayOf(Tokens.BAL, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.B_80BAL_20WETH,
                assets: TokensLib.arrayOf(Tokens.BAL, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.B_80BAL_20WETH,
                assets: TokensLib.arrayOf(Tokens.BAL, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.B_80BAL_20WETH,
                assets: TokensLib.arrayOf(Tokens.BAL, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ 50WETH_50AURA ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens._50WETH_50AURA, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens._50WETH_50AURA, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens._50WETH_50AURA, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens._50WETH_50AURA, trusted: false, reserve: false})
        );

        // ------------------------ OHM_wstETH ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.OHM_wstETH,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.wstETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.OHM_wstETH,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.wstETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.OHM_wstETH,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.wstETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.OHM_wstETH,
                assets: TokensLib.arrayOf(Tokens.OHM, Tokens.wstETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ USDC_DAI_USDT ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.USDC_DAI_USDT,
                assets: TokensLib.arrayOf(Tokens.USDC, Tokens.DAI, Tokens.USDT),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.USDC_DAI_USDT,
                assets: TokensLib.arrayOf(Tokens.USDC, Tokens.DAI, Tokens.USDT),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.USDC_DAI_USDT,
                assets: TokensLib.arrayOf(Tokens.USDC, Tokens.DAI, Tokens.USDT),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.USDC_DAI_USDT,
                assets: TokensLib.arrayOf(Tokens.USDC, Tokens.DAI, Tokens.USDT),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ B_rETH_STABLE ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.B_rETH_STABLE,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.B_rETH_STABLE,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.B_rETH_STABLE,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.B_rETH_STABLE,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ weETH_rETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.weETH_rETH,
                assets: TokensLib.arrayOf(Tokens.weETH, Tokens.rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.weETH_rETH,
                assets: TokensLib.arrayOf(Tokens.weETH, Tokens.rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.weETH_rETH,
                assets: TokensLib.arrayOf(Tokens.weETH, Tokens.rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.weETH_rETH,
                assets: TokensLib.arrayOf(Tokens.weETH, Tokens.rETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ osETH_wETH_BPT ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.osETH_wETH_BPT,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.osETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.osETH_wETH_BPT,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.osETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.osETH_wETH_BPT,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.osETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.osETH_wETH_BPT,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.osETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ ezETH_WETH_BPT ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.ezETH_WETH_BPT, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.ezETH_WETH_BPT, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.ezETH_WETH_BPT, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.ezETH_WETH_BPT, trusted: false, reserve: false})
        );

        // ------------------------ weETH_ezETH_rswETH ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.weETH_ezETH_rswETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.weETH_ezETH_rswETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.weETH_ezETH_rswETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.weETH_ezETH_rswETH, trusted: false, reserve: false})
        );

        // ------------------------ rsETH_WETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.rsETH_WETH,
                assets: TokensLib.arrayOf(Tokens.rsETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.rsETH_WETH,
                assets: TokensLib.arrayOf(Tokens.rsETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.rsETH_WETH,
                assets: TokensLib.arrayOf(Tokens.rsETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.rsETH_WETH,
                assets: TokensLib.arrayOf(Tokens.rsETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ BPT_rETH_ETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_rETH_ETH,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_rETH_ETH,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_rETH_ETH,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_rETH_ETH,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ BPT_WSTETH_ETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ BPT_ROAD ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_ROAD,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.OP, Tokens.USDC),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_ROAD,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.OP, Tokens.USDC),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_ROAD,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.OP, Tokens.USDC),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.BPT_ROAD,
                assets: TokensLib.arrayOf(Tokens.WETH, Tokens.OP, Tokens.USDC),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ ECLP_wstETH_WETH ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.ECLP_wstETH_WETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.ECLP_wstETH_WETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.ECLP_wstETH_WETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.ECLP_wstETH_WETH, trusted: true, reserve: false})
        );

        // ------------------------ wstETH_WETH_BPT ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_WETH_BPT,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_WETH_BPT,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_WETH_BPT,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_WETH_BPT,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ wstETH_rETH_cbETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_rETH_cbETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.rETH, Tokens.cbETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_rETH_cbETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.rETH, Tokens.cbETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_rETH_cbETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.rETH, Tokens.cbETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_rETH_cbETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.rETH, Tokens.cbETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ wstETH_rETH_sfrxETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_rETH_sfrxETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.rETH, Tokens.sfrxETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_rETH_sfrxETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.rETH, Tokens.sfrxETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_rETH_sfrxETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.rETH, Tokens.sfrxETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.wstETH_rETH_sfrxETH,
                assets: TokensLib.arrayOf(Tokens.wstETH, Tokens.rETH, Tokens.sfrxETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ rETH_WETH_BPT ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.rETH_WETH_BPT,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.rETH_WETH_BPT,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.rETH_WETH_BPT,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: Tokens.rETH_WETH_BPT,
                assets: TokensLib.arrayOf(Tokens.rETH, Tokens.WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ 33AURA_33ARB_33BAL ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens._33AURA_33ARB_33BAL, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens._33AURA_33ARB_33BAL, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens._33AURA_33ARB_33BAL, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens._33AURA_33ARB_33BAL, trusted: true, reserve: false})
        );

        // ------------------------ ezETH_wstETH ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.ezETH_wstETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.ezETH_wstETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.ezETH_wstETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.ezETH_wstETH, trusted: true, reserve: false})
        );

        // ------------------------ GHO_USDT_USDC ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.GHO_USDT_USDC, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.GHO_USDT_USDC, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: Tokens.GHO_USDT_USDC, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: Tokens.GHO_USDT_USDC, trusted: true, reserve: false})
        );

        // ------------------------ dDAI ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.dDAI, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dDAI, trusted: false, reserve: false})
        );

        // ------------------------ dUSDC ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.dUSDC, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dUSDC, trusted: false, reserve: false})
        );

        // ------------------------ dWBTC ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.dWBTC, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dWBTC, trusted: false, reserve: false})
        );

        // ------------------------ dWETH ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.dWETH, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dWETH, trusted: false, reserve: false})
        );

        // ------------------------ dwstETH ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.dwstETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dwstETH, trusted: false, reserve: false})
        );

        // ------------------------ dFRAX ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.dFRAX, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dFRAX, trusted: false, reserve: false})
        );

        // ------------------------ dUSDCV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.dUSDCV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dUSDCV3, trusted: false, reserve: false})
        );

        // ------------------------ dWBTCV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.dWBTCV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dWBTCV3, trusted: false, reserve: false})
        );

        // ------------------------ dWETHV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.dWETHV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dWETHV3, trusted: false, reserve: false})
        );

        // ------------------------ sdUSDCV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.sdUSDCV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.sdUSDCV3, trusted: false, reserve: false})
        );

        // ------------------------ sdWBTCV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.sdWBTCV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.sdWBTCV3, trusted: false, reserve: false})
        );

        // ------------------------ sdWETHV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.sdWETHV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.sdWETHV3, trusted: false, reserve: false})
        );

        // ------------------------ dUSDTV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.dUSDTV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dUSDTV3, trusted: false, reserve: false})
        );

        // ------------------------ dGHOV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.dGHOV3, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dGHOV3, trusted: false, reserve: false})
        );

        // ------------------------ dDAIV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.dDAIV3, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.dDAIV3, trusted: false, reserve: false})
        );

        // ------------------------ sdUSDTV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.sdUSDTV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.sdUSDTV3, trusted: false, reserve: false})
        );

        // ------------------------ sdGHOV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.sdGHOV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.sdGHOV3, trusted: false, reserve: false})
        );

        // ------------------------ sdDAIV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: Tokens.sdDAIV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.sdDAIV3, trusted: false, reserve: false})
        );

        // ------------------------ GEAR ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: Tokens.GEAR, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: Tokens.GEAR, trusted: false, reserve: false})
        );

        // ------------------------ aDAI ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: Tokens.aDAI, tokenHasSamePriceFeed: Tokens.DAI, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: Tokens.aDAI, tokenHasSamePriceFeed: Tokens.DAI, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: Tokens.aDAI, tokenHasSamePriceFeed: Tokens.DAI, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({token: Tokens.aDAI, tokenHasSamePriceFeed: Tokens.DAI, trusted: false, reserve: false})
        );

        // ------------------------ aUSDC ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aUSDC,
                tokenHasSamePriceFeed: Tokens.USDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aUSDC,
                tokenHasSamePriceFeed: Tokens.USDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aUSDC,
                tokenHasSamePriceFeed: Tokens.USDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aUSDC,
                tokenHasSamePriceFeed: Tokens.USDC,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aUSDT,
                tokenHasSamePriceFeed: Tokens.USDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aUSDT,
                tokenHasSamePriceFeed: Tokens.USDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aUSDT,
                tokenHasSamePriceFeed: Tokens.USDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aUSDT,
                tokenHasSamePriceFeed: Tokens.USDT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aWETH,
                tokenHasSamePriceFeed: Tokens.WETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aWETH,
                tokenHasSamePriceFeed: Tokens.WETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aWETH,
                tokenHasSamePriceFeed: Tokens.WETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aWETH,
                tokenHasSamePriceFeed: Tokens.WETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ waDAI ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waDAI, underlying: Tokens.aDAI, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waDAI, underlying: Tokens.aDAI, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.waDAI, underlying: Tokens.aDAI, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.waDAI, underlying: Tokens.aDAI, trusted: false, reserve: false})
        );

        // ------------------------ waUSDC ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDC, underlying: Tokens.aUSDC, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDC, underlying: Tokens.aUSDC, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDC, underlying: Tokens.aUSDC, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDC, underlying: Tokens.aUSDC, trusted: false, reserve: false})
        );

        // ------------------------ waUSDT ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDT, underlying: Tokens.aUSDT, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDT, underlying: Tokens.aUSDT, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDT, underlying: Tokens.aUSDT, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.waUSDT, underlying: Tokens.aUSDT, trusted: false, reserve: false})
        );

        // ------------------------ waWETH ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.waWETH, underlying: Tokens.aWETH, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.waWETH, underlying: Tokens.aWETH, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.waWETH, underlying: Tokens.aWETH, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.waWETH, underlying: Tokens.aWETH, trusted: false, reserve: false})
        );

        // ------------------------ cDAI ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.cDAI, underlying: Tokens.DAI, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cDAI, underlying: Tokens.DAI, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.cDAI, underlying: Tokens.DAI, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.cDAI, underlying: Tokens.DAI, trusted: false, reserve: false})
        );

        // ------------------------ cUSDC ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDC, underlying: Tokens.USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDC, underlying: Tokens.USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDC, underlying: Tokens.USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDC, underlying: Tokens.USDC, trusted: false, reserve: false})
        );

        // ------------------------ cUSDT ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDT, underlying: Tokens.USDT, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDT, underlying: Tokens.USDT, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDT, underlying: Tokens.USDT, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.cUSDT, underlying: Tokens.USDT, trusted: false, reserve: false})
        );

        // ------------------------ cLINK ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.cLINK, underlying: Tokens.LINK, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cLINK, underlying: Tokens.LINK, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.cLINK, underlying: Tokens.LINK, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.cLINK, underlying: Tokens.LINK, trusted: false, reserve: false})
        );

        // ------------------------ cETH ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.cETH, underlying: Tokens.WETH, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.cETH, underlying: Tokens.WETH, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.cETH, underlying: Tokens.WETH, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.cETH, underlying: Tokens.WETH, trusted: false, reserve: false})
        );

        // ------------------------ fUSDC ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.fUSDC, underlying: Tokens.USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.fUSDC, underlying: Tokens.USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.fUSDC, underlying: Tokens.USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.fUSDC, underlying: Tokens.USDC, trusted: false, reserve: false})
        );

        // ------------------------ MKR ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.MKR,
                priceFeed: 0xec1D1B3b0443256cc3860e24a46F108e699484Aa,
                stalenessPeriod: 4500,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: Tokens.MKR,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "MKR",
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
                signersThreshold: 5,
                trusted: false,
                reserve: true
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.MKR,
                priceFeed: 0xdE9f0894670c4EFcacF370426F10C3AD2Cdf147e,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ RPL ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.RPL,
                priceFeed: 0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.RPL,
                priceFeed: 0xF0b7159BbFc341Cc41E7Cb182216F62c6d40533D,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ APE ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: Tokens.APE,
                priceFeed: 0xD10aBbC76679a20055E167BB80A24ac851b37056,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: Tokens.APE,
                priceFeed: 0x221912ce795669f628c51c69b7d0873eDA9C03bB,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ sDAI ------------------------
        erc4626PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.sDAI, underlying: Tokens.DAI, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.sDAI, underlying: Tokens.DAI, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.sDAI, underlying: Tokens.DAI, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.sDAI, underlying: Tokens.DAI, trusted: false, reserve: false})
        );

        // ------------------------ sUSDe ------------------------
        erc4626PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.sUSDe, underlying: Tokens.USDe, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.sUSDe, underlying: Tokens.USDe, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.sUSDe, underlying: Tokens.USDe, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.sUSDe, underlying: Tokens.USDe, trusted: false, reserve: false})
        );

        // ------------------------ YieldETH ------------------------
        erc4626PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: Tokens.YieldETH, underlying: Tokens.WETH, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: Tokens.YieldETH, underlying: Tokens.WETH, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: Tokens.YieldETH, underlying: Tokens.WETH, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: Tokens.YieldETH, underlying: Tokens.WETH, trusted: false, reserve: false})
        );

        // ------------------------ auraB_rETH_STABLE ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.auraB_rETH_STABLE,
                tokenHasSamePriceFeed: Tokens.B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.auraB_rETH_STABLE,
                tokenHasSamePriceFeed: Tokens.B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.auraB_rETH_STABLE,
                tokenHasSamePriceFeed: Tokens.B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.auraB_rETH_STABLE,
                tokenHasSamePriceFeed: Tokens.B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraB_rETH_STABLE_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.auraB_rETH_STABLE_vault,
                tokenHasSamePriceFeed: Tokens.B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.auraB_rETH_STABLE_vault,
                tokenHasSamePriceFeed: Tokens.B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.auraB_rETH_STABLE_vault,
                tokenHasSamePriceFeed: Tokens.B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.auraB_rETH_STABLE_vault,
                tokenHasSamePriceFeed: Tokens.B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraweETH_rETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.auraweETH_rETH,
                tokenHasSamePriceFeed: Tokens.weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.auraweETH_rETH,
                tokenHasSamePriceFeed: Tokens.weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.auraweETH_rETH,
                tokenHasSamePriceFeed: Tokens.weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.auraweETH_rETH,
                tokenHasSamePriceFeed: Tokens.weETH_rETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraweETH_rETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.auraweETH_rETH_vault,
                tokenHasSamePriceFeed: Tokens.weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.auraweETH_rETH_vault,
                tokenHasSamePriceFeed: Tokens.weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.auraweETH_rETH_vault,
                tokenHasSamePriceFeed: Tokens.weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.auraweETH_rETH_vault,
                tokenHasSamePriceFeed: Tokens.weETH_rETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraosETH_wETH_BPT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.auraosETH_wETH_BPT,
                tokenHasSamePriceFeed: Tokens.osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.auraosETH_wETH_BPT,
                tokenHasSamePriceFeed: Tokens.osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.auraosETH_wETH_BPT,
                tokenHasSamePriceFeed: Tokens.osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.auraosETH_wETH_BPT,
                tokenHasSamePriceFeed: Tokens.osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurarETH_WETH_BPT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aurarETH_WETH_BPT,
                tokenHasSamePriceFeed: Tokens.rETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aurarETH_WETH_BPT,
                tokenHasSamePriceFeed: Tokens.rETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aurarETH_WETH_BPT,
                tokenHasSamePriceFeed: Tokens.rETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aurarETH_WETH_BPT,
                tokenHasSamePriceFeed: Tokens.rETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurawstETH_rETH_cbETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_cbETH,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_cbETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_cbETH,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_cbETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_cbETH,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_cbETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_cbETH,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_cbETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurawstETH_rETH_sfrxETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_sfrxETH,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_sfrxETH,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_sfrxETH,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_sfrxETH,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurawstETH_WETH_BPT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_WETH_BPT,
                tokenHasSamePriceFeed: Tokens.wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_WETH_BPT,
                tokenHasSamePriceFeed: Tokens.wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_WETH_BPT,
                tokenHasSamePriceFeed: Tokens.wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_WETH_BPT,
                tokenHasSamePriceFeed: Tokens.wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraosETH_wETH_BPT_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.auraosETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.auraosETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.auraosETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.auraosETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraBPT_rETH_ETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_rETH_ETH,
                tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_rETH_ETH,
                tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_rETH_ETH,
                tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_rETH_ETH,
                tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraBPT_rETH_ETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_rETH_ETH_vault,
                tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_rETH_ETH_vault,
                tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_rETH_ETH_vault,
                tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_rETH_ETH_vault,
                tokenHasSamePriceFeed: Tokens.BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraBPT_WSTETH_ETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_WSTETH_ETH,
                tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_WSTETH_ETH,
                tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_WSTETH_ETH,
                tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_WSTETH_ETH,
                tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraBPT_WSTETH_ETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_WSTETH_ETH_vault,
                tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_WSTETH_ETH_vault,
                tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_WSTETH_ETH_vault,
                tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.auraBPT_WSTETH_ETH_vault,
                tokenHasSamePriceFeed: Tokens.BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurarETH_WETH_BPT_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aurarETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.rETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aurarETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.rETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aurarETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.rETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aurarETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.rETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurawstETH_rETH_cbETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_cbETH_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_cbETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_cbETH_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_cbETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_cbETH_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_cbETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_cbETH_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_cbETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurawstETH_rETH_sfrxETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_sfrxETH_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_sfrxETH_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_sfrxETH_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_rETH_sfrxETH_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurawstETH_WETH_BPT_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: Tokens.aurawstETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: Tokens.wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
    }

    function chainlinkPriceFeeds(uint256 index) external view returns (ChainlinkPriceFeedData memory) {
        return chainlinkPriceFeedsByNetwork[block.chainid][index];
    }
}
