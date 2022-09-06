import 'package:flutter/material.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/services/http.services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InitService extends HttpServices {
  Future<void> call() async {
    final Uri url = Uri.parse('$baseUrl/init');
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
        AppInit().requests.clear();
        for (final reqItem in decodedResponse['data']['requests']) {
          AppInit().requests.add(Request.fromJson(reqItem));
        }
        AppInit().user.updateCache();
      }
    try {
     
    } catch (er) {
      debugPrint(er.toString());
    }
  }
}
