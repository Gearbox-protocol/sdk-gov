import { ILogObj, Logger } from "tslog";

export abstract class Logged {
  readonly logger: Logger<ILogObj>;

  protected constructor() {
    this.logger = new Logger<ILogObj>({
      hideLogPositionForProduction: true,
    });
  }

  public enableLogs() {
    this.logger.settings.minLevel = 0;
  }

  public disableLogs() {
    this.logger.settings.minLevel = 6;
  }
}
