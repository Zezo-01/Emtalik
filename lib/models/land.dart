// To parse this JSON data, do
//
//     final land = landFromJson(jsonString);

import 'dart:convert';

class Land {
  Land({
    required this.id,
    required this.name,
    required this.address,
    required this.province,
    required this.ownerUserName,
    required this.ownerId,
    this.description,
    required this.size,
    this.madeOn,
    required this.approved,
    this.cityHallElectricitySupport,
  });

  int id;
  String name;
  String address;
  String province;
  String ownerUserName;
  int ownerId;
  String? description;
  double size;
  String? madeOn;
  bool approved;
  bool? cityHallElectricitySupport;

  factory Land.fromRawJson(String str) => Land.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Land.fromJson(Map<String, dynamic> json) => Land(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        province: json["province"],
        ownerUserName: json["ownerUserName"],
        ownerId: json["ownerId"],
        description: json["description"],
        size: json["size"],
        madeOn: json["madeOn"],
        approved: json["approved"],
        cityHallElectricitySupport: json["cityHallElectricitySupport"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "province": province,
        "ownerUserName": ownerUserName,
        "ownerId": ownerId,
        "description": description,
        "size": size,
        "madeOn": madeOn,
        "approved": approved,
        "cityHallElectricitySupport": cityHallElectricitySupport,
      };
}
