// To parse this JSON data, do
//
//     final apartmentRegister = apartmentRegisterFromJson(jsonString);

import 'dart:convert';

class ApartmentRegister {
  ApartmentRegister(
      {required this.name,
      required this.address,
      required this.type,
      this.description,
      required this.size,
      this.apartmentFloorNumber,
      this.apartmentNumber,
      required this.province});

  String name;
  String address;
  String type;
  String? description;
  String province;
  int size;
  int? apartmentFloorNumber;
  int? apartmentNumber;

  factory ApartmentRegister.fromRawJson(String str) =>
      ApartmentRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApartmentRegister.fromJson(Map<String, dynamic> json) =>
      ApartmentRegister(
        name: json["name"],
        address: json["address"],
        type: json["type"],
        description: json["description"],
        size: json["size"],
        apartmentFloorNumber: json["apartmentFloorNumber"],
        apartmentNumber: json["apartmentNumber"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "type": type,
        "description": description,
        "size": size,
        "apartmentFloorNumber": apartmentFloorNumber,
        "apartmentNumber": apartmentNumber,
        "province": province
      };
}
