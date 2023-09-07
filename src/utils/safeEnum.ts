export function safeEnum(t: string): string {
  const safeT = t.replaceAll("-", "_");
  if (!isNaN(parseInt(t.charAt(0), 10))) {
    return `_${safeT}`;
  }
  return safeT;
}
