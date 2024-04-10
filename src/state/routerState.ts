import { RouterComponentRegister, TokenTypeToResolver } from "../router/types";
import { Address } from "../utils/types";
import { BaseContractState } from "./state";

export interface RouterV3ContractState extends BaseContractState {
  components: Array<RouterComponentRegister>;
  tokenTypesToResolver: Array<TokenTypeToResolver>;
  tokensAdded: Array<Address>;
}

export interface RouterState {
  router: RouterV3ContractState;
}
