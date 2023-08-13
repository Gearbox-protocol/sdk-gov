import { formatBN } from "@gearbox-protocol/sdk";

export class UpdatedValue<T> {
  private _value: T;
  isUpdated: boolean;
  originalValue: T | undefined;

  static new<T>(value: T): UpdatedValue<T> {
    return new UpdatedValue<T>(value, true, undefined);
  }

  static from<T>(value: T): UpdatedValue<T> {
    return new UpdatedValue<T>(value, false, value);
  }

  private constructor(value: T, isUpdated: boolean, originalValue?: T) {
    this._value = value;
    this.isUpdated = isUpdated;
    this.originalValue = originalValue;
  }

  get value(): T {
    return this._value;
  }

  set value(value: T) {
    if (this._value !== value) {
      if (!this.isUpdated) {
        this.originalValue = this._value;
      }
      this.isUpdated = true;
      this._value = value;
    }
  }

  toString(opts?: { decimals: number }): string {
    if (this.isUpdated) {
      return this.originalValue
        ? `${this._valueToString(this.originalValue)} => ${this._valueToString(
            this._value,
            opts?.decimals,
          )}`
        : `${this._valueToString(this._value, opts?.decimals)} [ new ]`;
    } else {
      return this._valueToString(this._value, opts?.decimals);
    }
  }

  private _valueToString(value: T, decimals?: number): string {
    switch (typeof value) {
      case "string":
        return value;
      case "number":
      case "bigint":
        return decimals ? formatBN(value, decimals) : value.toString();
      case "boolean":
        return value.toString();
      case "object":
        return JSON.stringify(value);
      default:
        return `${this._value}`;
    }
  }
}
