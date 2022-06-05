// To parse this JSON data, do
//
//     final landRegister = landRegisterFromJson(jsonString);

import 'dart:convert';

class LandRegister {
  LandRegister({
    required this.name,
    required this.address,
    required this.type,
    this.description,
    required this.size,
    this.cityHallElectricitySupport,
  });

  String name;
  String address;
  String type;
  String? description;
  int size;
  bool? cityHallElectricitySupport;

  factory LandRegister.fromRawJson(String str) =>
      LandRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LandRegister.fromJson(Map<String, dynamic> json) => LandRegister(
        name: json["name"],
        address: json["address"],
        type: json["type"],
        description: json["description"],
        size: json["size"],
        cityHallElectricitySupport: json["cityHallElectricitySupport"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "type": type,
        "description": description,
        "size": size,
        "cityHallElectricitySupport": cityHallElectricitySupport,
      };
}
