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

    uint16[] public connectedNetworks;

    uint256 public immutable chainId;

    constructor() {
        // ---------------- Networks ---------------------
        connectedNetworks.push(1);
        connectedNetworks.push(42161);
        connectedNetworks.push(10);
        usdcByNetwork[1] = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        usdcByNetwork[42161] = 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8;
        usdcByNetwork[10] = 0x7F5c764cBc14f9669B88837ca1490cCa17c31607;

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
        address tokenToCheck = usdcByNetwork[_networkId];

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
