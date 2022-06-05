// To parse this JSON data, do
//
//     final storeRegister = storeRegisterFromJson(jsonString);

import 'dart:convert';

class StoreRegister {
  StoreRegister({
    required this.name,
    required this.address,
    required this.type,
    this.description,
    required this.size,
    this.fridges,
    this.storageRoom,
  });

  String name;
  String address;
  String type;
  String? description;
  int size;
  int? fridges;
  bool? storageRoom;

  factory StoreRegister.fromRawJson(String str) =>
      StoreRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreRegister.fromJson(Map<String, dynamic> json) => StoreRegister(
        name: json["name"],
        address: json["address"],
        type: json["type"],
        description: json["description"],
        size: json["size"],
        fridges: json["fridges"],
        storageRoom: json["storageRoom"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "type": type,
        "description": description,
        "size": size,
        "fridges": fridges,
        "storageRoom": storageRoom,
      };
}
