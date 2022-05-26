// To parse this JSON data, do
//
//     final userSession = userSessionFromJson(jsonString);

import 'dart:convert';

import 'dart:typed_data';

class UserSession {
  UserSession({
    required this.id,
    required this.username,
    required this.role,
    this.interests,
    this.picture,
  });

  int? id;
  String? username;
  String? role;
  List<String>? interests;
  String? picture;

  factory UserSession.fromRawJson(String str) =>
      UserSession.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
        id: json["id"],
        username: json["username"],
        role: json["role"],
        interests: List<String>.from(json["interests"].map((x) => x)),
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "role": role,
        "interests": interests == null
            ? null
            : List<dynamic>.from(interests!.map((x) => x)),
        "picture": picture,
      };
  bool login(UserSession user) {
    if (user.id != null && user.role != null) {
      id = user.id;
      role = user.role;
      interests = user.interests;
      username = user.username;
      picture = user.picture;
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
    picture = null;
  }
}
