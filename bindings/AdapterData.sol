// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

import "./Tokens.sol";
import {Contracts} from "./SupportedContracts.sol";
import {AdapterType} from "./AdapterType.sol";

struct SimpleAdapter {
    Contracts targetContract;
    AdapterType adapterType;
}

struct CurveAdapter {
    Contracts targetContract;
    AdapterType adapterType;
    uint256 lpToken;
    Contracts basePool;
}

struct CurveStETHAdapter {
    Contracts curveETHGateway;
    AdapterType adapterType;
    uint256 lpToken;
}

struct CurveWrapper {
    Contracts targetContract;
    AdapterType adapterType;
    uint256 lpToken;
    uint256 nCoins;
}

struct ConvexBasePoolAdapter {
    Contracts targetContract;
    AdapterType adapterType;
    uint256 stakedToken;
}

struct StakingRewardsAdapter {
    Contracts targetContract;
    AdapterType adapterType;
    uint256 stakedToken;
}

contract AdapterData {
    SimpleAdapter[] simpleAdapters;
    CurveAdapter[] curveAdapters;
    CurveStETHAdapter[] curveStEthAdapters;
    CurveWrapper[] curveWrappers;
    ConvexBasePoolAdapter[] convexBasePoolAdapters;
    StakingRewardsAdapter[] stakingRewardsAdapters;

    constructor() {
        // $GENERATE_HERE$
    }
}
