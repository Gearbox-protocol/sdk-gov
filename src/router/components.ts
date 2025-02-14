export enum RouterProtocols {
  Aave,
  Aura,
  Balancer,
  Compound,
  Convex,
  Curve,
  ERC4626,
  Lido,
  UniswapV2,
  UniswapV3,
  Yearn,
  Velodrome,
  Camelot,
  sUSDe,
  PTsUSDe,
  wstETH,
  Mellow,
  Pendle,
  DaiUsdsSwap,
  SKY,
  LlamaThena,
  BalancerV3,
  Mellow4626,
  ERC4626Swapper,
}

export enum RouterComponent {
  RC_NO_COMPONENT = 0,
  RC_UNISWAP_V2_SWAPPER = 1,
  RC_UNISWAP_V3_SWAPPER = 2,
  RC_CURVE_SWAPPER = 3,
  RC_LIDO_SWAPPER = 4,
  RC_WSTETH_WRAPPER = 5,
  RC_YEARN_DEPOSITOR = 6,
  RC_YEARN_WITHDRAWER = 7,
  RC_CURVE_LP_DEPOSITOR = 8,
  RC_CURVE_LP_WITHDRAWER = 9,
  RC_CONVEX_DEPOSITOR = 10,
  RC_CONVEX_WITHDRAWER = 11,
  RC_SWAP_AGGREGATOR = 12,
  RC_CLOSE_PATH_RESOLVER = 13,
  RC_CURVE_LP_PATH_RESOLVER = 14,
  RC_YEARN_PATH_RESOLVER = 15,
  RC_CONVEX_PATH_RESOLVER = 16,
  RC_BALANCER_SWAPPER = 17,
  RC_ERC4626_DEPOSITOR = 18,
  RC_ERC4626_WITHDRAWER = 19,
  RC_ERC4626_PATH_RESOLVER = 20,
  RC_WRAP_AGGREGATOR = 21,
  RC_AAVE_V2_WRAPPER = 22,
  RC_COMPOUND_V2_WRAPPER = 23,
  RC_BALANCER_LP_DEPOSITOR = 24,
  RC_BALANCER_LP_WITHDRAWER = 25,
  RC_BALANCER_LP_PATH_RESOLVER = 26,
  RC_AURA_DEPOSITOR = 27,
  RC_AURA_WITHDRAWER = 28,
  RC_AURA_PATH_RESOLVER = 29,
  RC_VELODROME_V2_SWAPPER = 30,
  RC_CAMELOT_V3_SWAPPER = 31,
  RC_OVERRIDE_AGGREGATOR = 32,
  RC_SUSDE_OVERRIDER = 33,
  RC_WSTETH_SWAPPER = 34,
  RC_BATCH_LIQUIDATION_ESTIMATOR = 35,
  RC_MELLOW_VAULT_SWAPPER = 36,
  RC_PENDLE_SWAPPER = 37,
  RC_DAI_USDS_SWAPPER = 38,
  RC_STAKING_REWARDS_DEPOSITOR = 39,
  RC_STAKING_REWARDS_WITHDRAWER = 40,
  RC_STAKING_REWARDS_PATH_RESOLVER = 41,
  RC_PT_SUSDE_OVERRIDER = 42,
  RC_EQUALIZER_SWAPPER = 43,
  RC_CONVEX_LLAMATHENA_OVERRIDER = 44,
  RC_BALANCER_V3_SWAPPER = 45,
  RC_MELLOW_4626_SWAPPER = 46,
  RC_ERC4626_SWAPPER = 47,
}
