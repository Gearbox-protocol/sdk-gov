import { TokenType } from "../tokens/tokenType";
import { Address } from "../utils/types";
import { RouterComponent } from "./components";

export interface RouterComponentRegister {
  routerComponent: RouterComponent;
  address: Address;
}

export interface TokenTypeToResolver {
  tokenType0: TokenType;
  tokenType1: TokenType;
  resolver: RouterComponent;
}
