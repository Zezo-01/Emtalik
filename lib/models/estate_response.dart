// To parse this JSON data, do
//
//     final estateResponse = estateResponseFromJson(jsonString);

import 'dart:convert';

class EstateResponse {
  EstateResponse({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.province,
  });

  int id;
  String name;
  String type;
  String address;
  String province;

  factory EstateResponse.fromRawJson(String str) =>
      EstateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstateResponse.fromJson(Map<String, dynamic> json) => EstateResponse(
        id: json["id"],
        name: json['name'],
        type: json["type"],
        address: json["address"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "address": address,
        "province": province,
      };
}
