// To parse this JSON data, do
//
//     final apartment = apartmentFromJson(jsonString);

import 'dart:convert';

class Apartment {
  Apartment({
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
    this.apartmentFloorNumber,
    this.apartmentNumber,
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
  int? apartmentFloorNumber;
  int? apartmentNumber;

  factory Apartment.fromRawJson(String str) =>
      Apartment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Apartment.fromJson(Map<String, dynamic> json) => Apartment(
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
        apartmentFloorNumber: json["apartmentFloorNumber"],
        apartmentNumber: json["apartmentNumber"],
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
        "apartmentFloorNumber": apartmentFloorNumber,
        "apartmentNumber": apartmentNumber,
      };
}
