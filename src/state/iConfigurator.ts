export interface Message {
  component: string;
  address: string;
  message: string;
}

export interface ValidationResult {
  warnings: Array<Message>;
  errors: Array<Message>;
}

export interface IConfigurator {
  validate: () => Promise<ValidationResult>;

  deployConfig: () => string;
}
