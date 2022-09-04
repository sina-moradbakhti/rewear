import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/models/tailor.dart';
import 'package:rewear/models/user.dart';

class HttpServices {
  static final HttpServices _singleton = HttpServices._internal();
  factory HttpServices() {
    return _singleton;
  }
  HttpServices._internal();

  final String _baseUrl = AppInit.BASE_URL;

  Future<User?> register(
      {required String fullname,
      required String email,
      required String password,
      required String userType,
      required String registerType}) async {
    final Uri url = Uri.parse('$_baseUrl/new-user');
    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'fullname': fullname,
        'email': email,
        'password': password,
        'userType': userType,
        'registerType': registerType
      });
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return User.fromJson(decodedResponse['data']);
      } else {
        AppInit().handleError(MyErrorException(
            message: decodedResponse['message'],
            title: decodedResponse['error_code']));
        return null;
      }
    } catch (er) {
      debugPrint(er.toString());
      AppInit().handleError(er);
      return null;
    }
  }

  Future<User?> signIn(
      {required String email,
      required String password,
      required String registerType}) async {
    final Uri url = Uri.parse('$_baseUrl/sign-in');

    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'email': email,
        'password': password,
        'registerType': registerType.toString()
      });
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return User.fromJson(decodedResponse['data']);
      } else {
        AppInit().handleError(MyErrorException(
            message: decodedResponse['message'],
            title: decodedResponse['error_code']));
        return null;
      }
    } catch (er) {
      debugPrint(er.toString());
      AppInit().handleError(er);
      return null;
    }
  }

  Future<void> init() async {
    final Uri url = Uri.parse('$_baseUrl/init');
    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'userId': AppInit().user.id ?? '',
        'email': AppInit().user.email ?? '',
      }, headers: {
        'Authorization': AppInit().user.token ?? ''
      });
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        AppInit().user = User.fromJson(decodedResponse['data']['user']);

        AppInit().user.updateCache();
      }
    } catch (er) {
      debugPrint(er.toString());
    }
  }

  Future<User?> updateProfile(
      {String? image,
      String? cover,
      String? fullname,
      String? description,
      String? phone,
      String? address,
      String? position,
      String? slogan}) async {
    final Uri url = Uri.parse('$_baseUrl/update-profile');

    try {
      final req = http.MultipartRequest('put', url)
        ..headers['Content-Type'] = 'multipart/form-data'
        ..headers['userid'] = AppInit().user.id ?? ''
        ..headers['email'] = AppInit().user.email ?? ''
        ..headers['Authorization'] = 'Bearer ${AppInit().user.token}';

      if (fullname != null) req.headers['fullname'] = fullname;
      if (phone != null) req.headers['phone'] = phone;
      if (address != null) req.headers['address'] = address;
      if (slogan != null) req.headers['slogan'] = slogan;
      if (position != null) req.headers['position'] = position;
      if (description != null) req.headers['description'] = description;

      if (image != null) {
        req.files.add(await http.MultipartFile.fromPath('image', image));
      }
      if (cover != null) {
        req.files.add(await http.MultipartFile.fromPath('cover', cover));
      }

      final response = await http.Response.fromStream(await req.send());

      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        AppInit().user.phone = decodedResponse['data']['phone'];
        AppInit().user.address = decodedResponse['data']['address'];
        AppInit().user.slogan = decodedResponse['data']['slogan'];
        AppInit().user.description = decodedResponse['data']['description'];
        AppInit().user.position =
            AppInit().user.convertLatLng(decodedResponse['data']['position']);
        AppInit().user.cover = decodedResponse['data']['cover'];
        AppInit().user.image = decodedResponse['data']['image'];
        await AppInit().user.updateCache();
      } else {
        AppInit().handleError(MyErrorException(
            message: decodedResponse['message'],
            title: decodedResponse['error_code']));
        return null;
      }
    } catch (er) {
      debugPrint(er.toString());
      AppInit().handleError(er);
      return null;
    }
  }

  Future<List<dynamic>?> uploadResources(
      {required String reqId, List<String> images = const []}) async {
    final Uri url = Uri.parse('$_baseUrl/upload-resources');

    try {
      final req = http.MultipartRequest('put', url)
        ..headers['Content-Type'] = 'multipart/form-data'
        ..headers['reqid'] = reqId
        ..headers['userid'] = AppInit().user.id ?? ''
        ..headers['Authorization'] = 'Bearer ${AppInit().user.token}';

      int i = 0;
      for (final image in images) {
        i++;
        if (i > 5) {
          break;
        }
        req.files.add(await http.MultipartFile.fromPath('image_$i', image));
      }

      final response = await http.Response.fromStream(await req.send());

      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return decodedResponse['data'];
      } else {
        return null;
      }
    } catch (er) {
      debugPrint(er.toString());
      AppInit().handleError(er);
      return null;
    }
  }

  Future<bool?> updateRequestImages(
      {required String reqId, required List<dynamic> images}) async {
    final Uri url = Uri.parse('$_baseUrl/update-request');
    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'userId': AppInit().user.id ?? '',
        'reqId': reqId,
        'images': jsonEncode(images),
      }, headers: {
        'Authorization': AppInit().user.token ?? ''
      });
      return true;
    } catch (er) {
      debugPrint(er.toString());
      return null;
    }
  }

  Future<bool?> updateRequestChooseSeller(
      {required String reqId, required String sellerId}) async {
    final Uri url = Uri.parse('$_baseUrl/update-request');
    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'userId': AppInit().user.id ?? '',
        'reqId': reqId,
        'sellerId': sellerId,
      }, headers: {
        'Authorization': AppInit().user.token ?? ''
      });
      return true;
    } catch (er) {
      debugPrint(er.toString());
      return null;
    }
  }

  Future<String?> newRequest(Request request) async {
    final Uri url = Uri.parse('$_baseUrl/new-request');
    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'userId': AppInit().user.id ?? '',
        'description': request.order.description,
        'color': request.order.color.toString(),
        'neckStyle': request.order.neckStyle.toString(),
        'material': request.order.material.toString(),
        'serviceType': request.order.serviceType.toString(),
        'deliveryToTailor': request.deliveryToTailor.toString(),
      }, headers: {
        'Authorization': AppInit().user.token ?? ''
      });
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return decodedResponse['data']['_id'];
      }
    } catch (er) {
      debugPrint(er.toString());
      return null;
    }
  }

  Future<void> getTailorsNearby() async {
    final Uri url = Uri.parse('$_baseUrl/get-tailors');
    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'userId': AppInit().user.id ?? '',
      }, headers: {
        'Authorization': AppInit().user.token ?? ''
      });

      List<Tailor> list = [];
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (decodedResponse['data'] != null) {
          for (final tailorJson in decodedResponse['data']) {
            list.add(Tailor.fromJson(tailorJson));
          }
          AppInit().tailors.clear();
          AppInit().tailors.addAll(list);
        }
      }
    } catch (er) {
      debugPrint(er.toString());
    }
  }
}
