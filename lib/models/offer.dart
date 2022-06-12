// To parse this JSON data, do
//
//     final offer = offerFromJson(jsonString);

import 'dart:convert';

class Offer {
  Offer({
    required this.name,
    required this.type,
    this.sellPrice,
    this.rentPricePerMonth,
    this.rentPricePerYear,
    this.rentPricePerSeasson,
    this.negotiable,
    this.estateId,
  });

  String name;
  String type;
  int? sellPrice;
  int? rentPricePerMonth;
  int? rentPricePerYear;
  int? rentPricePerSeasson;
  bool? negotiable;
  int? estateId;

  factory Offer.fromRawJson(String str) => Offer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        name: json["name"],
        type: json["type"],
        sellPrice: json["sellPrice"],
        rentPricePerMonth: json["rentPricePerMonth"],
        rentPricePerYear: json["rentPricePerYear"],
        rentPricePerSeasson: json["rentPricePerSeasson"],
        negotiable: json["negotiable"],
        estateId: json["estateId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "sellPrice": sellPrice,
        "rentPricePerMonth": rentPricePerMonth,
        "rentPricePerYear": rentPricePerYear,
        "rentPricePerSeasson": rentPricePerSeasson,
        "negotiable": negotiable,
        "estateId": estateId,
      };
}
