import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  User({
    required this.id,
    required this.role,
    required this.interests,
  });

  int? id;
  String? role;
  List<String>? interests;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        role: json["role"],
        interests: json["interests"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "interests": interests,
      };
  bool login(User user) {
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
