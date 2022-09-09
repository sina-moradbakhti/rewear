import 'package:flutter/material.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/services/http.services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateProfileService extends HttpServices {
  Future<User?> call(
      {String? image,
      String? cover,
      String? fullname,
      String? description,
      String? phone,
      String? address,
      String? position,
      String? slogan}) async {
    final Uri url = Uri.parse('$baseUrl/update-profile');

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
        if (phone != null) {
          AppInit().user.phone = phone;
        }
        if (address != null) {
          AppInit().user.address = address;
        }
        if (slogan != null) {
          AppInit().user.slogan = slogan;
        }
        if (description != null) {
          AppInit().user.description = description;
        }
        if (position != null) {
          AppInit().user.position = AppInit().user.convertLatLng(position);
        }
        if (image != null && decodedResponse['data']['cover'] != null) {
          AppInit().user.cover = decodedResponse['data']['cover'];
        }
        if (cover != null && decodedResponse['data']['image'] != null) {
          AppInit().user.image = decodedResponse['data']['image'];
        }

        await AppInit().user.updateCache();
      } else {
        handleError(MyErrorException(
            message: decodedResponse['message'],
            title: decodedResponse['error_code']));
        return null;
      }
    } catch (er) {
      debugPrint(er.toString());
      handleError(er);
      return null;
    }
  }
}
