// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

import "./Tokens.sol";
import {Contracts} from "./SupportedContracts.sol";

import {TokensLib} from "./TokensLib.sol";

struct ChainlinkPriceFeedData {
    uint256 token;
    address priceFeed;
    uint32 stalenessPeriod;
    bool reserve;
    bool trusted;
}

struct CurvePriceFeedData {
    uint256 lpToken;
    uint256[] assets;
    Contracts pool;
    bool reserve;
    bool trusted;
}

struct CrvUsdPriceFeedData {
    uint256 token;
    uint256 underlying;
    Contracts pool;
    bool reserve;
    bool trusted;
}

struct TheSamePriceFeedData {
    uint256 token;
    uint256 tokenHasSamePriceFeed;
    bool reserve;
    bool trusted;
}

struct SingeTokenPriceFeedData {
    uint256 token;
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
    uint256 token;
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
    uint256 token;
    address priceFeed;
    uint32 stalenessPeriod;
    uint256 upperBound;
    bool reserve;
    bool trusted;
}

struct GenericLPPriceFeedData {
    uint256 lpToken;
    uint256 underlying;
    bool reserve;
    bool trusted;
}

struct BalancerLPPriceFeedData {
    uint256 lpToken;
    uint256[] assets;
    bool reserve;
    bool trusted;
}

struct RedStonePriceFeedData {
    uint256 token;
    string dataServiceId;
    bytes32 dataFeedId;
    address[10] signers;
    uint8 signersThreshold;
    bool reserve;
    bool trusted;
}

struct PythPriceFeedData {
    uint256 token;
    bytes32 priceFeedId;
    string ticker;
    address pyth;
    bool reserve;
    bool trusted;
}

struct PendlePriceFeedData {
    uint256 token;
    uint256 underlying;
    address market;
    uint32 twapWindow;
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
    mapping(uint256 => GenericLPPriceFeedData[]) mellowLRTPriceFeedsByNetwork;
    mapping(uint256 => PendlePriceFeedData[]) pendlePriceFeedsByNetwork;

    constructor() {
        // ------------------------ 1INCH ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN__1INCH,
                priceFeed: 0xc929ad75B72593967DE83E7F7Cda0493458261D9,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: TOKEN__1INCH,
                priceFeed: 0x4bC735Ef24bf286983024CAd5D03f0738865Aaef,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ AAVE ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN_AAVE,
                priceFeed: 0x547a514d5e3769680Ce22B2361c10Ea13619e8a9,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_AAVE,
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
                token: TOKEN_AAVE,
                priceFeed: 0xaD1d5344AaDE45F43E596773Bcc4c423EAbdD034,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_AAVE,
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

        // ------------------------ CRV ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN_CRV,
                priceFeed: 0xCd627aA160A6fA45Eb793D19Ef54f5062F20f33f,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_CRV,
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
                token: TOKEN_CRV,
                priceFeed: 0xaebDA2c976cfd1eE1977Eac079B4382acb849325,
                stalenessPeriod: 3720,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_CRV,
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
        boundedPriceFeedsByNetwork[1].push(
            BoundedPriceFeedData({
                token: TOKEN_DAI,
                priceFeed: 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9,
                stalenessPeriod: 4500,
                upperBound: 104000000,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_DAI,
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
        boundedPriceFeedsByNetwork[42161].push(
            BoundedPriceFeedData({
                token: TOKEN_DAI,
                priceFeed: 0xc5C8E77B397E531B8EC06BFb0048328B30E9eCfB,
                stalenessPeriod: 86520,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_DAI,
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
        boundedPriceFeedsByNetwork[10].push(
            BoundedPriceFeedData({
                token: TOKEN_DAI,
                priceFeed: 0x8dBa75e83DA73cc766A7e5a0ee71F656BAb470d6,
                stalenessPeriod: 86520,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN_DAI,
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

        // ------------------------ USDS ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: TOKEN_USDS, tokenHasSamePriceFeed: TOKEN_DAI, trusted: true, reserve: false})
        );
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: TOKEN_USDS, tokenHasSamePriceFeed: TOKEN_DAI, trusted: false, reserve: true})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: TOKEN_USDS, tokenHasSamePriceFeed: TOKEN_DAI, trusted: true, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: TOKEN_USDS, tokenHasSamePriceFeed: TOKEN_DAI, trusted: false, reserve: true})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: TOKEN_USDS, tokenHasSamePriceFeed: TOKEN_DAI, trusted: true, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: TOKEN_USDS, tokenHasSamePriceFeed: TOKEN_DAI, trusted: false, reserve: true})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({token: TOKEN_USDS, tokenHasSamePriceFeed: TOKEN_DAI, trusted: true, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({token: TOKEN_USDS, tokenHasSamePriceFeed: TOKEN_DAI, trusted: false, reserve: true})
        );

        // ------------------------ GUSD ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_GUSD, trusted: true, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_GUSD, trusted: false, reserve: false})
        );

        // ------------------------ LINK ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN_LINK,
                priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c,
                stalenessPeriod: 4500,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_LINK,
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
                token: TOKEN_LINK,
                priceFeed: 0x86E53CF1B870786351Da77A57575e79CB55812CB,
                stalenessPeriod: 3720,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_LINK,
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
                token: TOKEN_LINK,
                priceFeed: 0xCc232dcFAAE6354cE191Bd574108c1aD03f86450,
                stalenessPeriod: 1320,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN_LINK,
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
                token: TOKEN_SNX,
                priceFeed: 0xDC3EA94CD0AC27d9A86C180091e7f78C683d3699,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: TOKEN_SNX,
                priceFeed: 0x054296f0D036b95531B4E14aFB578B80CFb41252,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: TOKEN_SNX,
                priceFeed: 0x2FCF37343e916eAEd1f1DdaaF84458a359b53877,
                stalenessPeriod: 1320,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ WLD ------------------------
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: TOKEN_WLD,
                priceFeed: 0x4e1C6B168DCFD7758bC2Ab9d2865f1895813D236,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ OP ------------------------
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: TOKEN_OP,
                priceFeed: 0x0D276FC14719f9292D5C1eA2198673d1f4269246,
                stalenessPeriod: 1320,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN_OP,
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
                token: TOKEN_UNI,
                priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e,
                stalenessPeriod: 4500,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_UNI,
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
                token: TOKEN_UNI,
                priceFeed: 0x9C917083fDb403ab5ADbEC26Ee294f6EcAda2720,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_UNI,
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
        boundedPriceFeedsByNetwork[1].push(
            BoundedPriceFeedData({
                token: TOKEN_USDC,
                priceFeed: 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6,
                stalenessPeriod: 87300,
                upperBound: 104000000,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_USDC,
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
        boundedPriceFeedsByNetwork[42161].push(
            BoundedPriceFeedData({
                token: TOKEN_USDC,
                priceFeed: 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3,
                stalenessPeriod: 86520,
                upperBound: 104000000,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_USDC,
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
        boundedPriceFeedsByNetwork[10].push(
            BoundedPriceFeedData({
                token: TOKEN_USDC,
                priceFeed: 0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3,
                stalenessPeriod: 86520,
                upperBound: 104000000,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN_USDC,
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
        boundedPriceFeedsByNetwork[42161].push(
            BoundedPriceFeedData({
                token: TOKEN_USDC_e,
                priceFeed: 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3,
                stalenessPeriod: 86520,
                upperBound: 104000000,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_USDC_e,
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
        boundedPriceFeedsByNetwork[10].push(
            BoundedPriceFeedData({
                token: TOKEN_USDC_e,
                priceFeed: 0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3,
                stalenessPeriod: 86520,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN_USDC_e,
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
        boundedPriceFeedsByNetwork[1].push(
            BoundedPriceFeedData({
                token: TOKEN_USDT,
                priceFeed: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D,
                stalenessPeriod: 87300,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_USDT,
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
        boundedPriceFeedsByNetwork[42161].push(
            BoundedPriceFeedData({
                token: TOKEN_USDT,
                priceFeed: 0x3f3f5dF88dC9F13eac63DF89EC16ef6e7E25DdE7,
                stalenessPeriod: 86520,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_USDT,
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
        boundedPriceFeedsByNetwork[10].push(
            BoundedPriceFeedData({
                token: TOKEN_USDT,
                priceFeed: 0xECef79E109e997bCA29c1c0897ec9d7b03647F5E,
                stalenessPeriod: 86520,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN_USDT,
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

        // ------------------------ DOLA ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: TOKEN_DOLA, tokenHasSamePriceFeed: TOKEN_USDC, trusted: true, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: TOKEN_DOLA, tokenHasSamePriceFeed: TOKEN_USDC, trusted: true, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: TOKEN_DOLA, tokenHasSamePriceFeed: TOKEN_USDC, trusted: true, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({token: TOKEN_DOLA, tokenHasSamePriceFeed: TOKEN_USDC, trusted: true, reserve: false})
        );

        // ------------------------ WBTC ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_WBTC;
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
                token: TOKEN_WBTC,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "BTC",
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
            cpf.token = TOKEN_WBTC;
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
                token: TOKEN_WBTC,
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
                token: TOKEN_WBTC,
                priceFeed: 0x718A5788b89454aAE3A028AE9c111A29Be6c2a6F,
                stalenessPeriod: 1320,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN_WBTC,
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
                token: TOKEN_WETH,
                priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                stalenessPeriod: 4500,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_WETH,
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
                token: TOKEN_WETH,
                priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612,
                stalenessPeriod: 86520,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_WETH,
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
                token: TOKEN_WETH,
                priceFeed: 0x13e3Ee699D1909E989722E753853AE30b17e08c5,
                stalenessPeriod: 1320,
                trusted: true,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN_WETH,
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
                token: TOKEN_YFI,
                priceFeed: 0xA027702dbb89fbd58938e4324ac03B58d812b0E1,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: TOKEN_YFI,
                priceFeed: 0x745Ab5b69E01E2BE1104Ca84937Bb71f96f5fB21,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ STETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: TOKEN_STETH, tokenHasSamePriceFeed: TOKEN_WETH, trusted: false, reserve: false})
        );
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_STETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x86392dC19c0b719886221c78AB11eb8Cf5c52812;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = true;
        }
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_STETH, trusted: false, reserve: false})
        );

        // ------------------------ wstETH ------------------------
        wstethPriceFeedByNetwork[1] = SingeTokenPriceFeedData({token: TOKEN_wstETH, trusted: false, reserve: false});
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = TOKEN_wstETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xB1552C5e96B312d0Bf8b554186F846C40614a540;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = TOKEN_wstETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xb523AE262D20A936BC152e6023996e46FDC2A95D;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = true;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[10].push();
            cpf.token = TOKEN_wstETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xe59EBa0D492cA53C6f46015EEa00517F2707dc77;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x13e3Ee699D1909E989722E753853AE30b17e08c5;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[10].push();
            cpf.token = TOKEN_wstETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x524299Ab0987a7c4B3c8022a35669DdcdC715a10;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x13e3Ee699D1909E989722E753853AE30b17e08c5;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = true;
        }

        // ------------------------ CVX ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN_CVX,
                priceFeed: 0xd962fC30A72A84cE50161031391756Bf2876Af5D,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_CVX,
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
                token: TOKEN_CVX,
                priceFeed: 0x851175a919f36c8e30197c09a9A49dA932c2CC00,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ FRAX ------------------------
        boundedPriceFeedsByNetwork[1].push(
            BoundedPriceFeedData({
                token: TOKEN_FRAX,
                priceFeed: 0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD,
                stalenessPeriod: 4500,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_FRAX,
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
                token: TOKEN_FRAX,
                priceFeed: 0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ LUSD ------------------------
        boundedPriceFeedsByNetwork[1].push(
            BoundedPriceFeedData({
                token: TOKEN_LUSD,
                priceFeed: 0x3D7aE7E594f2f2091Ad8798313450130d0Aba3a0,
                stalenessPeriod: 87300,
                upperBound: 110000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_LUSD,
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
                token: TOKEN_LUSD,
                priceFeed: 0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF,
                stalenessPeriod: 86520,
                upperBound: 110000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_LUSD,
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
            cpf.token = TOKEN_sUSD;
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
            SingeTokenPriceFeedData({token: TOKEN_sUSD, trusted: false, reserve: false})
        );

        // ------------------------ USDe ------------------------
        boundedPriceFeedsByNetwork[1].push(
            BoundedPriceFeedData({
                token: TOKEN_USDe,
                priceFeed: 0xa569d910839Ae8865Da8F8e70FfFb0cBA869F961,
                stalenessPeriod: 87300,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_USDe,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDe",
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
                token: TOKEN_USDe,
                priceFeed: 0x88AC7Bca36567525A866138F03a6F6844868E0Bc,
                stalenessPeriod: 86520,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_USDe,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "USDe",
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

        // ------------------------ FXS ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN_FXS,
                priceFeed: 0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_FXS,
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
                token: TOKEN_FXS,
                priceFeed: 0x36a121448D74Fa81450c992A1a44B9b7377CD3a5,
                stalenessPeriod: 3720,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_FXS,
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
            cpf.token = TOKEN_LDO;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x4e844125952D32AcdF339BE976c98E22F6F318dB;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_LDO,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "LDO",
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
        zeroPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: TOKEN_LDO, trusted: false, reserve: false}));

        // ------------------------ LQTY ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_LQTY, trusted: true, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: TOKEN_LQTY, trusted: true, reserve: false}));
        zeroPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: TOKEN_LQTY, trusted: true, reserve: false}));
        zeroPriceFeedsByNetwork[8453].push(SingeTokenPriceFeedData({token: TOKEN_LQTY, trusted: true, reserve: false}));

        // ------------------------ GMX ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_GMX, trusted: false, reserve: false}));
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: TOKEN_GMX,
                priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_GMX,
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
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_ARB, trusted: false, reserve: false}));
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: TOKEN_ARB,
                priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_ARB,
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
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_SHIB, trusted: false, reserve: false}));

        // ------------------------ BAL ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN_BAL,
                priceFeed: 0xdF2917806E30300537aEB49A7663062F4d1F2b5F,
                stalenessPeriod: 86400,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_BAL,
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
                token: TOKEN_BAL,
                priceFeed: 0xBE5eA816870D11239c543F84b71439511D70B94f,
                stalenessPeriod: 3720,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_BAL,
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

        // ------------------------ LBTC ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_LBTC;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "LBTC_FUNDAMENTAL",
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
            cpf.baseToUSDFeed = 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_LBTC,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "LBTC",
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

        // ------------------------ eBTC ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_eBTC;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "eBTC/WBTC",
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
            cpf.baseToUSDFeed = 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: TOKEN_eBTC, tokenHasSamePriceFeed: TOKEN_LBTC, trusted: false, reserve: true})
        );

        // ------------------------ solvBTC ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_solvBTC;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "SolvBTC.BBN_FUNDAMENTAL",
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
            cpf.baseToUSDFeed = 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_solvBTC;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "SolvBTC.BBN/BTC",
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
            cpf.baseToUSDFeed = 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = true;
        }

        // ------------------------ pumpBTC ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_pumpBTC;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "pumpBTC_FUNDAMENTAL",
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
            cpf.baseToUSDFeed = 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_pumpBTC;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "pumpBTC/BTC",
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
            cpf.baseToUSDFeed = 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = true;
        }

        // ------------------------ rETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_rETH;
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
                token: TOKEN_rETH,
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
            cpf.token = TOKEN_rETH;
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
                token: TOKEN_rETH,
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
            cpf.token = TOKEN_rETH;
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
                token: TOKEN_rETH,
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
            cpf.token = TOKEN_osETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x66ac817f997Efd114EDFcccdce99F3268557B32C;
            cpf.targetStalenessPeriod = 87300;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
            cpf.baseStalenessPeriod = 4500;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_osETH,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "osETH",
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

        // ------------------------ weETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_weETH;
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
            cpf.token = TOKEN_weETH;
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
            cpf.token = TOKEN_weETH;
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
            cpf.token = TOKEN_weETH;
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
            cpf.token = TOKEN_ezETH;
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
            cpf.token = TOKEN_ezETH;
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
            cpf.token = TOKEN_ezETH;
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
            cpf.token = TOKEN_ezETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0x11E1836bFF2ce9d6A5bec9cA79dc998210f3886d;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = true;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[10].push();
            cpf.token = TOKEN_ezETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xFAD40C0e2BeF93c6a822015863045CAAeAAde4d3;
            cpf.targetStalenessPeriod = 86520;
            cpf.isBaseComposite = false;
            cpf.baseToUSDFeed = 0x13e3Ee699D1909E989722E753853AE30b17e08c5;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = false;
        }
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[10].push();
            cpf.token = TOKEN_ezETH;
            cpf.isTargetRedstone = true;
            cpf.redstoneTargetToBaseData = RedStonePriceFeedDataShort({
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "ezETH/ETH",
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
            cpf.baseToUSDFeed = 0x13e3Ee699D1909E989722E753853AE30b17e08c5;
            cpf.baseStalenessPeriod = 86520;

            cpf.trusted = false;
            cpf.reserve = true;
        }

        // ------------------------ rswETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_rswETH;
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
            cpf.token = TOKEN_rswETH;
            cpf.isTargetRedstone = false;
            cpf.targetToBaseFeed = 0xb613CfebD0b6e95abDDe02677d6bC42394FdB857;
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
            cpf.token = TOKEN_pufETH;
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
            cpf.token = TOKEN_pufETH;
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
            cpf.token = TOKEN_rsETH;
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
            cpf.token = TOKEN_rsETH;
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
            cpf.token = TOKEN_rsETH;
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
            cpf.token = TOKEN_rsETH;
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
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_frxETH, trusted: false, reserve: false}));
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = TOKEN_frxETH;
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
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_sfrxETH, trusted: false, reserve: false}));
        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[42161].push();
            cpf.token = TOKEN_sfrxETH;
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
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_sfrxETH, trusted: false, reserve: false})
        );

