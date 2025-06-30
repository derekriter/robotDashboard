String formatBoolAsString(bool? boolean) {
  return boolean == null ? "Unknown" : (boolean ? "True" : "False");
}

String formatVoltageAsString(double? voltage, {int precision = 2}) {
  return voltage == null
      ? "Unknown"
      : "${voltage.toStringAsFixed(precision)} V";
}

String formatPercentageAsString(double? percentage, {int precision = 0}) {
  return percentage == null
      ? "Unknown"
      : "${percentage.toStringAsFixed(precision)}%";
}

String formatStringAsString(String? string) {
  return string ?? "Unknown";
}

String formatRotationsAsString(double? rots, {int precision = 6}) {
  return rots == null ? "Unknown" : "${rots.toStringAsFixed(precision)} rot";
}

String formatRotsPerSecAsString(double? rps, {int precision = 6}) {
  return rps == null ? "Unknown" : "${rps.toStringAsFixed(precision)} rps";
}

String formatMillimetersAsString(double? mm, {int precision = 2}) {
  return mm == null ? "Unknown" : "${mm.toStringAsFixed(precision)} mm";
}

String formatMillisecondsAsString(double? ms, {int precision = 1}) {
  return ms == null ? "Unknown" : "${ms.toStringAsFixed(precision)} ms";
}

String formatIntAsString(int? integer) {
  return integer == null ? "Unknown" : integer.toString();
}

String formatDegreesAsString(double? deg, {int precision = 2}) {
  return deg == null ? "Unknown" : "${deg.toStringAsFixed(precision)}°";
}

String formatGsAsString(double? g, {int precision = 3}) {
  return g == null ? "Unknown" : "${g.toStringAsFixed(precision)} G";
}

String formatAmpsAsString(double? amps, {int precision = 2}) {
  return amps == null ? "Unknown" : "${amps.toStringAsFixed(precision)} A";
}

String formatRotsPerMinAsString(double? rpm, {int precision = 6}) {
  return rpm == null ? "Unknown" : "${rpm.toStringAsFixed(precision)} rpm";
}

String formatCelsiusAsString(double? c, {int precision = 1}) {
  return c == null ? "Unknown" : "${c.toStringAsFixed(precision)} °C";
}
