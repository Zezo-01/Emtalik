// To parse this JSON data, do
//
//     final house = houseFromJson(jsonString);

import 'dart:convert';

class House {
  House({
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
    this.numberOfFloors,
    this.rooms,
    this.swimmingPool,
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
  int? numberOfFloors;
  int? rooms;
  bool? swimmingPool;

  factory House.fromRawJson(String str) => House.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory House.fromJson(Map<String, dynamic> json) => House(
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
        numberOfFloors: json["numberOfFloors"],
        rooms: json["rooms"],
        swimmingPool: json["swimmingPool"],
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
        "numberOfFloors": numberOfFloors,
        "rooms": rooms,
        "swimmingPool": swimmingPool,
      };
}
