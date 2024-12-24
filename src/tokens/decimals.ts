import { SupportedToken } from "./token";

export const decimals: Record<SupportedToken, number> = {
  "1INCH": 18,
  AAVE: 18,
  CRV: 18,
  DAI: 18,
  LINK: 18,
  SNX: 18,
  UNI: 18,
  USDC: 6,
  USDC_e: 6,
  USDT: 6,
  DOLA: 18,
  WBTC: 8,
  WETH: 18,
  YFI: 18,
  STETH: 18,
  wstETH: 18,
  CVX: 18,
  FRAX: 18,
  FXS: 18,
  LDO: 18,
  LUSD: 18,
  sUSD: 18,
  GUSD: 2,
  LQTY: 18,
  GMX: 18,
  ARB: 18,
  BAL: 18,
  MKR: 18,
  RPL: 18,
  APE: 18,
  AURA: 18,
  SWISE: 18,
  SKY: 18,
  WLD: 18,
  OP: 18,
  GHO: 18,
  LBTC: 8,
  eBTC: 8,
  solvBTC: 18,
  pumpBTC: 8,
  osETH: 18,
  weETH: 18,
  ezETH: 18,
  rsETH: 18,
  frxETH: 18,
  sfrxETH: 18,
  rswETH: 18,
  cbETH: 18,
  USDe: 18,
  PENDLE: 18,
  pufETH: 18,
  USDS: 18,
  PT_rsETH_26SEP2024: 18,
  "3Crv": 18,
  crvFRAX: 18,
  steCRV: 18,
  crvPlain3andSUSD: 18,
  FRAX3CRV: 18,
  LUSD3CRV: 18,
  gusd3CRV: 18,
  crvCRVETH: 18,
  crvCVXETH: 18,
  crvUSDTWBTCWETH: 18,
  LDOETH: 18,
  USDeUSDC: 18,
  FRAXUSDe: 18,
  USDecrvUSD: 18,
  FRAXsDAI: 18,
  DOLAsUSDe: 18,
  DOLAFRAXBP3CRV_f: 18,
  crvUSDDOLA_f: 18,
  USDeDAI: 18,
  MtEthena: 18,
  GHOUSDe: 18,
  pufETHwstE: 18,
  GHOcrvUSD: 18,
  wstETHCRV: 18,
  ezETHWETH: 18,
  ezpzETH: 18,
  LBTCWBTC: 18,
  eBTCWBTC: 18,
  pumpBTCWBTC: 18,
  TriBTC: 18,
  crvUSD: 18,
  crvUSDUSDC: 18,
  crvUsUSDe: 18,
  llamathena: 18,
  crvUSDUSDT: 18,
  crvUSDETHCRV: 18,
  crvUSDFRAX: 18,
  crvUSDC: 18,
  crvUSDC_e: 18,
  crvUSDT: 18,
  USDEUSDC: 18,
  "2CRV": 18,
  "3c-crvUSD": 18,
  "3CRV": 18,
  cvx3Crv: 18,
  cvxcrvFRAX: 18,
  cvxsteCRV: 18,
  cvxFRAX3CRV: 18,
  cvxLUSD3CRV: 18,
  cvxcrvPlain3andSUSD: 18,
  cvxgusd3CRV: 18,
  cvxcrvCRVETH: 18,
  cvxcrvCVXETH: 18,
  cvxcrvUSDTWBTCWETH: 18,
  cvxLDOETH: 18,
  cvxcrvUSDUSDC: 18,
  cvxcrvUSDUSDT: 18,
  cvxcrvUSDFRAX: 18,
  cvxcrvUSDETHCRV: 18,
  cvxGHOcrvUSD: 18,
  cvxllamathena: 18,
  stkcvx3Crv: 18,
  stkcvxcrvFRAX: 18,
  stkcvxsteCRV: 18,
  stkcvxFRAX3CRV: 18,
  stkcvxLUSD3CRV: 18,
  stkcvxcrvPlain3andSUSD: 18,
  stkcvxgusd3CRV: 18,
  stkcvxcrvCRVETH: 18,
  stkcvxcrvCVXETH: 18,
  stkcvxcrvUSDTWBTCWETH: 18,
  stkcvxLDOETH: 18,
  stkcvxcrvUSDUSDC: 18,
  stkcvxcrvUSDUSDT: 18,
  stkcvxcrvUSDFRAX: 18,
  stkcvxcrvUSDETHCRV: 18,
  stkcvxGHOcrvUSD: 18,
  stkcvxllamathena: 18,
  cvxcrvUSDT: 18,
  yvDAI: 18,
  yvUSDC: 6,
  yvUSDC_e: 6,
  yvUSDT: 6,
  yvOP: 18,
  yvWETH: 18,
  yvWBTC: 8,
  yvCurve_stETH: 18,
  yvCurve_FRAX: 18,

  dDAI: 18,
  dUSDC: 6,
  dWBTC: 8,
  dWETH: 18,
  dFRAX: 18,
  dwstETH: 18,

  dUSDCV3: 6,
  dWBTCV3: 8,
  dWETHV3: 18,
  sdUSDCV3: 6,
  sdWBTCV3: 8,
  sdWETHV3: 18,
  sdWETHV3_OLD: 18,

  dUSDTV3: 6,
  dGHOV3: 18,
  dDAIV3: 18,
  sdUSDTV3: 6,
  sdGHOV3: 18,
  sdDAIV3: 18,

  dcrvUSDV3: 18,
  sdcrvUSDV3: 18,

  dDOLAV3: 18,

  dUSDC_eV3: 6,
  sdUSDC_eV3: 6,

  GEAR: 18,

  USDC_DAI_USDT: 18,
  BPT_rETH_ETH: 18,
  BPT_ROAD: 18,
  BPT_WSTETH_ETH: 18,
  ECLP_wstETH_WETH: 18,
  B_rETH_STABLE: 18,
  weETH_rETH: 18,
  osETH_wETH_BPT: 18,
  B_80BAL_20WETH: 18,
  "50WETH_50AURA": 18,
  wstETH_rETH_cbETH: 18,
  cbETH_rETH_wstETH: 18,
  wstETH_rETH_sfrxETH: 18,
  wstETH_WETH_BPT: 18,
  rETH_WETH_BPT_deprecated: 18,
  rETH_wETH_BPT: 18,
  trenSTETH: 18,
  ezETH_WETH_BPT: 18,
  weETH_ezETH_rswETH: 18,
  "33AURA_33ARB_33BAL": 18,
  ezETH_wstETH: 18,
  GHO_USDT_USDC: 18,
  rsETH_WETH: 18,
  rsETH_wETH_Arb: 18,
  bpt_ethtri: 18,
  pumpBTC_WBTC_BPT: 18,
  sUSDe_USDC_BPT: 18,

  auraB_rETH_STABLE: 18,
  auraB_rETH_STABLE_vault: 18,
  auraweETH_rETH: 18,
  auraweETH_rETH_vault: 18,
  auraosETH_wETH_BPT: 18,
  auraosETH_wETH_BPT_vault: 18,
  auraBPT_rETH_ETH: 18,
  auraBPT_rETH_ETH_vault: 18,
  auraBPT_WSTETH_ETH: 18,
  auraBPT_WSTETH_ETH_vault: 18,
  aurarETH_wETH_BPT: 18,
  aurarETH_wETH_BPT_vault: 18,
  auracbETH_rETH_wstETH: 18,
  auracbETH_rETH_wstETH_vault: 18,
  aurawstETH_rETH_sfrxETH: 18,
  aurawstETH_rETH_sfrxETH_vault: 18,
  aurawstETH_WETH_BPT: 18,
  aurawstETH_WETH_BPT_vault: 18,

  zpufETH: 18,

  steakLRT: 18,
  Re7LRT: 18,
  amphrETH: 18,
  rstETH: 18,
  pzETH: 18,

  aDAI: 18,
  aUSDC: 6,
  aUSDT: 6,
  aWETH: 18,
  waDAI: 18,
  waUSDC: 6,
  waUSDT: 6,
  waWETH: 18,
  cDAI: 18,
  cUSDC: 6,
  cUSDT: 6,
  cLINK: 18,
  cETH: 18,
  SHIB: 18,
  fUSDC: 8,
  sDAI: 18,
  sUSDe: 18,
  sUSDS: 18,
  YieldETH: 18,
  scrvUSD: 18,
  rETH: 18,
  rETH_f: 18,
  stkUSDS: 18,
  PT_sUSDe_26DEC2024: 18,
  PT_eETH_26DEC2024: 18,
  PT_ezETH_26DEC2024: 18,
  PT_eBTC_26DEC2024: 8,
  PT_corn_solvBTC_BBN_26DEC2024: 8,
  PT_corn_pumpBTC_26DEC2024: 8,
  PT_cornLBTC_26DEC2024: 8,
  PT_LBTC_27MAR2025: 8,
  PT_corn_eBTC_27MAR2025: 8,
  PT_sUSDe_27MAR2025: 18,
};