        // ------------------------ cbETH ------------------------

        {
            CompositePriceFeedData storage cpf = compositePriceFeedsByNetwork[1].push();
            cpf.token = TOKEN_cbETH;
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
            cpf.token = TOKEN_cbETH;
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
            cpf.token = TOKEN_cbETH;
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
                token: TOKEN_PENDLE,
                priceFeed: 0x66853E19d73c0F9301fe099c324A1E9726953433,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: TOKEN_PENDLE,
                priceFeed: 0x58F23F80bF389DB1af9e3aA8c59679806749A8a4,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ AURA ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_AURA, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_AURA, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: TOKEN_AURA, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[8453].push(SingeTokenPriceFeedData({token: TOKEN_AURA, trusted: false, reserve: false}));

        // ------------------------ SWISE ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_SWISE, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_SWISE, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: TOKEN_SWISE, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_SWISE, trusted: false, reserve: false})
        );

        // ------------------------ SKY ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_SKY, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(SingeTokenPriceFeedData({token: TOKEN_SKY, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: TOKEN_SKY, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[8453].push(SingeTokenPriceFeedData({token: TOKEN_SKY, trusted: false, reserve: false}));

        // ------------------------ GHO ------------------------
        boundedPriceFeedsByNetwork[1].push(
            BoundedPriceFeedData({
                token: TOKEN_GHO,
                priceFeed: 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC,
                stalenessPeriod: 87300,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_GHO,
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
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_yvDAI, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_yvDAI, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: TOKEN_yvDAI, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_yvDAI, trusted: false, reserve: false})
        );

