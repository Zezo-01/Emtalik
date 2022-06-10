import 'dart:convert';

String decodeUtf8ToString(String utf8String) {
  return utf8.decode(utf8String.codeUnits, allowMalformed: false);
}
