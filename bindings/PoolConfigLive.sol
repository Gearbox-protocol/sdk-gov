// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;
import "./Tokens.sol";

struct QuotedTokenParams {
    uint256 token;
    uint16 minRiskRate;
    uint16 maxRate;
    uint96 limit;
}

struct PoolParams {
    uint256 U_optimal;
    uint256 U_reserve;
    uint256 R_base;
    uint256 R_slope1;
    uint256 R_slope2;
    uint256 R_slope3;
    uint256 expectedLiquidityLimit;
    bool supportsQuotas;
    QuotedTokenParams[] quotedTokens;
}

contract PoolConfigLive {
    mapping(uint256 => PoolParams) poolParams;
    uint256[] underlyings;

    constructor() {
        PoolParams storage pp;

        // $GENERATE_HERE$
    }
}
