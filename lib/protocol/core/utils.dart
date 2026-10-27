/// Small parsing helpers shared by the protocol models.
library;

import 'dart:developer' as developer;

int parseInt(dynamic value, [int fallback = 0]) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}

double parseDouble(dynamic value, [double fallback = 0]) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? fallback;
  return fallback;
}

String parseString(dynamic value, [String fallback = '']) {
  if (value == null) return fallback;
  if (value is String) return value;
  return value.toString();
}

/// Validates a request page size, mirroring aiotieba's `check_rn`.
/// Converts Tieba humanized numbers such as "1.2W" to integers.
int tbnum2int(dynamic value, String suffix) {
  if (value is num) return value.toInt();
  final text = parseString(value);
  if (text.endsWith(suffix)) {
    final number =
        double.tryParse(text.substring(0, text.length - suffix.length)) ?? 0;
    return (number * 10000).toInt();
  }
  return int.tryParse(text) ?? 0;
}

void checkRn(String name, int value, int min, int max) {
  // The reference logs and sends the raw value; the server clamps/deals with
  // it. Keep validation non-fatal so a UI mistake cannot escape as a
  // non-TiebaException RangeError.
  if (value < min || value > max) {
    developer.log(
      'rn=$value is out of range [$min, $max]',
      name: 'feiba.protocol.$name',
    );
  }
}

/// Strips the query suffix Baidu appends to portrait identifiers.
String normalizePortrait(String portrait) {
  final index = portrait.indexOf('?');
  return index == -1 ? portrait : portrait.substring(0, index);
}
