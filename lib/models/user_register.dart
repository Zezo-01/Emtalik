// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

class UserRegister {
  UserRegister({
    required this.username,
    this.firstName,
    this.fathersName,
    this.grandfathersName,
    this.surName,
    required this.email,
    required this.password,
    this.contactNumber,
    this.interests,
  });

  String username;
  String? firstName;
  String? fathersName;
  String? grandfathersName;
  String? surName;
  String email;
  String password;
  String? contactNumber;
  List<String>? interests;

  factory UserRegister.fromRawJson(String str) =>
      UserRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        username: json["username"],
        firstName: json["firstName"],
        fathersName: json["fathersName"],
        grandfathersName: json["grandfathersName"],
        surName: json["surName"],
        email: json["email"],
        password: json["password"],
        contactNumber: json["contactNumber"],
        interests: List<String>.from(json["interests"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "firstName": firstName,
        "fathersName": fathersName,
        "grandfathersName": grandfathersName,
        "surName": surName,
        "email": email,
        "password": password,
        "contactNumber": contactNumber,
        "interests": interests == null || interests!.isEmpty
            ? null
            : List<String>.from(interests!.map((x) => x)),
      };
}
