// SPDX-License-Identifier: UNLICENSED
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox Foundation, 2023
pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";
import {Contracts} from "./ContractType.sol";

struct ContractData {
    Contracts id;
    address addr;
    string name;
}

interface ISupportedContracts {
    function addressOf(Contracts c) external view returns (address);

    function nameOf(Contracts c) external view returns (string memory);

    function contractIndex(address) external view returns (Contracts);

    function contractCount() external view returns (uint256);
}

contract SupportedContracts is Test, ISupportedContracts {
    mapping(Contracts => address) public override addressOf;
    mapping(Contracts => string) public override nameOf;
    mapping(address => Contracts) public override contractIndex;
    mapping(uint256 => ContractData[]) public contractDataByNetwork;

    uint256 public override contractCount;

    constructor(uint256 _chainId) {
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.UNISWAP_V2_ROUTER,
                addr: 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D,
                name: "UNISWAP_V2_ROUTER"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.UNISWAP_V3_ROUTER,
                addr: 0xE592427A0AEce92De3Edee1F18E0157C05861564,
                name: "UNISWAP_V3_ROUTER"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.SUSHISWAP_ROUTER,
                addr: 0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F,
                name: "SUSHISWAP_ROUTER"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.FRAXSWAP_ROUTER,
                addr: 0xC14d550632db8592D1243Edc8B95b0Ad06703867,
                name: "FRAXSWAP_ROUTER"
            })
        );

        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_3CRV_POOL,
                addr: 0xbEbc44782C7dB0a1A60Cb6fe97d0b483032FF1C7,
                name: "CURVE_3CRV_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_FRAX_USDC_POOL,
                addr: 0xDcEF968d416a41Cdac0ED8702fAC8128A64241A2,
                name: "CURVE_FRAX_USDC_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_STETH_GATEWAY,
                addr: 0xEf0D72C594b28252BF7Ea2bfbF098792430815b1,
                name: "CURVE_STETH_GATEWAY"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_FRAX_POOL,
                addr: 0xd632f22692FaC7611d2AA1C0D552930D43CAEd3B,
                name: "CURVE_FRAX_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_LUSD_POOL,
                addr: 0xEd279fDD11cA84bEef15AF5D39BB4d4bEE23F0cA,
                name: "CURVE_LUSD_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_SUSD_POOL,
                addr: 0xA5407eAE9Ba41422680e2e00537571bcC53efBfD,
                name: "CURVE_SUSD_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_SUSD_DEPOSIT,
                addr: 0xFCBa3E75865d2d561BE8D220616520c171F12851,
                name: "CURVE_SUSD_DEPOSIT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_GUSD_POOL,
                addr: 0x4f062658EaAF2C1ccf8C8e36D6824CDf41167956,
                name: "CURVE_GUSD_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_MIM_POOL,
                addr: 0x5a6A4D54456819380173272A5E8E9B9904BdF41B,
                name: "CURVE_MIM_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_OHMFRAXBP_POOL,
                addr: 0xFc1e8bf3E81383Ef07Be24c3FD146745719DE48D,
                name: "CURVE_OHMFRAXBP_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_CRVETH_POOL,
                addr: 0x8301AE4fc9c624d1D396cbDAa1ed877821D7C511,
                name: "CURVE_CRVETH_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_CVXETH_POOL,
                addr: 0xB576491F1E6e5E62f1d8F26062Ee822B40B0E0d4,
                name: "CURVE_CVXETH_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_3CRYPTO_POOL,
                addr: 0xf5f5B97624542D72A9E06f04804Bf81baA15e2B4,
                name: "CURVE_3CRYPTO_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_LDOETH_POOL,
                addr: 0x9409280DC1e6D33AB7A8C6EC03e5763FB61772B5,
                name: "CURVE_LDOETH_POOL"
            })
        );

        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_USDE_USDC_POOL,
                addr: 0x02950460E2b9529D0E00284A5fA2d7bDF3fA4d72,
                name: "CURVE_USDE_USDC_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_FRAX_USDE_POOL,
                addr: 0x5dc1BF6f1e983C0b21EfB003c105133736fA0743,
                name: "CURVE_FRAX_USDE_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_USDE_CRVUSD_POOL,
                addr: 0xF55B0f6F2Da5ffDDb104b58a60F2862745960442,
                name: "CURVE_USDE_CRVUSD_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_USDE_DAI_POOL,
                addr: 0xF36a4BA50C603204c3FC6d2dA8b78A7b69CBC67d,
                name: "CURVE_USDE_DAI_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_SDAI_SUSDE_POOL,
                addr: 0x167478921b907422F8E88B43C4Af2B8BEa278d3A,
                name: "CURVE_SDAI_SUSDE_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_GHO_USDE_POOL,
                addr: 0x670a72e6D22b0956C0D2573288F82DCc5d6E3a61,
                name: "CURVE_GHO_USDE_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_GEAR_POOL,
                addr: 0x0E9B5B092caD6F1c5E6bc7f89Ffe1abb5c95F1C2,
                name: "CURVE_GEAR_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_CRVUSD_USDC_POOL,
                addr: 0x4DEcE678ceceb27446b35C672dC7d61F30bAD69E,
                name: "CURVE_CRVUSD_USDC_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_CRVUSD_USDT_POOL,
                addr: 0x390f3595bCa2Df7d23783dFd126427CCeb997BF4,
                name: "CURVE_CRVUSD_USDT_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_CRVUSD_FRAX_POOL,
                addr: 0x0CD6f267b2086bea681E922E19D40512511BE538,
                name: "CURVE_CRVUSD_FRAX_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_TRI_CRV_POOL,
                addr: 0x4eBdF703948ddCEA3B11f675B4D1Fba9d2414A14,
                name: "CURVE_TRI_CRV_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CURVE_RETH_ETH_POOL,
                addr: 0x0f3159811670c117c372428D4E69AC32325e4D0F,
                name: "CURVE_RETH_ETH_POOL"
            })
        );

        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.YEARN_DAI_VAULT,
                addr: 0xdA816459F1AB5631232FE5e97a05BBBb94970c95,
                name: "YEARN_DAI_VAULT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.YEARN_USDC_VAULT,
                addr: 0xa354F35829Ae975e850e23e9615b11Da1B3dC4DE,
                name: "YEARN_USDC_VAULT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.YEARN_WETH_VAULT,
                addr: 0xa258C4606Ca8206D8aA700cE2143D7db854D168c,
                name: "YEARN_WETH_VAULT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.YEARN_WBTC_VAULT,
                addr: 0xA696a63cc78DfFa1a63E9E50587C197387FF6C7E,
                name: "YEARN_WBTC_VAULT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.YEARN_USDT_VAULT,
                addr: 0x3B27F92C0e212C671EA351827EDF93DB27cc0c65,
                name: "YEARN_USDT_VAULT"
            })
        );

        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.YEARN_CURVE_FRAX_VAULT,
                addr: 0xB4AdA607B9d6b2c9Ee07A275e9616B84AC560139,
                name: "YEARN_CURVE_FRAX_VAULT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.YEARN_CURVE_STETH_VAULT,
                addr: 0xdCD90C7f6324cfa40d7169ef80b12031770B4325,
                name: "YEARN_CURVE_STETH_VAULT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.MAKER_DSR_VAULT,
                addr: 0x83F20F44975D03b1b09e64809B757c47f942BEeA,
                name: "MAKER_DSR_VAULT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.YIELD_ETH_VAULT,
                addr: 0xb5b29320d2Dde5BA5BAFA1EbcD270052070483ec,
                name: "YIELD_ETH_VAULT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.STAKED_USDE_VAULT,
                addr: 0x9D39A5DE30e57443BfF2A8307A4256c8797A3497,
                name: "STAKED_USDE_VAULT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_BOOSTER,
                addr: 0xF403C135812408BFbE8713b5A23a04b3D48AAE31,
                name: "CONVEX_BOOSTER"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_3CRV_POOL,
                addr: 0x689440f2Ff927E1f24c72F1087E1FAF471eCe1c8,
                name: "CONVEX_3CRV_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_FRAX_USDC_POOL,
                addr: 0x7e880867363A7e321f5d260Cade2B0Bb2F717B02,
                name: "CONVEX_FRAX_USDC_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_GUSD_POOL,
                addr: 0x7A7bBf95C44b144979360C3300B54A7D34b44985,
                name: "CONVEX_GUSD_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_SUSD_POOL,
                addr: 0x22eE18aca7F3Ee920D01F25dA85840D12d98E8Ca,
                name: "CONVEX_SUSD_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_STECRV_POOL,
                addr: 0x0A760466E1B4621579a82a39CB56Dda2F4E70f03,
                name: "CONVEX_STECRV_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_FRAX3CRV_POOL,
                addr: 0xB900EF131301B307dB5eFcbed9DBb50A3e209B2e,
                name: "CONVEX_FRAX3CRV_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_LUSD3CRV_POOL,
                addr: 0x2ad92A7aE036a038ff02B96c88de868ddf3f8190,
                name: "CONVEX_LUSD3CRV_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_OHMFRAXBP_POOL,
                addr: 0x27A8c58e3DE84280826d615D80ddb33930383fE9,
                name: "CONVEX_OHMFRAXBP_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_MIM3CRV_POOL,
                addr: 0xFd5AbF66b003881b88567EB9Ed9c651F14Dc4771,
                name: "CONVEX_MIM3CRV_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_CRVETH_POOL,
                addr: 0x085A2054c51eA5c91dbF7f90d65e728c0f2A270f,
                name: "CONVEX_CRVETH_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_CVXETH_POOL,
                addr: 0xb1Fb0BA0676A1fFA83882c7F4805408bA232C1fA,
                name: "CONVEX_CVXETH_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_3CRYPTO_POOL,
                addr: 0xb05262D4aaAA38D0Af4AaB244D446ebDb5afd4A7,
                name: "CONVEX_3CRYPTO_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_LDOETH_POOL,
                addr: 0x8CA990E954611E5E3d2cc51C013fCC372c8c1D38,
                name: "CONVEX_LDOETH_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_CRVUSD_USDC_POOL,
                addr: 0x44D8FaB7CD8b7877D5F79974c2F501aF6E65AbBA,
                name: "CONVEX_CRVUSD_USDC_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_CRVUSD_USDT_POOL,
                addr: 0xD1DdB0a0815fD28932fBb194C84003683AF8a824,
                name: "CONVEX_CRVUSD_USDT_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_CRVUSD_FRAX_POOL,
                addr: 0x3CfB4B26dc96B124D15A6f360503d028cF2a3c00,
                name: "CONVEX_CRVUSD_FRAX_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.CONVEX_TRI_CRV_POOL,
                addr: 0xF956a46DbA1A0a567168db8655bc18E9050C7738,
                name: "CONVEX_TRI_CRV_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.AURA_BOOSTER,
                addr: 0xA57b8d98dAE62B26Ec3bcC4a365338157060B234,
                name: "AURA_BOOSTER"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.AURA_WEETH_RETH_POOL,
                addr: 0x07A319A023859BbD49CC9C38ee891c3EA9283Cc5,
                name: "AURA_WEETH_RETH_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.AURA_OSETH_WETH_POOL,
                addr: 0x5F032f15B4e910252EDaDdB899f7201E89C8cD6b,
                name: "AURA_OSETH_WETH_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.AURA_B_RETH_STABLE_POOL,
                addr: 0xDd1fE5AD401D4777cE89959b7fa587e569Bf125D,
                name: "AURA_B_RETH_STABLE_POOL"
            })
        );

        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.LIDO_STETH_GATEWAY,
                addr: 0x6f4b4aB5142787c05b7aB9A9692A0f46b997C29D,
                name: "LIDO_STETH_GATEWAY"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.LIDO_WSTETH,
                addr: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0,
                name: "LIDO_WSTETH"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.BALANCER_VAULT,
                addr: 0xBA12222222228d8Ba445958a75a0704d566BF2C8,
                name: "BALANCER_VAULT"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.UNIVERSAL_ADAPTER,
                addr: 0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC,
                name: "UNIVERSAL_ADAPTER"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.AAVE_V2_LENDING_POOL,
                addr: 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9,
                name: "AAVE_V2_LENDING_POOL"
            })
        );

        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.COMPOUND_V2_DAI_POOL,
                addr: 0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643,
                name: "COMPOUND_V2_DAI_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.COMPOUND_V2_USDC_POOL,
                addr: 0x39AA39c021dfbaE8faC545936693aC917d5E7563,
                name: "COMPOUND_V2_USDC_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.COMPOUND_V2_USDT_POOL,
                addr: 0xf650C3d88D12dB855b8bf7D11Be6C55A4e07dCC9,
                name: "COMPOUND_V2_USDT_POOL"
            })
        );
        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.COMPOUND_V2_LINK_POOL,
                addr: 0xFAce851a4921ce59e912d19329929CE6da6EB0c7,
                name: "COMPOUND_V2_LINK_POOL"
            })
        );

        contractDataByNetwork[1].push(
            ContractData({
                id: Contracts.FLUX_USDC_POOL,
                addr: 0x465a5a630482f3abD6d3b84B39B29b07214d19e5,
                name: "FLUX_USDC_POOL"
            })
        );
        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.UNISWAP_V3_ROUTER,
                addr: 0xE592427A0AEce92De3Edee1F18E0157C05861564,
                name: "UNISWAP_V3_ROUTER"
            })
        );

        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.CAMELOT_V3_ROUTER,
                addr: 0x1F721E2E82F6676FCE4eA07A5958cF098D339e18,
                name: "CAMELOT_V3_ROUTER"
            })
        );

        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.CURVE_CRVUSD_FRAX_POOL,
                addr: 0x2FE7AE43591E534C256A1594D326e5779E302Ff4,
                name: "CURVE_CRVUSD_FRAX_POOL"
            })
        );

        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.CURVE_2CRV_POOL_ARB,
                addr: 0x7f90122BF0700F9E7e1F688fe926940E8839F353,
                name: "CURVE_2CRV_POOL_ARB"
            })
        );
        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.CURVE_TRICRYPTO_CRVUSD_POOL_ARB,
                addr: 0x82670f35306253222F8a165869B28c64739ac62e,
                name: "CURVE_TRICRYPTO_CRVUSD_POOL_ARB"
            })
        );
        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.CURVE_CRVUSD_USDC_POOL_ARB,
                addr: 0xec090cf6DD891D2d014beA6edAda6e05E025D93d,
                name: "CURVE_CRVUSD_USDC_POOL_ARB"
            })
        );
        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.CURVE_CRVUSD_USDT_POOL_ARB,
                addr: 0x73aF1150F265419Ef8a5DB41908B700C32D49135,
                name: "CURVE_CRVUSD_USDT_POOL_ARB"
            })
        );
        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.CURVE_CRVUSD_USDC_E_POOL_ARB,
                addr: 0x3aDf984c937FA6846E5a24E0A68521Bdaf767cE1,
                name: "CURVE_CRVUSD_USDC_E_POOL_ARB"
            })
        );

        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.AURA_BOOSTER,
                addr: 0x98Ef32edd24e2c92525E59afc4475C1242a30184,
                name: "AURA_BOOSTER"
            })
        );

        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.AURA_RETH_WETH_POOL_ARB,
                addr: 0x129A44AC6ff0f965C907579F96F2eD682E52c84A,
                name: "AURA_RETH_WETH_POOL_ARB"
            })
        );
        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.AURA_WSTETH_WETH_POOL_ARB,
                addr: 0xa7BdaD177D474f946f3cDEB4bcea9d24Cf017471,
                name: "AURA_WSTETH_WETH_POOL_ARB"
            })
        );
        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.AURA_WSTETH_RETH_CBETH_POOL_ARB,
                addr: 0x8cA64Bd82AbFE138E195ce5Cb7268CA285D42245,
                name: "AURA_WSTETH_RETH_CBETH_POOL_ARB"
            })
        );
        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.AURA_WSTETH_RETH_SFRXETH_POOL_ARB,
                addr: 0xa427B131059A503b5fC9C7e1a130585ca3b32e3d,
                name: "AURA_WSTETH_RETH_SFRXETH_POOL_ARB"
            })
        );

        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.BALANCER_VAULT,
                addr: 0xBA12222222228d8Ba445958a75a0704d566BF2C8,
                name: "BALANCER_VAULT"
            })
        );
        contractDataByNetwork[42161].push(
            ContractData({
                id: Contracts.UNIVERSAL_ADAPTER,
                addr: 0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC,
                name: "UNIVERSAL_ADAPTER"
            })
        );

        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.UNISWAP_V3_ROUTER,
                addr: 0xE592427A0AEce92De3Edee1F18E0157C05861564,
                name: "UNISWAP_V3_ROUTER"
            })
        );

        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.FRAXSWAP_ROUTER,
                addr: 0xB9A55F455e46e8D717eEA5E47D2c449416A0437F,
                name: "FRAXSWAP_ROUTER"
            })
        );
        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.VELODROME_V2_ROUTER,
                addr: 0xa062aE8A9c5e11aaA026fc2670B0D65cCc8B2858,
                name: "VELODROME_V2_ROUTER"
            })
        );

        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.CURVE_3CRV_POOL_OP,
                addr: 0x1337BedC9D22ecbe766dF105c9623922A27963EC,
                name: "CURVE_3CRV_POOL_OP"
            })
        );

        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.YEARN_DAI_VAULT,
                addr: 0x65343F414FFD6c97b0f6add33d16F6845Ac22BAc,
                name: "YEARN_DAI_VAULT"
            })
        );
        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.YEARN_USDC_VAULT,
                addr: 0xaD17A225074191d5c8a37B50FdA1AE278a2EE6A2,
                name: "YEARN_USDC_VAULT"
            })
        );
        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.YEARN_WETH_VAULT,
                addr: 0x5B977577Eb8a480f63e11FC615D6753adB8652Ae,
                name: "YEARN_WETH_VAULT"
            })
        );
        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.YEARN_WBTC_VAULT,
                addr: 0x7Edf16076e56FA4c111055fbA1fF5556b8757cFB,
                name: "YEARN_WBTC_VAULT"
            })
        );
        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.YEARN_USDT_VAULT,
                addr: 0xFaee21D0f0Af88EE72BB6d68E54a90E6EC2616de,
                name: "YEARN_USDT_VAULT"
            })
        );
        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.YEARN_OP_VAULT,
                addr: 0x7D2382b1f8Af621229d33464340541Db362B4907,
                name: "YEARN_OP_VAULT"
            })
        );

        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.AURA_BOOSTER,
                addr: 0x98Ef32edd24e2c92525E59afc4475C1242a30184,
                name: "AURA_BOOSTER"
            })
        );

        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.AURA_BPT_RETH_ETH_POOL,
                addr: 0x61ac9315a1Ae71633E95Fb35601B59180eC8d61d,
                name: "AURA_BPT_RETH_ETH_POOL"
            })
        );
        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.AURA_BPT_WSTETH_ETH_POOL,
                addr: 0xe110b862E4D076596707892c0C5163BC183eb161,
                name: "AURA_BPT_WSTETH_ETH_POOL"
            })
        );

        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.BALANCER_VAULT,
                addr: 0xBA12222222228d8Ba445958a75a0704d566BF2C8,
                name: "BALANCER_VAULT"
            })
        );
        contractDataByNetwork[10].push(
            ContractData({
                id: Contracts.UNIVERSAL_ADAPTER,
                addr: 0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC,
                name: "UNIVERSAL_ADAPTER"
            })
        );

        contractDataByNetwork[8453].push(
            ContractData({
                id: Contracts.YEARN_DAI_VAULT,
                addr: 0x65343F414FFD6c97b0f6add33d16F6845Ac22BAc,
                name: "YEARN_DAI_VAULT"
            })
        );
        contractDataByNetwork[8453].push(
            ContractData({
                id: Contracts.YEARN_USDC_VAULT,
                addr: 0xaD17A225074191d5c8a37B50FdA1AE278a2EE6A2,
                name: "YEARN_USDC_VAULT"
            })
        );
        contractDataByNetwork[8453].push(
            ContractData({
                id: Contracts.YEARN_WETH_VAULT,
                addr: 0x5B977577Eb8a480f63e11FC615D6753adB8652Ae,
                name: "YEARN_WETH_VAULT"
            })
        );
        contractDataByNetwork[8453].push(
            ContractData({
                id: Contracts.YEARN_WBTC_VAULT,
                addr: 0x7Edf16076e56FA4c111055fbA1fF5556b8757cFB,
                name: "YEARN_WBTC_VAULT"
            })
        );
        contractDataByNetwork[8453].push(
            ContractData({
                id: Contracts.YEARN_USDT_VAULT,
                addr: 0xFaee21D0f0Af88EE72BB6d68E54a90E6EC2616de,
                name: "YEARN_USDT_VAULT"
            })
        );
        contractDataByNetwork[8453].push(
            ContractData({
                id: Contracts.YEARN_OP_VAULT,
                addr: 0x7D2382b1f8Af621229d33464340541Db362B4907,
                name: "YEARN_OP_VAULT"
            })
        );

        contractDataByNetwork[8453].push(
            ContractData({
                id: Contracts.AURA_BPT_RETH_ETH_POOL,
                addr: 0x61ac9315a1Ae71633E95Fb35601B59180eC8d61d,
                name: "AURA_BPT_RETH_ETH_POOL"
            })
        );
        contractDataByNetwork[8453].push(
            ContractData({
                id: Contracts.AURA_BPT_WSTETH_ETH_POOL,
                addr: 0xe110b862E4D076596707892c0C5163BC183eb161,
                name: "AURA_BPT_WSTETH_ETH_POOL"
            })
        );

        ContractData[] storage cd = contractDataByNetwork[_chainId];

        uint256 len = cd.length;
        contractCount = len;
        unchecked {
            for (uint256 i; i < len; ++i) {
                addressOf[cd[i].id] = cd[i].addr;
                nameOf[cd[i].id] = cd[i].name;
                contractIndex[cd[i].addr] = cd[i].id;

                vm.label(cd[i].addr, cd[i].name);
            }
        }
    }
}
