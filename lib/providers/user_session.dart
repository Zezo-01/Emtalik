import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserSession {
  UserSession({
    required this.id,
    required this.role,
    required this.interests,
  });

  int? id;
  String? role;
  List<String>? interests;

  factory UserSession.fromRawJson(String str) =>
      UserSession.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
        id: json["id"],
        role: json["role"],
        interests: json["interests"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "interests": interests,
      };
  bool login(UserSession user) {
    if (user.id != null && user.role != null) {
      id = user.id;
      role = user.role;
      interests = user.interests;
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    id = null;
    role = null;
    interests = null;
  }
}
