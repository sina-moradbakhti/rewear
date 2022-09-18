import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/services/http.services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InitService extends HttpServices {
  Future<bool> call() async {
    final Uri url = Uri.parse('$baseUrl/init');
    final client = http.Client();

    try {
      final response = await client.post(url, body: {
        'userId': AppInit().user.id ?? '',
        'email': AppInit().user.email ?? '',
        'fcmToken': AppInit().user.fcmToken ?? '',
      }, headers: {
        'Authorization': AppInit().user.token ?? ''
      });

      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200 && decodedResponse['data'] != null) {
        AppInit().user = User.fromJson(decodedResponse['data']['user']);
        AppInit().requests.clear();
        if (decodedResponse['data']['requests'] != null) {
          for (final reqItem in decodedResponse['data']['requests']) {
            final req = Request.fromJson(reqItem);
            if (req.seller?.id != null && req.id != null) {
              AppInit().requests.add(req);
            }
          }
          AppInit().requests.sort((a, b) => b.orderDate.compareTo(a.orderDate));
        }
        AppInit().user.updateCache();
        return true;
      } else {
        if (decodedResponse['data'] == null &&
            decodedResponse['error_code'] == 'user_not_found') {
          await AppInit().user.signOut();
          AppInit().currentPosition = null;
          Get.offAllNamed(MyRoutes.welcome);
        }
        return false;
      }
    } catch (er) {
      debugPrint(er.toString());
      return false;
    }
  }

  Future<bool> removeAccount() async {
    final Uri url = Uri.parse('$baseUrl/remove-account');
    final client = http.Client();

    try {
      final response = await client.post(url, body: {
        'userId': AppInit().user.id ?? '',
        'email': AppInit().user.email ?? '',
      }, headers: {
        'Authorization': AppInit().user.token ?? ''
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (er) {
      debugPrint(er.toString());
      return false;
    }
  }
}
