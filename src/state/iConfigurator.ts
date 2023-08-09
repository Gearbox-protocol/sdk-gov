export interface Warning {
  address: string;
  message: string;
}

export interface IConfigurator {
  validate: () => Array<Warning>;
}
