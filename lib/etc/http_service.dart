import 'dart:convert';
import 'dart:io';

import 'package:emtalik/models/offer.dart';
import 'package:emtalik/models/offer_registration.dart';
import 'package:emtalik/models/user_register.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:mime/mime.dart';

abstract class HttpService {
  static String get target => 'http://192.168.1.101:8080';
  static String get adminTarget => target + '/admin';
  static String get estateTarget => target + '/estate';
  static String get userTarget => target + '/user';
  static String get offerTarget => target + '/offer';
  static String getProfilePictureRoute(int id) =>
      target + '/user/picture/' + id.toString();
  static String getEstateMainPicture(int id) =>
      target + '/estate/mainpicture/' + id.toString();
  static String getEstateMedia(int estateId, int mediaId) =>
      target + '/estate/media/' + estateId.toString() + mediaId.toString();
  static String getEstateMediaInfo(int estateId) =>
      target + '/estate/media/' + estateId.toString();
  static Future<http.Response> validateUser(String id, String password) async {
    return await http.post(
      Uri.parse(adminTarget + "/validate"),
      body: {
        "id": id,
        "password": password,
      },
    );
  }

  static Future<http.Response> getEstateByTypeAndId(String type, int id) {
    return http.get(Uri.parse(estateTarget + "/" + type + "/" + id.toString()));
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

  // ESTATE JSON
  static Future<http.StreamedResponse> createEstate(dynamic estate, String type,
      int id, XFile? estateMainPicture, List<PlatformFile>? media) async {
    var request =
        http.MultipartRequest("POST", Uri.parse(estateTarget + "/create"));

    var mainPic = await http.MultipartFile.fromPath(
      "estateMainPicture",
      estateMainPicture!.path,
      filename: estateMainPicture.name,
      contentType: MediaType.parse(
        lookupMimeType(estateMainPicture.name) ?? 'application/octet-stream',
      ),
    );

    List<http.MultipartFile> estateMedia = List.empty(growable: true);
    media!.forEach(
      (file) async {
        var multifile = await http.MultipartFile.fromPath(
          "estateMedia",
          file.path ?? "",
          filename: file.name,
          contentType: MediaType.parse(
            lookupMimeType(file.name) ?? 'application/octet-stream',
          ),
        );
        request.files.add(multifile);
        // estateMedia.add(multifile);
      },
    );

    request.files.addAll(estateMedia);

    request.fields['estateJson'] = jsonEncode(estate);
    request.fields['type'] = type;
    request.fields['userId'] = id.toString();
    request.files.add(mainPic);
    return await request.send();
  }

  static Future<http.Response> getEstates() async {
    return await http.get(Uri.parse(estateTarget));
  }

  static Future<http.Response> getOffers() async {
    return await http.get(Uri.parse(offerTarget));
  }

  static Future<http.Response> getOfferById(int id) async {
    return await http.get(Uri.parse(offerTarget + "/" + id.toString()));
  }

  static Future<http.Response> getApprovedEstates() async {
    return await http.get(Uri.parse(estateTarget + "/approved"));
  }

  static Future<http.Response> userHasEstates(int id) async {
    return await http
        .get(Uri.parse(userTarget + "/hasestates/" + id.toString()));
  }

  static Future<http.Response> getUserEstates(int id) async {
    return await http.get(Uri.parse(userTarget + "/estates/" + id.toString()));
  }

  static Future<http.Response> getUserApprovedEstates(int id) async {
    return await http
        .get(Uri.parse(userTarget + "/estates/approved/" + id.toString()));
  }

  static Future<http.Response> createOffer(
      OfferRegistration offer, int estateId) {
    return http.post(Uri.parse(offerTarget + "/save"), body: {
      "offerJson": offer.toRawJson(),
      "estateId": estateId.toString()
    });
  }
}
