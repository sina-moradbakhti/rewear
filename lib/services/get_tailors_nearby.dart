import 'package:flutter/material.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/tailor.dart';
import 'package:rewear/services/http.services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TailorsServices extends HttpServices {
  Future<void> getTailorsNearby() async {
    final Uri url = Uri.parse('$baseUrl/get-tailors');
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
            final tailor = Tailor.fromJson(tailorJson);
            if (tailor.position != null && tailor.phone != null) {
              list.add(tailor);
            }
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
