import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

abstract class HttpService {
  static String get target => 'http://192.168.1.109:8080';
  static String get adminTarget => target + '/admin';
  static Future<http.Response> validateUser(String id, String password) async {
    return await http.post(
      Uri.parse(adminTarget + "/validate"),
      body: {"id": id, "password": password},
    );
  }
}
