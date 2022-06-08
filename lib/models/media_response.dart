// To parse this JSON data, do
//
//     final mediaResponse = mediaResponseFromJson(jsonString);

import 'dart:convert';

class MediaResponse {
  MediaResponse({
    required this.id,
    required this.contentType,
  });

  int id;
  String contentType;

  factory MediaResponse.fromRawJson(String str) =>
      MediaResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaResponse.fromJson(Map<String, dynamic> json) => MediaResponse(
        id: json["id"],
        contentType: json["contentType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contentType": contentType,
      };
}
