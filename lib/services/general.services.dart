import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/errorException.dart';

class GeneralServices {
  static final GeneralServices _singleton = GeneralServices._internal();
  factory GeneralServices() {
    return _singleton;
  }
  GeneralServices._internal();

  Future<void> geoCoding(LatLng position) async {
    try {
      final client = http.Client();
      final result = await client.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&sensor=true&key=${AppInit.GOOGLE_MAP_API}'));
      final Map<String, dynamic> decodedResult = jsonDecode(result.body);
      print('.... GEO Coding ... ');
      if (decodedResult['status'] == 'REQUEST_DENIED') {
        AppInit().handleError(MyErrorException(
            message: decodedResult['error_message'], title: 'REQUEST_DENIED'));
      }
      print(decodedResult);
    } catch (er) {
      print(er);
    }
  }
}
