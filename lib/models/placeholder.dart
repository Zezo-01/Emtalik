// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

List<UserRegister> userRegisterFromJson(String str) => List<UserRegister>.from(
    json.decode(str).map((x) => UserRegister.fromJson(x)));

String userRegisterToJson(List<UserRegister> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserRegister {
  UserRegister({
    this.id,
    required this.username,
    this.firstName,
    this.fathersName,
    this.grandfathersName,
    this.surName,
    required this.email,
    required this.password,
    this.madeOn,
    this.contactNumber,
    this.role,
    this.reports,
    this.interests,
    this.picture,
  });

  int? id;
  String username;
  String? firstName;
  String? fathersName;
  String? grandfathersName;
  String? surName;
  String email;
  String password;
  DateTime? madeOn;
  String? contactNumber;
  String? role;
  dynamic reports;
  List<String>? interests;
  String? picture;

  factory UserRegister.fromRawJson(String str) =>
      UserRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        id: json["id"],
        username: json["username"],
        firstName: json["firstName"],
        fathersName: json["fathersName"],
        grandfathersName: json["grandfathersName"],
        surName: json["surName"],
        email: json["email"],
        password: json["password"],
        madeOn: DateTime.parse(json["madeOn"]),
        contactNumber: json["contactNumber"],
        role: json["role"],
        reports: json["reports"],
        interests: List<String>.from(json["interests"].map((x) => x)),
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "firstName": firstName,
        "fathersName": fathersName,
        "grandfathersName": grandfathersName,
        "surName": surName,
        "email": email,
        "password": password,
        "madeOn": madeOn?.toIso8601String(),
        "contactNumber": contactNumber,
        "role": role,
        "reports": reports,
        "interests": interests == null || interests!.isEmpty
            ? List<dynamic>.from(interests!.map((x) => x))
            : null,
        "picture": picture,
      };
}
