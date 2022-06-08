// To parse this JSON data, do
//
//     final estateRegister = estateRegisterFromJson(jsonString);

import 'dart:convert';

class ParkingRegister {
  ParkingRegister(
      {required this.name,
      required this.address,
      required this.type,
      this.description,
      required this.size,
      this.carsAllowed,
      this.vehicleCapacity,
      required this.province});

  String name;
  String address;
  String type;
  String? description;
  String province;
  int size;
  List<String>? carsAllowed;
  int? vehicleCapacity;

  factory ParkingRegister.fromRawJson(String str) =>
      ParkingRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ParkingRegister.fromJson(Map<String, dynamic> json) =>
      ParkingRegister(
          name: json["name"],
          address: json["address"],
          type: json["type"],
          description: json["description"],
          size: json["size"],
          carsAllowed: List<String>.from(json["carsAllowed"].map((x) => x)),
          vehicleCapacity: json["vehicleCapacity"],
          province: json["province"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "type": type,
        "description": description,
        "size": size,
        "carsAllowed": carsAllowed == null
            ? null
            : List<dynamic>.from(carsAllowed!.map((x) => x)),
        "vehicleCapacity": vehicleCapacity,
        "province": province,
      };
}
