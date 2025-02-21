// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";

interface IERC20Check {
    function totalSupply() external view returns (uint256);
}

contract NetworkDetector is Test {
    mapping(uint256 => address) usdcByNetwork;
    mapping(uint256 => address) usdceByNetwork;

    uint16[] public connectedNetworks;

    uint256 public immutable chainId;

    constructor() {
        // ---------------- Networks ---------------------
        connectedNetworks.push(1);
        connectedNetworks.push(42161);
        connectedNetworks.push(10);
        connectedNetworks.push(8453);
        connectedNetworks.push(146);
        usdcByNetwork[1] = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        usdcByNetwork[42161] = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
        usdceByNetwork[42161] = 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8;
        usdcByNetwork[10] = 0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85;
        usdceByNetwork[10] = 0x7F5c764cBc14f9669B88837ca1490cCa17c31607;
        usdcByNetwork[8453] = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913;
        usdceByNetwork[146] = 0x29219dd400f2Bf60E5a23d13Be72B486D4038894;

        chainId = getNetworkId();
    }

    function getNetworkId() internal view returns (uint256) {
        uint256 len = connectedNetworks.length;
        for (uint256 i = 0; i < len; i++) {
            if (checkNetworkId(connectedNetworks[i])) {
                return connectedNetworks[i];
            }
        }

        return block.chainid;
    }

    function checkNetworkId(uint16 _networkId) internal view returns (bool) {
        return _checkToken(usdcByNetwork[_networkId]) || _checkToken(usdceByNetwork[_networkId]);
    }

    function _checkToken(address tokenToCheck) internal view returns (bool) {
        if (!isContract(tokenToCheck)) {
            return false;
        }

        try IERC20Check(tokenToCheck).totalSupply() returns (uint256) {
            return true;
        } catch {
            return false;
        }
    }

    // This method relies on extcodesize/address.code.length, which returns 0
    // for contracts in construction, since the code is only stored at the end
    // of the constructor execution.
    function isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }
}