        // ------------------------ yvUSDC ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_yvUSDC, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_yvUSDC, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_yvUSDC, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_yvUSDC, trusted: false, reserve: false})
        );

        // ------------------------ yvUSDC_e ------------------------
        yearnPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_yvUSDC_e, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_yvUSDC_e, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_yvUSDC_e, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_yvUSDC_e, trusted: false, reserve: false})
        );

        // ------------------------ yvUSDT ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_yvUSDT, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_yvUSDT, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_yvUSDT, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_yvUSDT, trusted: false, reserve: false})
        );

        // ------------------------ yvWETH ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_yvWETH, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_yvWETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_yvWETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_yvWETH, trusted: false, reserve: false})
        );

        // ------------------------ yvWBTC ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_yvWBTC, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_yvWBTC, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_yvWBTC, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_yvWBTC, trusted: false, reserve: false})
        );

        // ------------------------ yvOP ------------------------
        yearnPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_yvOP, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_yvOP, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: TOKEN_yvOP, trusted: false, reserve: false}));
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_yvOP, trusted: false, reserve: false})
        );

        // ------------------------ 3Crv ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3Crv,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_3CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN__3Crv,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "3Crv",
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
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3Crv,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_3CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN__3Crv,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "3Crv",
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
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3Crv,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_3CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN__3Crv,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "3Crv",
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
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3Crv,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_3CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[8453].push(
            RedStonePriceFeedData({
                token: TOKEN__3Crv,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "3Crv",
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

        // ------------------------ crvFRAX ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvFRAX,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_crvFRAX,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "crvFRAX",
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
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvFRAX,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_crvFRAX,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "crvFRAX",
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
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvFRAX,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN_crvFRAX,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "crvFRAX",
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
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvFRAX,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_USDC),
                pool: Contracts.CURVE_FRAX_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[8453].push(
            RedStonePriceFeedData({
                token: TOKEN_crvFRAX,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "crvFRAX",
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

        // ------------------------ steCRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_steCRV,
                assets: TokensLib.arrayOf(TOKEN_STETH, TOKEN_WETH),
                pool: Contracts.CURVE_STETH_GATEWAY,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_steCRV,
                assets: TokensLib.arrayOf(TOKEN_STETH, TOKEN_WETH),
                pool: Contracts.CURVE_STETH_GATEWAY,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_steCRV,
                assets: TokensLib.arrayOf(TOKEN_STETH, TOKEN_WETH),
                pool: Contracts.CURVE_STETH_GATEWAY,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_steCRV,
                assets: TokensLib.arrayOf(TOKEN_STETH, TOKEN_WETH),
                pool: Contracts.CURVE_STETH_GATEWAY,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ FRAX3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAX3CRV,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAX3CRV,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAX3CRV,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAX3CRV,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ LUSD3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_LUSD3CRV,
                assets: TokensLib.arrayOf(TOKEN_LUSD, TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_LUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_LUSD3CRV,
                assets: TokensLib.arrayOf(TOKEN_LUSD, TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_LUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_LUSD3CRV,
                assets: TokensLib.arrayOf(TOKEN_LUSD, TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_LUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_LUSD3CRV,
                assets: TokensLib.arrayOf(TOKEN_LUSD, TOKEN_DAI, TOKEN_USDC, TOKEN_USDT),
                pool: Contracts.CURVE_LUSD_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvPlain3andSUSD ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvPlain3andSUSD,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC, TOKEN_USDT, TOKEN_sUSD),
                pool: Contracts.CURVE_SUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvPlain3andSUSD,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC, TOKEN_USDT, TOKEN_sUSD),
                pool: Contracts.CURVE_SUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvPlain3andSUSD,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC, TOKEN_USDT, TOKEN_sUSD),
                pool: Contracts.CURVE_SUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvPlain3andSUSD,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC, TOKEN_USDT, TOKEN_sUSD),
                pool: Contracts.CURVE_SUSD_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ gusd3CRV ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_gusd3CRV, trusted: true, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_gusd3CRV, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_gusd3CRV, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_gusd3CRV, trusted: true, reserve: false})
        );

        // ------------------------ USDeUSDC ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDeUSDC,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_USDC),
                pool: Contracts.CURVE_USDE_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDeUSDC,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_USDC),
                pool: Contracts.CURVE_USDE_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDeUSDC,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_USDC),
                pool: Contracts.CURVE_USDE_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDeUSDC,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_USDC),
                pool: Contracts.CURVE_USDE_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ USDeDAI ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDeDAI,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_DAI),
                pool: Contracts.CURVE_USDE_DAI_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDeDAI,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_DAI),
                pool: Contracts.CURVE_USDE_DAI_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDeDAI,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_DAI),
                pool: Contracts.CURVE_USDE_DAI_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDeDAI,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_DAI),
                pool: Contracts.CURVE_USDE_DAI_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ MtEthena ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_MtEthena, trusted: true, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_MtEthena, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_MtEthena, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_MtEthena, trusted: true, reserve: false})
        );

        // ------------------------ GHOUSDe ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_GHOUSDe,
                assets: TokensLib.arrayOf(TOKEN_GHO, TOKEN_USDe),
                pool: Contracts.CURVE_GHO_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_GHOUSDe,
                assets: TokensLib.arrayOf(TOKEN_GHO, TOKEN_USDe),
                pool: Contracts.CURVE_GHO_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_GHOUSDe,
                assets: TokensLib.arrayOf(TOKEN_GHO, TOKEN_USDe),
                pool: Contracts.CURVE_GHO_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_GHOUSDe,
                assets: TokensLib.arrayOf(TOKEN_GHO, TOKEN_USDe),
                pool: Contracts.CURVE_GHO_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ FRAXUSDe ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAXUSDe,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_USDe),
                pool: Contracts.CURVE_FRAX_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAXUSDe,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_USDe),
                pool: Contracts.CURVE_FRAX_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAXUSDe,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_USDe),
                pool: Contracts.CURVE_FRAX_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAXUSDe,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_USDe),
                pool: Contracts.CURVE_FRAX_USDE_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ USDecrvUSD ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDecrvUSD,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_crvUSD),
                pool: Contracts.CURVE_USDE_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDecrvUSD,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_crvUSD),
                pool: Contracts.CURVE_USDE_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDecrvUSD,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_crvUSD),
                pool: Contracts.CURVE_USDE_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDecrvUSD,
                assets: TokensLib.arrayOf(TOKEN_USDe, TOKEN_crvUSD),
                pool: Contracts.CURVE_USDE_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ FRAXsDAI ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAXsDAI,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_sDAI),
                pool: Contracts.CURVE_FRAX_SDAI_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAXsDAI,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_sDAI),
                pool: Contracts.CURVE_FRAX_SDAI_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAXsDAI,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_sDAI),
                pool: Contracts.CURVE_FRAX_SDAI_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_FRAXsDAI,
                assets: TokensLib.arrayOf(TOKEN_FRAX, TOKEN_sDAI),
                pool: Contracts.CURVE_FRAX_SDAI_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ DOLAsUSDe ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_DOLAsUSDe,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_sUSDe),
                pool: Contracts.CURVE_DOLA_SUSDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_DOLAsUSDe,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_sUSDe),
                pool: Contracts.CURVE_DOLA_SUSDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_DOLAsUSDe,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_sUSDe),
                pool: Contracts.CURVE_DOLA_SUSDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_DOLAsUSDe,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_sUSDe),
                pool: Contracts.CURVE_DOLA_SUSDE_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvCRVETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvCRVETH,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_CRV),
                pool: Contracts.CURVE_CRVETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvCRVETH,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_CRV),
                pool: Contracts.CURVE_CRVETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvCRVETH,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_CRV),
                pool: Contracts.CURVE_CRVETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvCRVETH,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_CRV),
                pool: Contracts.CURVE_CRVETH_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvCVXETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvCVXETH,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_CVX),
                pool: Contracts.CURVE_CVXETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvCVXETH,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_CVX),
                pool: Contracts.CURVE_CVXETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvCVXETH,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_CVX),
                pool: Contracts.CURVE_CVXETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvCVXETH,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_CVX),
                pool: Contracts.CURVE_CVXETH_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDTWBTCWETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(TOKEN_USDT, TOKEN_WBTC, TOKEN_WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(TOKEN_USDT, TOKEN_WBTC, TOKEN_WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(TOKEN_USDT, TOKEN_WBTC, TOKEN_WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDTWBTCWETH,
                assets: TokensLib.arrayOf(TOKEN_USDT, TOKEN_WBTC, TOKEN_WETH),
                pool: Contracts.CURVE_3CRYPTO_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ LDOETH ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_LDOETH,
                assets: TokensLib.arrayOf(TOKEN_LDO, TOKEN_WETH),
                pool: Contracts.CURVE_LDOETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_LDOETH,
                assets: TokensLib.arrayOf(TOKEN_LDO, TOKEN_WETH),
                pool: Contracts.CURVE_LDOETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_LDOETH,
                assets: TokensLib.arrayOf(TOKEN_LDO, TOKEN_WETH),
                pool: Contracts.CURVE_LDOETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_LDOETH,
                assets: TokensLib.arrayOf(TOKEN_LDO, TOKEN_WETH),
                pool: Contracts.CURVE_LDOETH_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSD ------------------------
        boundedPriceFeedsByNetwork[1].push(
            BoundedPriceFeedData({
                token: TOKEN_crvUSD,
                priceFeed: 0xEEf0C605546958c1f899b6fB336C20671f9cD49F,
                stalenessPeriod: 87300,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_crvUSD,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "crvUSD",
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
                token: TOKEN_crvUSD,
                priceFeed: 0x0a32255dd4BB6177C994bAAc73E0606fDD568f66,
                stalenessPeriod: 86520,
                upperBound: 104000000,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_crvUSD,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "crvUSD",
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

        // ------------------------ crvUSDUSDC ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ crvUsUSDe ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_CRVUSD_SUSDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_CRVUSD_SUSDE_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_CRVUSD_SUSDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_CRVUSD_SUSDE_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_CRVUSD_SUSDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_CRVUSD_SUSDE_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_CRVUSD_SUSDE_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_CRVUSD_SUSDE_POOL,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ scrvUsUSDe ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_scrvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_scrvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_LLAMA_THENA_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_scrvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_scrvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_LLAMA_THENA_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_scrvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_scrvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_LLAMA_THENA_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_scrvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_scrvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_LLAMA_THENA_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_scrvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_scrvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_LLAMA_THENA_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_scrvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_scrvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_LLAMA_THENA_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_scrvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_scrvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_LLAMA_THENA_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_scrvUsUSDe,
                assets: TokensLib.arrayOf(TOKEN_scrvUSD, TOKEN_sUSDe),
                pool: Contracts.CURVE_LLAMA_THENA_POOL,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ crvUSDUSDT ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: true
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ crvUSDFRAX ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDFRAX,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDFRAX,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDFRAX,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDFRAX,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_FRAX),
                pool: Contracts.CURVE_CRVUSD_FRAX_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ wstETHCRV ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_wstETHCRV, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_wstETHCRV, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_wstETHCRV, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_wstETHCRV, trusted: false, reserve: false})
        );

        // ------------------------ crvUSDETHCRV ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDETHCRV,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_WETH, TOKEN_CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDETHCRV,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_WETH, TOKEN_CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDETHCRV,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_WETH, TOKEN_CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDETHCRV,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_WETH, TOKEN_CRV),
                pool: Contracts.CURVE_TRI_CRV_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ rETH_f ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_rETH_f,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_rETH_f,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_rETH_f,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_rETH_f,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                pool: Contracts.CURVE_RETH_ETH_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ DOLAFRAXBP3CRV_f ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_DOLAFRAXBP3CRV_f,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_crvFRAX),
                pool: Contracts.CURVE_DOLA_FRAXBP_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_DOLAFRAXBP3CRV_f,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_crvFRAX),
                pool: Contracts.CURVE_DOLA_FRAXBP_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_DOLAFRAXBP3CRV_f,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_crvFRAX),
                pool: Contracts.CURVE_DOLA_FRAXBP_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_DOLAFRAXBP3CRV_f,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_crvFRAX),
                pool: Contracts.CURVE_DOLA_FRAXBP_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDDOLA_f ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDDOLA_f,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_crvUSD),
                pool: Contracts.CURVE_DOLA_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDDOLA_f,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_crvUSD),
                pool: Contracts.CURVE_DOLA_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDDOLA_f,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_crvUSD),
                pool: Contracts.CURVE_DOLA_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDDOLA_f,
                assets: TokensLib.arrayOf(TOKEN_DOLA, TOKEN_crvUSD),
                pool: Contracts.CURVE_DOLA_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ pufETHwstE ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_pufETHwstE, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_pufETHwstE, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_pufETHwstE, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_pufETHwstE, trusted: false, reserve: false})
        );

        // ------------------------ GHOcrvUSD ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_GHOcrvUSD,
                assets: TokensLib.arrayOf(TOKEN_GHO, TOKEN_crvUSD),
                pool: Contracts.CURVE_GHO_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_GHOcrvUSD,
                assets: TokensLib.arrayOf(TOKEN_GHO, TOKEN_crvUSD),
                pool: Contracts.CURVE_GHO_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_GHOcrvUSD,
                assets: TokensLib.arrayOf(TOKEN_GHO, TOKEN_crvUSD),
                pool: Contracts.CURVE_GHO_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_GHOcrvUSD,
                assets: TokensLib.arrayOf(TOKEN_GHO, TOKEN_crvUSD),
                pool: Contracts.CURVE_GHO_CRVUSD_POOL,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ 2CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN__2CRV,
                assets: TokensLib.arrayOf(TOKEN_USDC_e, TOKEN_USDT),
                pool: Contracts.CURVE_2CRV_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN__2CRV,
                assets: TokensLib.arrayOf(TOKEN_USDC_e, TOKEN_USDT),
                pool: Contracts.CURVE_2CRV_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN__2CRV,
                assets: TokensLib.arrayOf(TOKEN_USDC_e, TOKEN_USDT),
                pool: Contracts.CURVE_2CRV_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN__2CRV,
                assets: TokensLib.arrayOf(TOKEN_USDC_e, TOKEN_USDT),
                pool: Contracts.CURVE_2CRV_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ 3c-crvUSD ------------------------
        curveCryptoPriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3c_crvUSD,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_WBTC, TOKEN_WETH),
                pool: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3c_crvUSD,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_WBTC, TOKEN_WETH),
                pool: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3c_crvUSD,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_WBTC, TOKEN_WETH),
                pool: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curveCryptoPriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3c_crvUSD,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_WBTC, TOKEN_WETH),
                pool: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDC ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDC,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC),
                pool: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDC_e ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDC_e,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC_e),
                pool: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDC_e,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC_e),
                pool: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDC_e,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC_e),
                pool: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDC_e,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDC_e),
                pool: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ USDEUSDC ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDEUSDC,
                assets: TokensLib.arrayOf(TOKEN_USDC, TOKEN_USDe),
                pool: Contracts.CURVE_USDE_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDEUSDC,
                assets: TokensLib.arrayOf(TOKEN_USDC, TOKEN_USDe),
                pool: Contracts.CURVE_USDE_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDEUSDC,
                assets: TokensLib.arrayOf(TOKEN_USDC, TOKEN_USDe),
                pool: Contracts.CURVE_USDE_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_USDEUSDC,
                assets: TokensLib.arrayOf(TOKEN_USDC, TOKEN_USDe),
                pool: Contracts.CURVE_USDE_USDC_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ ezETHWETH ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETHWETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETHWETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETHWETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETHWETH, trusted: false, reserve: false})
        );

        // ------------------------ ezpzETH ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_ezpzETH, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_ezpzETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_ezpzETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_ezpzETH, trusted: false, reserve: false})
        );

        // ------------------------ LBTCWBTC ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_LBTCWBTC, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_LBTCWBTC, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_LBTCWBTC, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_LBTCWBTC, trusted: false, reserve: false})
        );

        // ------------------------ eBTCWBTC ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_eBTCWBTC, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_eBTCWBTC, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_eBTCWBTC, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_eBTCWBTC, trusted: false, reserve: false})
        );

        // ------------------------ TriBTC ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_TriBTC, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_TriBTC, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(SingeTokenPriceFeedData({token: TOKEN_TriBTC, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_TriBTC, trusted: false, reserve: false})
        );

        // ------------------------ 3CRV ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3CRV,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC_e, TOKEN_USDT),
                pool: Contracts.CURVE_3CRV_POOL_OP,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3CRV,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC_e, TOKEN_USDT),
                pool: Contracts.CURVE_3CRV_POOL_OP,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3CRV,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC_e, TOKEN_USDT),
                pool: Contracts.CURVE_3CRV_POOL_OP,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN__3CRV,
                assets: TokensLib.arrayOf(TOKEN_DAI, TOKEN_USDC_e, TOKEN_USDT),
                pool: Contracts.CURVE_3CRV_POOL_OP,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ crvUSDT ------------------------
        curvePriceFeedsByNetwork[1].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[42161].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[10].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );
        curvePriceFeedsByNetwork[8453].push(
            CurvePriceFeedData({
                lpToken: TOKEN_crvUSDT,
                assets: TokensLib.arrayOf(TOKEN_crvUSD, TOKEN_USDT),
                pool: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ yvCurve_stETH ------------------------
        yearnPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_yvCurve_stETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_yvCurve_stETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_yvCurve_stETH, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_yvCurve_stETH, trusted: false, reserve: false})
        );

        // ------------------------ yvCurve_FRAX ------------------------
        yearnPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_yvCurve_FRAX, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_yvCurve_FRAX, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_yvCurve_FRAX, trusted: false, reserve: false})
        );
        yearnPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_yvCurve_FRAX, trusted: false, reserve: false})
        );

        // ------------------------ cvx3Crv ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvx3Crv,
                tokenHasSamePriceFeed: TOKEN__3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvx3Crv,
                tokenHasSamePriceFeed: TOKEN__3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvx3Crv,
                tokenHasSamePriceFeed: TOKEN__3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvx3Crv,
                tokenHasSamePriceFeed: TOKEN__3Crv,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvFRAX,
                tokenHasSamePriceFeed: TOKEN_crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvFRAX,
                tokenHasSamePriceFeed: TOKEN_crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvFRAX,
                tokenHasSamePriceFeed: TOKEN_crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvFRAX,
                tokenHasSamePriceFeed: TOKEN_crvFRAX,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxsteCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxsteCRV,
                tokenHasSamePriceFeed: TOKEN_steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxsteCRV,
                tokenHasSamePriceFeed: TOKEN_steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxsteCRV,
                tokenHasSamePriceFeed: TOKEN_steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxsteCRV,
                tokenHasSamePriceFeed: TOKEN_steCRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxFRAX3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxFRAX3CRV,
                tokenHasSamePriceFeed: TOKEN_FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxFRAX3CRV,
                tokenHasSamePriceFeed: TOKEN_FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxFRAX3CRV,
                tokenHasSamePriceFeed: TOKEN_FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxFRAX3CRV,
                tokenHasSamePriceFeed: TOKEN_FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxLUSD3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxLUSD3CRV,
                tokenHasSamePriceFeed: TOKEN_LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxLUSD3CRV,
                tokenHasSamePriceFeed: TOKEN_LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxLUSD3CRV,
                tokenHasSamePriceFeed: TOKEN_LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxLUSD3CRV,
                tokenHasSamePriceFeed: TOKEN_LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvPlain3andSUSD ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: TOKEN_crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: TOKEN_crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: TOKEN_crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: TOKEN_crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxgusd3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxgusd3CRV,
                tokenHasSamePriceFeed: TOKEN_gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxgusd3CRV,
                tokenHasSamePriceFeed: TOKEN_gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxgusd3CRV,
                tokenHasSamePriceFeed: TOKEN_gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxgusd3CRV,
                tokenHasSamePriceFeed: TOKEN_gusd3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvCRVETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvCRVETH,
                tokenHasSamePriceFeed: TOKEN_crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvCRVETH,
                tokenHasSamePriceFeed: TOKEN_crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvCRVETH,
                tokenHasSamePriceFeed: TOKEN_crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvCRVETH,
                tokenHasSamePriceFeed: TOKEN_crvCRVETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvCVXETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvCVXETH,
                tokenHasSamePriceFeed: TOKEN_crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvCVXETH,
                tokenHasSamePriceFeed: TOKEN_crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvCVXETH,
                tokenHasSamePriceFeed: TOKEN_crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvCVXETH,
                tokenHasSamePriceFeed: TOKEN_crvCVXETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDTWBTCWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: TOKEN_crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: TOKEN_crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: TOKEN_crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: TOKEN_crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxLDOETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxLDOETH,
                tokenHasSamePriceFeed: TOKEN_LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxLDOETH,
                tokenHasSamePriceFeed: TOKEN_LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxLDOETH,
                tokenHasSamePriceFeed: TOKEN_LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxLDOETH,
                tokenHasSamePriceFeed: TOKEN_LDOETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDUSDC ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDFRAX,
                tokenHasSamePriceFeed: TOKEN_crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDFRAX,
                tokenHasSamePriceFeed: TOKEN_crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDFRAX,
                tokenHasSamePriceFeed: TOKEN_crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDFRAX,
                tokenHasSamePriceFeed: TOKEN_crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDETHCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: TOKEN_crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: TOKEN_crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: TOKEN_crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: TOKEN_crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxGHOcrvUSD ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxGHOcrvUSD,
                tokenHasSamePriceFeed: TOKEN_GHOcrvUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxGHOcrvUSD,
                tokenHasSamePriceFeed: TOKEN_GHOcrvUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxGHOcrvUSD,
                tokenHasSamePriceFeed: TOKEN_GHOcrvUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxGHOcrvUSD,
                tokenHasSamePriceFeed: TOKEN_GHOcrvUSD,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvx3Crv ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvx3Crv,
                tokenHasSamePriceFeed: TOKEN__3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvx3Crv,
                tokenHasSamePriceFeed: TOKEN__3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvx3Crv,
                tokenHasSamePriceFeed: TOKEN__3Crv,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvx3Crv,
                tokenHasSamePriceFeed: TOKEN__3Crv,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvFRAX,
                tokenHasSamePriceFeed: TOKEN_crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvFRAX,
                tokenHasSamePriceFeed: TOKEN_crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvFRAX,
                tokenHasSamePriceFeed: TOKEN_crvFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvFRAX,
                tokenHasSamePriceFeed: TOKEN_crvFRAX,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxsteCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxsteCRV,
                tokenHasSamePriceFeed: TOKEN_steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxsteCRV,
                tokenHasSamePriceFeed: TOKEN_steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxsteCRV,
                tokenHasSamePriceFeed: TOKEN_steCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxsteCRV,
                tokenHasSamePriceFeed: TOKEN_steCRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxFRAX3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxFRAX3CRV,
                tokenHasSamePriceFeed: TOKEN_FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxFRAX3CRV,
                tokenHasSamePriceFeed: TOKEN_FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxFRAX3CRV,
                tokenHasSamePriceFeed: TOKEN_FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxFRAX3CRV,
                tokenHasSamePriceFeed: TOKEN_FRAX3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxLUSD3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxLUSD3CRV,
                tokenHasSamePriceFeed: TOKEN_LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxLUSD3CRV,
                tokenHasSamePriceFeed: TOKEN_LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxLUSD3CRV,
                tokenHasSamePriceFeed: TOKEN_LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxLUSD3CRV,
                tokenHasSamePriceFeed: TOKEN_LUSD3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvPlain3andSUSD ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: TOKEN_crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: TOKEN_crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: TOKEN_crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvPlain3andSUSD,
                tokenHasSamePriceFeed: TOKEN_crvPlain3andSUSD,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxgusd3CRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxgusd3CRV,
                tokenHasSamePriceFeed: TOKEN_gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxgusd3CRV,
                tokenHasSamePriceFeed: TOKEN_gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxgusd3CRV,
                tokenHasSamePriceFeed: TOKEN_gusd3CRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxgusd3CRV,
                tokenHasSamePriceFeed: TOKEN_gusd3CRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvCRVETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvCRVETH,
                tokenHasSamePriceFeed: TOKEN_crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvCRVETH,
                tokenHasSamePriceFeed: TOKEN_crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvCRVETH,
                tokenHasSamePriceFeed: TOKEN_crvCRVETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvCRVETH,
                tokenHasSamePriceFeed: TOKEN_crvCRVETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvCVXETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvCVXETH,
                tokenHasSamePriceFeed: TOKEN_crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvCVXETH,
                tokenHasSamePriceFeed: TOKEN_crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvCVXETH,
                tokenHasSamePriceFeed: TOKEN_crvCVXETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvCVXETH,
                tokenHasSamePriceFeed: TOKEN_crvCVXETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvUSDTWBTCWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: TOKEN_crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: TOKEN_crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: TOKEN_crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDTWBTCWETH,
                tokenHasSamePriceFeed: TOKEN_crvUSDTWBTCWETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxLDOETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxLDOETH,
                tokenHasSamePriceFeed: TOKEN_LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxLDOETH,
                tokenHasSamePriceFeed: TOKEN_LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxLDOETH,
                tokenHasSamePriceFeed: TOKEN_LDOETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxLDOETH,
                tokenHasSamePriceFeed: TOKEN_LDOETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvUSDUSDC ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: true
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: true
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: true
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDC,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDC,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ stkcvxcrvUSDUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: true
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: true
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: true
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDUSDT,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ stkcvxcrvUSDFRAX ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDFRAX,
                tokenHasSamePriceFeed: TOKEN_crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDFRAX,
                tokenHasSamePriceFeed: TOKEN_crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDFRAX,
                tokenHasSamePriceFeed: TOKEN_crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDFRAX,
                tokenHasSamePriceFeed: TOKEN_crvUSDFRAX,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxcrvUSDETHCRV ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: TOKEN_crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: TOKEN_crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: TOKEN_crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxcrvUSDETHCRV,
                tokenHasSamePriceFeed: TOKEN_crvUSDETHCRV,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkcvxGHOcrvUSD ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxGHOcrvUSD,
                tokenHasSamePriceFeed: TOKEN_GHOcrvUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxGHOcrvUSD,
                tokenHasSamePriceFeed: TOKEN_GHOcrvUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxGHOcrvUSD,
                tokenHasSamePriceFeed: TOKEN_GHOcrvUSD,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkcvxGHOcrvUSD,
                tokenHasSamePriceFeed: TOKEN_GHOcrvUSD,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cvxcrvUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_cvxcrvUSDT,
                tokenHasSamePriceFeed: TOKEN_crvUSDT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ B_80BAL_20WETH ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_B_80BAL_20WETH,
                assets: TokensLib.arrayOf(TOKEN_BAL, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_B_80BAL_20WETH,
                assets: TokensLib.arrayOf(TOKEN_BAL, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_B_80BAL_20WETH,
                assets: TokensLib.arrayOf(TOKEN_BAL, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_B_80BAL_20WETH,
                assets: TokensLib.arrayOf(TOKEN_BAL, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ 50WETH_50AURA ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN__50WETH_50AURA, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN__50WETH_50AURA, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN__50WETH_50AURA, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN__50WETH_50AURA, trusted: false, reserve: false})
        );

        // ------------------------ USDC_DAI_USDT ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_USDC_DAI_USDT,
                assets: TokensLib.arrayOf(TOKEN_USDC, TOKEN_DAI, TOKEN_USDT),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_USDC_DAI_USDT,
                assets: TokensLib.arrayOf(TOKEN_USDC, TOKEN_DAI, TOKEN_USDT),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_USDC_DAI_USDT,
                assets: TokensLib.arrayOf(TOKEN_USDC, TOKEN_DAI, TOKEN_USDT),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_USDC_DAI_USDT,
                assets: TokensLib.arrayOf(TOKEN_USDC, TOKEN_DAI, TOKEN_USDT),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ B_rETH_STABLE ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_B_rETH_STABLE,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_B_rETH_STABLE,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_B_rETH_STABLE,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_B_rETH_STABLE,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ weETH_rETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_weETH_rETH,
                assets: TokensLib.arrayOf(TOKEN_weETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_weETH_rETH,
                assets: TokensLib.arrayOf(TOKEN_weETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_weETH_rETH,
                assets: TokensLib.arrayOf(TOKEN_weETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_weETH_rETH,
                assets: TokensLib.arrayOf(TOKEN_weETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ osETH_wETH_BPT ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_osETH_wETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_osETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_osETH_wETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_osETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_osETH_wETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_osETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_osETH_wETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_osETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ ezETH_WETH_BPT ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETH_WETH_BPT, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETH_WETH_BPT, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETH_WETH_BPT, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETH_WETH_BPT, trusted: false, reserve: false})
        );

        // ------------------------ sUSDe_USDC_BPT ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_sUSDe_USDC_BPT, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_sUSDe_USDC_BPT, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_sUSDe_USDC_BPT, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_sUSDe_USDC_BPT, trusted: false, reserve: false})
        );

        // ------------------------ trenSTETH ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_trenSTETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_trenSTETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_trenSTETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_trenSTETH, trusted: false, reserve: false})
        );

        // ------------------------ weETH_ezETH_rswETH ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_weETH_ezETH_rswETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_weETH_ezETH_rswETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_weETH_ezETH_rswETH, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_weETH_ezETH_rswETH, trusted: false, reserve: false})
        );

        // ------------------------ rsETH_WETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rsETH_WETH,
                assets: TokensLib.arrayOf(TOKEN_rsETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rsETH_WETH,
                assets: TokensLib.arrayOf(TOKEN_rsETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rsETH_WETH,
                assets: TokensLib.arrayOf(TOKEN_rsETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rsETH_WETH,
                assets: TokensLib.arrayOf(TOKEN_rsETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ rsETH_wETH_Arb ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rsETH_wETH_Arb,
                assets: TokensLib.arrayOf(TOKEN_rsETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rsETH_wETH_Arb,
                assets: TokensLib.arrayOf(TOKEN_rsETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rsETH_wETH_Arb,
                assets: TokensLib.arrayOf(TOKEN_rsETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rsETH_wETH_Arb,
                assets: TokensLib.arrayOf(TOKEN_rsETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ BPT_rETH_ETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_rETH_ETH,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_rETH_ETH,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_rETH_ETH,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_rETH_ETH,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ BPT_WSTETH_ETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_WSTETH_ETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ BPT_ROAD ------------------------
        balancerWeightedLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_ROAD,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_OP, TOKEN_USDC),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_ROAD,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_OP, TOKEN_USDC),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_ROAD,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_OP, TOKEN_USDC),
                trusted: false,
                reserve: false
            })
        );
        balancerWeightedLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_BPT_ROAD,
                assets: TokensLib.arrayOf(TOKEN_WETH, TOKEN_OP, TOKEN_USDC),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ ECLP_wstETH_WETH ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_ECLP_wstETH_WETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_ECLP_wstETH_WETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_ECLP_wstETH_WETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_ECLP_wstETH_WETH, trusted: true, reserve: false})
        );

        // ------------------------ wstETH_WETH_BPT ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_WETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_WETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_WETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_WETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ wstETH_rETH_cbETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_rETH_cbETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_rETH, TOKEN_cbETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_rETH_cbETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_rETH, TOKEN_cbETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_rETH_cbETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_rETH, TOKEN_cbETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_rETH_cbETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_rETH, TOKEN_cbETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ cbETH_rETH_wstETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_cbETH_rETH_wstETH,
                assets: TokensLib.arrayOf(TOKEN_cbETH, TOKEN_wstETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_cbETH_rETH_wstETH,
                assets: TokensLib.arrayOf(TOKEN_cbETH, TOKEN_wstETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_cbETH_rETH_wstETH,
                assets: TokensLib.arrayOf(TOKEN_cbETH, TOKEN_wstETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_cbETH_rETH_wstETH,
                assets: TokensLib.arrayOf(TOKEN_cbETH, TOKEN_wstETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ wstETH_rETH_sfrxETH ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_rETH_sfrxETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_rETH, TOKEN_sfrxETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_rETH_sfrxETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_rETH, TOKEN_sfrxETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_rETH_sfrxETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_rETH, TOKEN_sfrxETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_wstETH_rETH_sfrxETH,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_rETH, TOKEN_sfrxETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ rETH_WETH_BPT_deprecated ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rETH_WETH_BPT_deprecated,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rETH_WETH_BPT_deprecated,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rETH_WETH_BPT_deprecated,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rETH_WETH_BPT_deprecated,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ rETH_wETH_BPT ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rETH_wETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rETH_wETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rETH_wETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_rETH_wETH_BPT,
                assets: TokensLib.arrayOf(TOKEN_rETH, TOKEN_WETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ bpt_ethtri ------------------------
        balancerStableLPPriceFeedsByNetwork[1].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_bpt_ethtri,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_sfrxETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[42161].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_bpt_ethtri,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_sfrxETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[10].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_bpt_ethtri,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_sfrxETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );
        balancerStableLPPriceFeedsByNetwork[8453].push(
            BalancerLPPriceFeedData({
                lpToken: TOKEN_bpt_ethtri,
                assets: TokensLib.arrayOf(TOKEN_wstETH, TOKEN_sfrxETH, TOKEN_rETH),
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ 33AURA_33ARB_33BAL ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN__33AURA_33ARB_33BAL, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN__33AURA_33ARB_33BAL, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN__33AURA_33ARB_33BAL, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN__33AURA_33ARB_33BAL, trusted: true, reserve: false})
        );

        // ------------------------ ezETH_wstETH ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETH_wstETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETH_wstETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETH_wstETH, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_ezETH_wstETH, trusted: true, reserve: false})
        );

        // ------------------------ GHO_USDT_USDC ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_GHO_USDT_USDC, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_GHO_USDT_USDC, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[10].push(
            SingeTokenPriceFeedData({token: TOKEN_GHO_USDT_USDC, trusted: true, reserve: false})
        );
        zeroPriceFeedsByNetwork[8453].push(
            SingeTokenPriceFeedData({token: TOKEN_GHO_USDT_USDC, trusted: true, reserve: false})
        );

        // ------------------------ dDAI ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dDAI, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dDAI, trusted: false, reserve: false})
        );

        // ------------------------ dUSDC ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dUSDC, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dUSDC, trusted: false, reserve: false})
        );

        // ------------------------ dWBTC ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dWBTC, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dWBTC, trusted: false, reserve: false})
        );

        // ------------------------ dWETH ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dWETH, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dWETH, trusted: false, reserve: false})
        );

        // ------------------------ dwstETH ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dwstETH, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dwstETH, trusted: false, reserve: false})
        );

        // ------------------------ dFRAX ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dFRAX, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dFRAX, trusted: false, reserve: false})
        );

        // ------------------------ dUSDCV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dUSDCV3, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dUSDCV3, trusted: false, reserve: false})
        );

        // ------------------------ dUSDC_eV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_dUSDC_eV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dUSDC_eV3, trusted: false, reserve: false})
        );

        // ------------------------ dWBTCV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dWBTCV3, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dWBTCV3, trusted: false, reserve: false})
        );

        // ------------------------ dWETHV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dWETHV3, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dWETHV3, trusted: false, reserve: false})
        );

        // ------------------------ dcrvUSDV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_dcrvUSDV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dcrvUSDV3, trusted: false, reserve: false})
        );

        // ------------------------ dDOLAV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dDOLAV3, trusted: false, reserve: false}));

        // ------------------------ sdUSDCV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_sdUSDCV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_sdUSDCV3, trusted: false, reserve: false})
        );

        // ------------------------ sdUSDC_eV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_sdUSDC_eV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_sdUSDC_eV3, trusted: false, reserve: false})
        );

        // ------------------------ sdWBTCV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_sdWBTCV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_sdWBTCV3, trusted: false, reserve: false})
        );

        // ------------------------ sdWETHV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_sdWETHV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_sdWETHV3, trusted: false, reserve: false})
        );

        // ------------------------ sdWETHV3_OLD ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_sdWETHV3_OLD, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_sdWETHV3_OLD, trusted: false, reserve: false})
        );

        // ------------------------ dUSDTV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dUSDTV3, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dUSDTV3, trusted: false, reserve: false})
        );

        // ------------------------ dGHOV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dGHOV3, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dGHOV3, trusted: false, reserve: false})
        );

        // ------------------------ dDAIV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_dDAIV3, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_dDAIV3, trusted: false, reserve: false})
        );

        // ------------------------ sdUSDTV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_sdUSDTV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_sdUSDTV3, trusted: false, reserve: false})
        );

        // ------------------------ sdGHOV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_sdGHOV3, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_sdGHOV3, trusted: false, reserve: false})
        );

        // ------------------------ sdDAIV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_sdDAIV3, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_sdDAIV3, trusted: false, reserve: false})
        );

        // ------------------------ sdcrvUSDV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_sdcrvUSDV3, trusted: false, reserve: false})
        );
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_sdcrvUSDV3, trusted: false, reserve: false})
        );

        // ------------------------ sdDOLAV3 ------------------------
        zeroPriceFeedsByNetwork[1].push(
            SingeTokenPriceFeedData({token: TOKEN_sdDOLAV3, trusted: false, reserve: false})
        );

        // ------------------------ GEAR ------------------------
        zeroPriceFeedsByNetwork[1].push(SingeTokenPriceFeedData({token: TOKEN_GEAR, trusted: false, reserve: false}));
        zeroPriceFeedsByNetwork[42161].push(
            SingeTokenPriceFeedData({token: TOKEN_GEAR, trusted: false, reserve: false})
        );

        // ------------------------ aDAI ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: TOKEN_aDAI, tokenHasSamePriceFeed: TOKEN_DAI, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: TOKEN_aDAI, tokenHasSamePriceFeed: TOKEN_DAI, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: TOKEN_aDAI, tokenHasSamePriceFeed: TOKEN_DAI, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({token: TOKEN_aDAI, tokenHasSamePriceFeed: TOKEN_DAI, trusted: false, reserve: false})
        );

        // ------------------------ aUSDC ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: TOKEN_aUSDC, tokenHasSamePriceFeed: TOKEN_USDC, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: TOKEN_aUSDC, tokenHasSamePriceFeed: TOKEN_USDC, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: TOKEN_aUSDC, tokenHasSamePriceFeed: TOKEN_USDC, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({token: TOKEN_aUSDC, tokenHasSamePriceFeed: TOKEN_USDC, trusted: false, reserve: false})
        );

        // ------------------------ aUSDT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: TOKEN_aUSDT, tokenHasSamePriceFeed: TOKEN_USDT, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: TOKEN_aUSDT, tokenHasSamePriceFeed: TOKEN_USDT, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: TOKEN_aUSDT, tokenHasSamePriceFeed: TOKEN_USDT, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({token: TOKEN_aUSDT, tokenHasSamePriceFeed: TOKEN_USDT, trusted: false, reserve: false})
        );

        // ------------------------ aWETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({token: TOKEN_aWETH, tokenHasSamePriceFeed: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({token: TOKEN_aWETH, tokenHasSamePriceFeed: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({token: TOKEN_aWETH, tokenHasSamePriceFeed: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({token: TOKEN_aWETH, tokenHasSamePriceFeed: TOKEN_WETH, trusted: false, reserve: false})
        );

        // ------------------------ waDAI ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waDAI, underlying: TOKEN_aDAI, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waDAI, underlying: TOKEN_aDAI, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waDAI, underlying: TOKEN_aDAI, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waDAI, underlying: TOKEN_aDAI, trusted: false, reserve: false})
        );

        // ------------------------ waUSDC ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waUSDC, underlying: TOKEN_aUSDC, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waUSDC, underlying: TOKEN_aUSDC, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waUSDC, underlying: TOKEN_aUSDC, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waUSDC, underlying: TOKEN_aUSDC, trusted: false, reserve: false})
        );

        // ------------------------ waUSDT ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waUSDT, underlying: TOKEN_aUSDT, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waUSDT, underlying: TOKEN_aUSDT, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waUSDT, underlying: TOKEN_aUSDT, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waUSDT, underlying: TOKEN_aUSDT, trusted: false, reserve: false})
        );

        // ------------------------ waWETH ------------------------
        wrappedAaveV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waWETH, underlying: TOKEN_aWETH, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waWETH, underlying: TOKEN_aWETH, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waWETH, underlying: TOKEN_aWETH, trusted: false, reserve: false})
        );
        wrappedAaveV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_waWETH, underlying: TOKEN_aWETH, trusted: false, reserve: false})
        );

        // ------------------------ cDAI ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cDAI, underlying: TOKEN_DAI, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cDAI, underlying: TOKEN_DAI, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cDAI, underlying: TOKEN_DAI, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cDAI, underlying: TOKEN_DAI, trusted: false, reserve: false})
        );

        // ------------------------ cUSDC ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cUSDC, underlying: TOKEN_USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cUSDC, underlying: TOKEN_USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cUSDC, underlying: TOKEN_USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cUSDC, underlying: TOKEN_USDC, trusted: false, reserve: false})
        );

        // ------------------------ cUSDT ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cUSDT, underlying: TOKEN_USDT, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cUSDT, underlying: TOKEN_USDT, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cUSDT, underlying: TOKEN_USDT, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cUSDT, underlying: TOKEN_USDT, trusted: false, reserve: false})
        );

        // ------------------------ cLINK ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cLINK, underlying: TOKEN_LINK, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cLINK, underlying: TOKEN_LINK, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cLINK, underlying: TOKEN_LINK, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cLINK, underlying: TOKEN_LINK, trusted: false, reserve: false})
        );

        // ------------------------ cETH ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_cETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );

        // ------------------------ fUSDC ------------------------
        compoundV2PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_fUSDC, underlying: TOKEN_USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_fUSDC, underlying: TOKEN_USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_fUSDC, underlying: TOKEN_USDC, trusted: false, reserve: false})
        );
        compoundV2PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_fUSDC, underlying: TOKEN_USDC, trusted: false, reserve: false})
        );

        // ------------------------ MKR ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN_MKR,
                priceFeed: 0xec1D1B3b0443256cc3860e24a46F108e699484Aa,
                stalenessPeriod: 4500,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_MKR,
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
                token: TOKEN_MKR,
                priceFeed: 0xdE9f0894670c4EFcacF370426F10C3AD2Cdf147e,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ RPL ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN_RPL,
                priceFeed: 0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: TOKEN_RPL,
                priceFeed: 0xF0b7159BbFc341Cc41E7Cb182216F62c6d40533D,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ APE ------------------------
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN_APE,
                priceFeed: 0xD10aBbC76679a20055E167BB80A24ac851b37056,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: false
            })
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_APE,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "APE",
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
                token: TOKEN_APE,
                priceFeed: 0x221912ce795669f628c51c69b7d0873eDA9C03bB,
                stalenessPeriod: 86520,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ sDAI ------------------------
        erc4626PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sDAI, underlying: TOKEN_DAI, trusted: false, reserve: false})
        );
        redStonePriceFeedsByNetwork[1].push(
            RedStonePriceFeedData({
                token: TOKEN_sDAI,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "sDAI",
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
        erc4626PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sDAI, underlying: TOKEN_DAI, trusted: false, reserve: false})
        );
        redStonePriceFeedsByNetwork[42161].push(
            RedStonePriceFeedData({
                token: TOKEN_sDAI,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "sDAI",
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
        erc4626PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sDAI, underlying: TOKEN_DAI, trusted: false, reserve: false})
        );
        redStonePriceFeedsByNetwork[10].push(
            RedStonePriceFeedData({
                token: TOKEN_sDAI,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "sDAI",
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
        erc4626PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sDAI, underlying: TOKEN_DAI, trusted: false, reserve: false})
        );
        redStonePriceFeedsByNetwork[8453].push(
            RedStonePriceFeedData({
                token: TOKEN_sDAI,
                dataServiceId: "redstone-primary-prod",
                dataFeedId: "sDAI",
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

        // ------------------------ sUSDe ------------------------
        erc4626PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDe, underlying: TOKEN_USDe, trusted: false, reserve: false})
        );
        chainlinkPriceFeedsByNetwork[1].push(
            ChainlinkPriceFeedData({
                token: TOKEN_sUSDe,
                priceFeed: 0xb99D174ED06c83588Af997c8859F93E83dD4733f,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: true
            })
        );
        erc4626PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDe, underlying: TOKEN_USDe, trusted: false, reserve: false})
        );
        chainlinkPriceFeedsByNetwork[42161].push(
            ChainlinkPriceFeedData({
                token: TOKEN_sUSDe,
                priceFeed: 0xb99D174ED06c83588Af997c8859F93E83dD4733f,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: true
            })
        );
        erc4626PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDe, underlying: TOKEN_USDe, trusted: false, reserve: false})
        );
        chainlinkPriceFeedsByNetwork[10].push(
            ChainlinkPriceFeedData({
                token: TOKEN_sUSDe,
                priceFeed: 0xb99D174ED06c83588Af997c8859F93E83dD4733f,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: true
            })
        );
        erc4626PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDe, underlying: TOKEN_USDe, trusted: false, reserve: false})
        );
        chainlinkPriceFeedsByNetwork[8453].push(
            ChainlinkPriceFeedData({
                token: TOKEN_sUSDe,
                priceFeed: 0xb99D174ED06c83588Af997c8859F93E83dD4733f,
                stalenessPeriod: 87300,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ YieldETH ------------------------
        erc4626PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_YieldETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_YieldETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_YieldETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_YieldETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );

        // ------------------------ sUSDS ------------------------
        erc4626PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDS, underlying: TOKEN_USDS, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDS, underlying: TOKEN_USDS, trusted: false, reserve: true})
        );
        erc4626PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDS, underlying: TOKEN_USDS, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDS, underlying: TOKEN_USDS, trusted: false, reserve: true})
        );
        erc4626PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDS, underlying: TOKEN_USDS, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDS, underlying: TOKEN_USDS, trusted: false, reserve: true})
        );
        erc4626PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDS, underlying: TOKEN_USDS, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_sUSDS, underlying: TOKEN_USDS, trusted: false, reserve: true})
        );

        // ------------------------ scrvUSD ------------------------
        erc4626PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_scrvUSD, underlying: TOKEN_crvUSD, trusted: false, reserve: false})
        );
        erc4626PriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_scrvUSD, underlying: TOKEN_crvUSD, trusted: false, reserve: true})
        );

        // ------------------------ auraB_rETH_STABLE ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auraB_rETH_STABLE,
                tokenHasSamePriceFeed: TOKEN_B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auraB_rETH_STABLE,
                tokenHasSamePriceFeed: TOKEN_B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auraB_rETH_STABLE,
                tokenHasSamePriceFeed: TOKEN_B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auraB_rETH_STABLE,
                tokenHasSamePriceFeed: TOKEN_B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraB_rETH_STABLE_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auraB_rETH_STABLE_vault,
                tokenHasSamePriceFeed: TOKEN_B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auraB_rETH_STABLE_vault,
                tokenHasSamePriceFeed: TOKEN_B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auraB_rETH_STABLE_vault,
                tokenHasSamePriceFeed: TOKEN_B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auraB_rETH_STABLE_vault,
                tokenHasSamePriceFeed: TOKEN_B_rETH_STABLE,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraweETH_rETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auraweETH_rETH,
                tokenHasSamePriceFeed: TOKEN_weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auraweETH_rETH,
                tokenHasSamePriceFeed: TOKEN_weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auraweETH_rETH,
                tokenHasSamePriceFeed: TOKEN_weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auraweETH_rETH,
                tokenHasSamePriceFeed: TOKEN_weETH_rETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraweETH_rETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auraweETH_rETH_vault,
                tokenHasSamePriceFeed: TOKEN_weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auraweETH_rETH_vault,
                tokenHasSamePriceFeed: TOKEN_weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auraweETH_rETH_vault,
                tokenHasSamePriceFeed: TOKEN_weETH_rETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auraweETH_rETH_vault,
                tokenHasSamePriceFeed: TOKEN_weETH_rETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraosETH_wETH_BPT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auraosETH_wETH_BPT,
                tokenHasSamePriceFeed: TOKEN_osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auraosETH_wETH_BPT,
                tokenHasSamePriceFeed: TOKEN_osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auraosETH_wETH_BPT,
                tokenHasSamePriceFeed: TOKEN_osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auraosETH_wETH_BPT,
                tokenHasSamePriceFeed: TOKEN_osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurarETH_wETH_BPT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_aurarETH_wETH_BPT,
                tokenHasSamePriceFeed: TOKEN_rETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_aurarETH_wETH_BPT,
                tokenHasSamePriceFeed: TOKEN_rETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_aurarETH_wETH_BPT,
                tokenHasSamePriceFeed: TOKEN_rETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_aurarETH_wETH_BPT,
                tokenHasSamePriceFeed: TOKEN_rETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auracbETH_rETH_wstETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auracbETH_rETH_wstETH,
                tokenHasSamePriceFeed: TOKEN_cbETH_rETH_wstETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auracbETH_rETH_wstETH,
                tokenHasSamePriceFeed: TOKEN_cbETH_rETH_wstETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auracbETH_rETH_wstETH,
                tokenHasSamePriceFeed: TOKEN_cbETH_rETH_wstETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auracbETH_rETH_wstETH,
                tokenHasSamePriceFeed: TOKEN_cbETH_rETH_wstETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurawstETH_rETH_sfrxETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_rETH_sfrxETH,
                tokenHasSamePriceFeed: TOKEN_wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_rETH_sfrxETH,
                tokenHasSamePriceFeed: TOKEN_wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_rETH_sfrxETH,
                tokenHasSamePriceFeed: TOKEN_wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_rETH_sfrxETH,
                tokenHasSamePriceFeed: TOKEN_wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurawstETH_WETH_BPT ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_WETH_BPT,
                tokenHasSamePriceFeed: TOKEN_wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_WETH_BPT,
                tokenHasSamePriceFeed: TOKEN_wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_WETH_BPT,
                tokenHasSamePriceFeed: TOKEN_wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_WETH_BPT,
                tokenHasSamePriceFeed: TOKEN_wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraosETH_wETH_BPT_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auraosETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auraosETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auraosETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auraosETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_osETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraBPT_rETH_ETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_rETH_ETH,
                tokenHasSamePriceFeed: TOKEN_BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_rETH_ETH,
                tokenHasSamePriceFeed: TOKEN_BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_rETH_ETH,
                tokenHasSamePriceFeed: TOKEN_BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_rETH_ETH,
                tokenHasSamePriceFeed: TOKEN_BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraBPT_rETH_ETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_rETH_ETH_vault,
                tokenHasSamePriceFeed: TOKEN_BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_rETH_ETH_vault,
                tokenHasSamePriceFeed: TOKEN_BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_rETH_ETH_vault,
                tokenHasSamePriceFeed: TOKEN_BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_rETH_ETH_vault,
                tokenHasSamePriceFeed: TOKEN_BPT_rETH_ETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraBPT_WSTETH_ETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_WSTETH_ETH,
                tokenHasSamePriceFeed: TOKEN_BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_WSTETH_ETH,
                tokenHasSamePriceFeed: TOKEN_BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_WSTETH_ETH,
                tokenHasSamePriceFeed: TOKEN_BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_WSTETH_ETH,
                tokenHasSamePriceFeed: TOKEN_BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auraBPT_WSTETH_ETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_WSTETH_ETH_vault,
                tokenHasSamePriceFeed: TOKEN_BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_WSTETH_ETH_vault,
                tokenHasSamePriceFeed: TOKEN_BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_WSTETH_ETH_vault,
                tokenHasSamePriceFeed: TOKEN_BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auraBPT_WSTETH_ETH_vault,
                tokenHasSamePriceFeed: TOKEN_BPT_WSTETH_ETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurarETH_wETH_BPT_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_aurarETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_rETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_aurarETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_rETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_aurarETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_rETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_aurarETH_wETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_rETH_wETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ auracbETH_rETH_wstETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_auracbETH_rETH_wstETH_vault,
                tokenHasSamePriceFeed: TOKEN_cbETH_rETH_wstETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_auracbETH_rETH_wstETH_vault,
                tokenHasSamePriceFeed: TOKEN_cbETH_rETH_wstETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_auracbETH_rETH_wstETH_vault,
                tokenHasSamePriceFeed: TOKEN_cbETH_rETH_wstETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_auracbETH_rETH_wstETH_vault,
                tokenHasSamePriceFeed: TOKEN_cbETH_rETH_wstETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurawstETH_rETH_sfrxETH_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_rETH_sfrxETH_vault,
                tokenHasSamePriceFeed: TOKEN_wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_rETH_sfrxETH_vault,
                tokenHasSamePriceFeed: TOKEN_wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_rETH_sfrxETH_vault,
                tokenHasSamePriceFeed: TOKEN_wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_rETH_sfrxETH_vault,
                tokenHasSamePriceFeed: TOKEN_wstETH_rETH_sfrxETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ aurawstETH_WETH_BPT_vault ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_aurawstETH_WETH_BPT_vault,
                tokenHasSamePriceFeed: TOKEN_wstETH_WETH_BPT,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ zpufETH ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_zpufETH,
                tokenHasSamePriceFeed: TOKEN_pufETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_zpufETH,
                tokenHasSamePriceFeed: TOKEN_pufETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_zpufETH,
                tokenHasSamePriceFeed: TOKEN_pufETH,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_zpufETH,
                tokenHasSamePriceFeed: TOKEN_pufETH,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ stkUSDS ------------------------
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkUSDS,
                tokenHasSamePriceFeed: TOKEN_USDS,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_stkUSDS,
                tokenHasSamePriceFeed: TOKEN_USDS,
                trusted: false,
                reserve: true
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkUSDS,
                tokenHasSamePriceFeed: TOKEN_USDS,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_stkUSDS,
                tokenHasSamePriceFeed: TOKEN_USDS,
                trusted: false,
                reserve: true
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkUSDS,
                tokenHasSamePriceFeed: TOKEN_USDS,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_stkUSDS,
                tokenHasSamePriceFeed: TOKEN_USDS,
                trusted: false,
                reserve: true
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkUSDS,
                tokenHasSamePriceFeed: TOKEN_USDS,
                trusted: false,
                reserve: false
            })
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_stkUSDS,
                tokenHasSamePriceFeed: TOKEN_USDS,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ steakLRT ------------------------
        mellowLRTPriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_steakLRT, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_steakLRT,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_steakLRT, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_steakLRT,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_steakLRT, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_steakLRT,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_steakLRT, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_steakLRT,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ Re7LRT ------------------------
        mellowLRTPriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_Re7LRT, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_Re7LRT,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_Re7LRT, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_Re7LRT,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_Re7LRT, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_Re7LRT,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_Re7LRT, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_Re7LRT,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ amphrETH ------------------------
        mellowLRTPriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_amphrETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_amphrETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_amphrETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_amphrETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_amphrETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_amphrETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_amphrETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_amphrETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ rstETH ------------------------
        mellowLRTPriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_rstETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_rstETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_rstETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_rstETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_rstETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_rstETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_rstETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_rstETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ pzETH ------------------------
        mellowLRTPriceFeedsByNetwork[1].push(
            GenericLPPriceFeedData({lpToken: TOKEN_pzETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[1].push(
            TheSamePriceFeedData({
                token: TOKEN_pzETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[42161].push(
            GenericLPPriceFeedData({lpToken: TOKEN_pzETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[42161].push(
            TheSamePriceFeedData({
                token: TOKEN_pzETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[10].push(
            GenericLPPriceFeedData({lpToken: TOKEN_pzETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[10].push(
            TheSamePriceFeedData({
                token: TOKEN_pzETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );
        mellowLRTPriceFeedsByNetwork[8453].push(
            GenericLPPriceFeedData({lpToken: TOKEN_pzETH, underlying: TOKEN_WETH, trusted: false, reserve: false})
        );
        theSamePriceFeedsByNetwork[8453].push(
            TheSamePriceFeedData({
                token: TOKEN_pzETH,
                tokenHasSamePriceFeed: TOKEN_wstETH,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ PT_rsETH_26SEP2024 ------------------------
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_rsETH_26SEP2024,
                underlying: TOKEN_rsETH,
                market: 0x6b4740722e46048874d84306B2877600ABCea3Ae,
                twapWindow: 3600,
                trusted: false,
                reserve: false
            })
        );

        // ------------------------ PT_sUSDe_26DEC2024 ------------------------
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_sUSDe_26DEC2024,
                underlying: TOKEN_USDe,
                market: 0xa0ab94DeBB3cC9A7eA77f3205ba4AB23276feD08,
                twapWindow: 1800,
                trusted: false,
                reserve: false
            })
        );
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_sUSDe_26DEC2024,
                underlying: TOKEN_USDe,
                market: 0xa0ab94DeBB3cC9A7eA77f3205ba4AB23276feD08,
                twapWindow: 1800,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ PT_eETH_26DEC2024 ------------------------
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_eETH_26DEC2024,
                underlying: TOKEN_WETH,
                market: 0x7d372819240D14fB477f17b964f95F33BeB4c704,
                twapWindow: 1800,
                trusted: false,
                reserve: false
            })
        );
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_eETH_26DEC2024,
                underlying: TOKEN_WETH,
                market: 0x7d372819240D14fB477f17b964f95F33BeB4c704,
                twapWindow: 1800,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ PT_ezETH_26DEC2024 ------------------------
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_ezETH_26DEC2024,
                underlying: TOKEN_WETH,
                market: 0xD8F12bCDE578c653014F27379a6114F67F0e445f,
                twapWindow: 1800,
                trusted: false,
                reserve: false
            })
        );
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_ezETH_26DEC2024,
                underlying: TOKEN_WETH,
                market: 0xD8F12bCDE578c653014F27379a6114F67F0e445f,
                twapWindow: 1800,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ PT_eBTC_26DEC2024 ------------------------
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_eBTC_26DEC2024,
                underlying: TOKEN_WBTC,
                market: 0x36d3ca43ae7939645C306E26603ce16e39A89192,
                twapWindow: 1800,
                trusted: false,
                reserve: false
            })
        );
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_eBTC_26DEC2024,
                underlying: TOKEN_WBTC,
                market: 0x36d3ca43ae7939645C306E26603ce16e39A89192,
                twapWindow: 1800,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ PT_corn_solvBTC_BBN_26DEC2024 ------------------------
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_corn_solvBTC_BBN_26DEC2024,
                underlying: TOKEN_WBTC,
                market: 0xEb4d3057738b9Ed930F451Be473C1CCC42988384,
                twapWindow: 1800,
                trusted: false,
                reserve: false
            })
        );
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_corn_solvBTC_BBN_26DEC2024,
                underlying: TOKEN_WBTC,
                market: 0xEb4d3057738b9Ed930F451Be473C1CCC42988384,
                twapWindow: 1800,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ PT_corn_pumpBTC_26DEC2024 ------------------------
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_corn_pumpBTC_26DEC2024,
                underlying: TOKEN_WBTC,
                market: 0xf8208fB52BA80075aF09840A683143C22DC5B4dd,
                twapWindow: 1800,
                trusted: false,
                reserve: false
            })
        );
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_corn_pumpBTC_26DEC2024,
                underlying: TOKEN_WBTC,
                market: 0xf8208fB52BA80075aF09840A683143C22DC5B4dd,
                twapWindow: 1800,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ PT_cornLBTC_26DEC2024 ------------------------
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_cornLBTC_26DEC2024,
                underlying: TOKEN_WBTC,
                market: 0xCaE62858DB831272A03768f5844cbe1B40bB381f,
                twapWindow: 1800,
                trusted: false,
                reserve: false
            })
        );
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_cornLBTC_26DEC2024,
                underlying: TOKEN_WBTC,
                market: 0xCaE62858DB831272A03768f5844cbe1B40bB381f,
                twapWindow: 1800,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ PT_LBTC_27MAR2025 ------------------------
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_LBTC_27MAR2025,
                underlying: TOKEN_WBTC,
                market: 0x70B70Ac0445C3eF04E314DFdA6caafd825428221,
                twapWindow: 1800,
                trusted: false,
                reserve: false
            })
        );
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_LBTC_27MAR2025,
                underlying: TOKEN_WBTC,
                market: 0x70B70Ac0445C3eF04E314DFdA6caafd825428221,
                twapWindow: 1800,
                trusted: false,
                reserve: true
            })
        );

        // ------------------------ PT_corn_eBTC_27MAR2025 ------------------------
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_corn_eBTC_27MAR2025,
                underlying: TOKEN_WBTC,
                market: 0x2C71Ead7ac9AE53D05F8664e77031d4F9ebA064B,
                twapWindow: 1800,
                trusted: false,
                reserve: false
            })
        );
        pendlePriceFeedsByNetwork[1].push(
            PendlePriceFeedData({
                token: TOKEN_PT_corn_eBTC_27MAR2025,
                underlying: TOKEN_WBTC,
                market: 0x2C71Ead7ac9AE53D05F8664e77031d4F9ebA064B,
                twapWindow: 1800,
                trusted: false,
                reserve: true
            })
        );
    }

    function chainlinkPriceFeeds(uint256 index) external view returns (ChainlinkPriceFeedData memory) {
        return chainlinkPriceFeedsByNetwork[block.chainid][index];
    }
}
