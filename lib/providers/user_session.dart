// To parse this JSON data, do
//
//     final userSession = userSessionFromJson(jsonString);

import 'dart:convert';

import 'package:emtalik/etc/http_service.dart';
import 'package:http/http.dart' as http;

class UserSession {
  UserSession({
    required this.id,
    required this.username,
    required this.role,
    this.interests,
  });

  int? id;
  String? username;
  String? role;
  List<String>? interests;
  bool picture = false;

  factory UserSession.fromRawJson(String str) =>
      UserSession.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
        id: json["id"],
        username: json["username"],
        role: json["role"],
        interests: List<String>.from(json["interests"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "role": role,
        "interests": interests == null
            ? null
            : List<dynamic>.from(interests!.map((x) => x)),
      };

  Future<bool> login(UserSession user) async {
    if (user.id != null && user.role != null) {
      id = user.id;
      role = user.role;
      interests = user.interests;
      username = user.username;
      await http
          .get(Uri.parse(HttpService.getProfilePictureRoute(id!)))
          .then((value) {
        if (value.statusCode == 200) {
          picture = true;
        } else {
          picture = false;
        }
      });
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    id = null;
    role = null;
    interests = null;
    username = null;
    picture = false;
  }
}
