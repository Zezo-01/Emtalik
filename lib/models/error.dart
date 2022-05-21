import 'dart:convert';

class Error {
  Error({
    required this.message,
    required this.httpStatus,
    required this.timestamp,
  });

  String message;
  String httpStatus;
  DateTime timestamp;

  factory Error.fromRawJson(String str) => Error.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        httpStatus: json["httpStatus"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "httpStatus": httpStatus,
        "timestamp": timestamp.toIso8601String(),
      };
}
