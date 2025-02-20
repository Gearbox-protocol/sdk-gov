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
        // $GENERATE_HERE$
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
