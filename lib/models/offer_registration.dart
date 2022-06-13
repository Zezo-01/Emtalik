// To parse this JSON data, do
//
//     final offer = offerFromJson(jsonString);

import 'dart:convert';

class OfferRegistration {
  OfferRegistration({
    required this.name,
    required this.type,
    this.sellPrice,
    this.rentPricePerMonth,
    this.rentPricePerYear,
    this.rentPricePerSeasson,
    this.negotiable,
  });

  String name;
  String type;
  int? sellPrice;
  int? rentPricePerMonth;
  int? rentPricePerYear;
  int? rentPricePerSeasson;
  bool? negotiable;

  factory OfferRegistration.fromRawJson(String str) =>
      OfferRegistration.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfferRegistration.fromJson(Map<String, dynamic> json) =>
      OfferRegistration(
        name: json["name"],
        type: json["type"],
        sellPrice: json["sellPrice"],
        rentPricePerMonth: json["rentPricePerMonth"],
        rentPricePerYear: json["rentPricePerYear"],
        rentPricePerSeasson: json["rentPricePerSeasson"],
        negotiable: json["negotiable"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "sellPrice": sellPrice,
        "rentPricePerMonth": rentPricePerMonth,
        "rentPricePerYear": rentPricePerYear,
        "rentPricePerSeasson": rentPricePerSeasson,
        "negotiable": negotiable,
      };
}
