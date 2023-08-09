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

  toString(): string {
    if (this.isUpdated) {
      return this.originalValue
        ? `${this._valueToString(
            this._value,
          )} was set, original value was ${this._valueToString(
            this.originalValue,
          )}`
        : `${this._valueToString(this._value)} was added`;
    } else {
      return this._valueToString(this._value);
    }
  }

  private _valueToString(value: T): string {
    switch (typeof value) {
      case "string":
        return value;
      case "number":
        return value.toString();
      case "bigint":
        return value.toString();
      case "boolean":
        return value.toString();
      default:
        return `${this._value}`;
    }
  }
}
