// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

library TokensLib {
    function arrayOf(uint256 t1) external pure returns (uint256[] memory tokensList) {
        tokensList = new uint256[](1);
        tokensList[0] = t1;
    }

    function arrayOf(uint256 t1, uint256 t2) external pure returns (uint256[] memory tokensList) {
        tokensList = new uint256[](2);
        tokensList[0] = t1;
        tokensList[1] = t2;
    }

    function arrayOf(uint256 t1, uint256 t2, uint256 t3) external pure returns (uint256[] memory tokensList) {
        tokensList = new uint256[](3);
        tokensList[0] = t1;
        tokensList[1] = t2;
        tokensList[2] = t3;
    }

    function arrayOf(uint256 t1, uint256 t2, uint256 t3, uint256 t4)
        external
        pure
        returns (uint256[] memory tokensList)
    {
        tokensList = new uint256[](4);
        tokensList[0] = t1;
        tokensList[1] = t2;
        tokensList[2] = t3;
        tokensList[3] = t4;
    }

    function arrayOf(uint256 t1, uint256 t2, uint256 t3, uint256 t4, uint256 t5)
        external
        pure
        returns (uint256[] memory tokensList)
    {
        tokensList = new uint256[](5);
        tokensList[0] = t1;
        tokensList[1] = t2;
        tokensList[2] = t3;
        tokensList[3] = t4;
        tokensList[4] = t5;
    }

    function arrayOf(uint256 t1, uint256 t2, uint256 t3, uint256 t4, uint256 t5, uint256 t6)
        external
        pure
        returns (uint256[] memory tokensList)
    {
        tokensList = new uint256[](6);
        tokensList[0] = t1;
        tokensList[1] = t2;
        tokensList[2] = t3;
        tokensList[3] = t4;
        tokensList[4] = t5;
        tokensList[5] = t6;
    }

    function arrayOf(uint256 t1, uint256 t2, uint256 t3, uint256 t4, uint256 t5, uint256 t6, uint256 t7)
        external
        pure
        returns (uint256[] memory tokensList)
    {
        tokensList = new uint256[](6);
        tokensList[0] = t1;
        tokensList[1] = t2;
        tokensList[2] = t3;
        tokensList[3] = t4;
        tokensList[4] = t5;
        tokensList[5] = t6;
        tokensList[6] = t7;
    }

    function arrayOf(uint256 t1, uint256 t2, uint256 t3, uint256 t4, uint256 t5, uint256 t6, uint256 t7, uint256 t8)
        external
        pure
        returns (uint256[] memory tokensList)
    {
        tokensList = new uint256[](6);
        tokensList[0] = t1;
        tokensList[1] = t2;
        tokensList[2] = t3;
        tokensList[3] = t4;
        tokensList[4] = t5;
        tokensList[5] = t6;
        tokensList[6] = t7;
        tokensList[7] = t8;
    }
}
