// To parse this JSON data, do
//
//     final offer = offerFromJson(jsonString);

import 'dart:convert';

class Offer {
  Offer({
    required this.id,
    required this.name,
    required this.type,
    this.sellPrice,
    this.rentPricePerMonth,
    this.rentPricePerYear,
    this.rentPricePerSeasson,
    required this.negotiable,
    this.estateId,
    this.estateName,
    required this.estateType,
    required this.ownerId,
  });
  int id;
  String name;
  String type;
  double? sellPrice;
  double? rentPricePerMonth;
  double? rentPricePerYear;
  double? rentPricePerSeasson;
  bool negotiable;
  int? estateId;
  String? estateName;
  String estateType;
  int ownerId;

  factory Offer.fromRawJson(String str) => Offer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        sellPrice: json["sellPrice"],
        rentPricePerMonth: json["rentPricePerMonth"],
        rentPricePerYear: json["rentPricePerYear"],
        rentPricePerSeasson: json["rentPricePerSeasson"],
        negotiable: json["negotiable"],
        estateId: json["estateId"],
        estateName: json["estateName"],
        estateType: json["estateType"],
        ownerId: json["ownerId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "sellPrice": sellPrice,
        "rentPricePerMonth": rentPricePerMonth,
        "rentPricePerYear": rentPricePerYear,
        "rentPricePerSeasson": rentPricePerSeasson,
        "negotiable": negotiable,
        "estateId": estateId,
        "estateName": estateName,
        "estateType": estateType,
        "ownerId": ownerId,
      };
}
