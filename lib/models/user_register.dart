// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

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
    this.picture,
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
  File? picture;

  factory UserRegister.fromRawJson(String str) =>
      UserRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        username: json["username"] == null ? null : json["username"],
        firstName: json["firstName"],
        fathersName: json["fathersName"],
        grandfathersName: json["grandfathersName"],
        surName: json["surName"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        contactNumber:
            json["contactNumber"] == null ? null : json["contactNumber"],
        interests: json["interests"] == null
            ? null
            : List<String>.from(json["interests"].map((x) => x)),
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "firstName": firstName,
        "fathersName": fathersName,
        "grandfathersName": grandfathersName,
        "surName": surName,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "contactNumber": contactNumber == null ? null : contactNumber,
        "interests": interests == null
            ? null
            : List<dynamic>.from(interests!.map((x) => x)),
        "picture": picture,
      };
}
