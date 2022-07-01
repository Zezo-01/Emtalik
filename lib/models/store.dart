// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

class Store {
  Store({
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
    this.fridges,
    this.storageRoom,
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
  int? fridges;
  bool? storageRoom;

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Store.fromJson(Map<String, dynamic> json) => Store(
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
        fridges: json["fridges"],
        storageRoom: json["storageRoom"],
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
        "fridges": fridges,
        "storageRoom": storageRoom,
      };
}
