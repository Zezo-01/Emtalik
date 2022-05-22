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

  static Future<http.Response> uniqueUsername(String username) async {
    return await http.post(
      Uri.parse(adminTarget + "/unique/username"),
      body: {"username": username},
    );
  }

  static Future<http.Response> uniqueEmail(String email) async {
    return await http.post(
      Uri.parse(adminTarget + "/unique/email"),
      body: {"email": email},
    );
  }

  static Future<http.Response> uniqueContactNumber(String contactNumber) async {
    return await http.post(
      Uri.parse(adminTarget + "/unique/contactnumber"),
      body: {"contactNumber": contactNumber},
    );
  }
}
