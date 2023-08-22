// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

import {Tokens} from "./Tokens.sol";
import {Contracts} from "./SupportedContracts.sol";

/// @dev A struct containing parameters for a recognized collateral token in the system
struct CollateralTokenHuman {
    /// @dev Address of the collateral token
    Tokens token;
    /// @dev Address of the liquidation threshold
    uint16 liquidationThreshold;
}

struct BalancerPool {
    bytes32 poolId;
    uint8 status;
}

struct UniswapV2Pair {
    Tokens token0;
    Tokens token1;
    bool whitelisted;
}

struct UniswapV3Pool {
    Tokens token0;
    Tokens token1;
    uint24 fee;
    bool whitelisted;
}

/// @dev A struct representing the initial Credit Manager configuration parameters
struct CreditManagerV3HumanOpts {
    Tokens underlying;
    /// @dev The minimal debt principal amount
    uint128 minBorrowedAmount;
    /// @dev The maximal debt principal amount
    uint128 maxBorrowedAmount;
    /// @dev The initial list of collateral tokens to allow
    CollateralTokenHuman[] collateralTokens;
    /// @dev Address of DegenNFTV2, address(0) if whitelisted mode is not used
    address degenNFT;
    /// @dev Address of BlacklistHelper, address(0) if the underlying is not blacklistable
    address blacklistHelper;
    /// @dev Whether the Credit Manager is connected to an expirable pool (and the CreditFacadeV3 is expirable)
    bool expirable;
    /// @dev Whether to skip normal initialization - used for new Credit Configurators that are deployed for existing CMs
    bool skipInit;
    /// @dev Contracts which should become adapters
    Contracts[] contracts;
    /// @dev List of balancer pools to add to the balancer vault adapter
    BalancerPool[] balancerPools;
    /// @dev List of UniswapV2 pairs to add to the UniswapV2 adapter
    UniswapV2Pair[] uniswapV2Pairs;
    /// @dev List of UniswapV3 pools to add to the UniswapV3 adapter
    UniswapV3Pool[] uniswapV3Pools;
    /// @dev List of pairs to add to the Sushiswap adapter
    UniswapV2Pair[] sushiswapPairs;
}

contract CreditConfigLive {
    mapping(uint256 => CreditManagerV3HumanOpts) creditManagerHumanOpts;
    uint256 numOpts;

    constructor() {
        CreditManagerV3HumanOpts storage cm;

        // $GENERATE_HERE$
    }
}
