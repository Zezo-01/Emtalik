import 'dart:convert';
import 'dart:io';

import 'package:emtalik/models/user_register.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:mime/mime.dart';

abstract class HttpService {
  static String get target => 'http://192.168.0.109:8080';
  static String get adminTarget => target + '/admin';
  static String getProfilePictureRoute(int id) =>
      target + '/user/picture/' + id.toString();
  static Future<http.Response> validateUser(String id, String password) async {
    return await http.post(
      Uri.parse(adminTarget + "/validate"),
      body: {
        "id": id,
        "password": password,
      },
    );
  }

  static Future<http.Response> uniqueUsername(String username) async {
    return await http.post(
      Uri.parse(adminTarget + "/unique/username"),
      body: {
        "username": username,
      },
    );
  }

  static Future<http.Response> uniqueEmail(String email) async {
    return await http.post(
      Uri.parse(adminTarget + "/unique/email"),
      body: {
        "email": email,
      },
    );
  }

  static Future<http.Response> uniqueContactNumber(String contactNumber) async {
    return await http.post(
      Uri.parse(adminTarget + "/unique/contactnumber"),
      body: {
        "contactNumber": contactNumber,
      },
    );
  }

  static Future<http.StreamedResponse> register(
      UserRegister user, XFile? image) async {
    var picture;
    var request =
        http.MultipartRequest("POST", Uri.parse(adminTarget + "/register"));
    request.fields['userJson'] = jsonEncode(user);
    if (image != null) {
      File file = File(image.path);
      picture = http.MultipartFile.fromBytes(
        "picture",
        file.readAsBytesSync(),
        filename: image.name,
        contentType: MediaType.parse(
          lookupMimeType(image.name) ?? 'application/octet-stream',
        ),
      );
    } else {
      picture = null;
    }
    if (picture != null) {
      request.files.add(picture);
    }

    return await request.send();
  }
}
