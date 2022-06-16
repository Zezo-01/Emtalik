// To parse this JSON data, do
//
//     final parking = parkingFromJson(jsonString);

import 'dart:convert';

class Parking {
  Parking({
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
    this.carsAllowd,
    this.vehicleCapacity,
  });

  int id;
  String name;
  String address;
  String province;
  String ownerUserName;
  int ownerId;
  String? description;
  int size;
  String? madeOn;
  bool approved;
  String? carsAllowd;
  int? vehicleCapacity;

  factory Parking.fromRawJson(String str) => Parking.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
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
        carsAllowd: json["carsAllowd"],
        vehicleCapacity: json["vehicleCapacity"],
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
        "carsAllowd": carsAllowd,
        "vehicleCapacity": vehicleCapacity,
      };
}
