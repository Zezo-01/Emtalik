// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) =>
    UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  UserDetails({
    required this.username,
    this.firstName,
    this.fathersName,
    this.grandfathersName,
    this.surName,
    required this.email,
    this.madeOn,
    this.contactNumber,
    required this.role,
    this.interests,
  });

  String username;
  String? firstName;
  String? fathersName;
  String? grandfathersName;
  String? surName;
  String email;
  String? madeOn;
  String? contactNumber;
  String role;
  List<String>? interests;

  factory UserDetails.fromRawJson(String str) =>
      UserDetails.fromJson(json.decode(str));
  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        username: json["username"],
        firstName: json["firstName"],
        fathersName: json["fathersName"],
        grandfathersName: json["grandfathersName"],
        surName: json["surName"],
        email: json["email"],
        madeOn: json["madeOn"],
        contactNumber: json["contactNumber"],
        role: json["role"],
        interests: List<String>.from(json["interests"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "firstName": firstName,
        "fathersName": fathersName,
        "grandfathersName": grandfathersName,
        "surName": surName,
        "email": email,
        "madeOn": madeOn,
        "contactNumber": contactNumber,
        "role": role,
        "interests": List<dynamic>.from(interests!.map((x) => x)),
      };
}
