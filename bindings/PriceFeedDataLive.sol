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
        // $GENERATE_HERE$
    }

    function chainlinkPriceFeeds(uint256 index) external view returns (ChainlinkPriceFeedData memory) {
        return chainlinkPriceFeedsByNetwork[block.chainid][index];
    }
}
