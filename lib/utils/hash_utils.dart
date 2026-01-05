import 'dart:convert';

String simpleHash(String input) {
  var hash = 0;
  for (final codeUnit in utf8.encode(input)) {
    hash = (hash * 31 + codeUnit) & 0x7fffffff;
  }
  return hash.toRadixString(16);
}
