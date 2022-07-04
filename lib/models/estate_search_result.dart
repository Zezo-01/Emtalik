// To parse this JSON data, do
//
//     final estateSearchResult = estateSearchResultFromJson(jsonString);

import 'dart:convert';

class EstateSearchResult {
  EstateSearchResult({
    required this.id,
    required this.name,
    required this.type,
    required this.province,
  });

  int id;
  String name;
  String type;
  String province;

  factory EstateSearchResult.fromRawJson(String str) =>
      EstateSearchResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstateSearchResult.fromJson(Map<String, dynamic> json) =>
      EstateSearchResult(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "province": province,
      };
}
