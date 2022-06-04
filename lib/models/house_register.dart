// To parse this JSON data, do
//
//     final estateRegister = estateRegisterFromJson(jsonString);

import 'dart:convert';

class HouseRegister {
  HouseRegister({
    required this.name,
    required this.address,
    required this.type,
    this.description,
    required this.size,
    this.numberOfFloors,
    this.rooms,
    this.swimmingPool = false,
  });

  String name;
  String address;
  String type;
  String? description;
  int size;
  int? numberOfFloors;
  int? rooms;
  bool swimmingPool;

  factory HouseRegister.fromRawJson(String str) =>
      HouseRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HouseRegister.fromJson(Map<String, dynamic> json) => HouseRegister(
        name: json["name"],
        address: json["address"],
        type: json["type"],
        description: json["description"],
        size: json["size"],
        numberOfFloors: json["numberOfFloors"],
        rooms: json["rooms"],
        swimmingPool: json["swimmingPool"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "type": type,
        "description": description,
        "size": size,
        "numberOfFloors": numberOfFloors,
        "rooms": rooms,
        "swimmingPool": swimmingPool,
      };
}
