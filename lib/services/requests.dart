import 'package:flutter/material.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/services/http.services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestsServices extends HttpServices {
  Future<String?> newRequest(Request request) async {
    final Uri url = Uri.parse('$baseUrl/new-request');
    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'userId': AppInit().user.id ?? '',
        'description': request.description,
        'color':
            '${request.color!.red},${request.color!.green},${request.color!.blue}',
        'neckStyle': request.neckStyle.toString(),
        'material': request.material.toString(),
        'serviceType': request.serviceType.toString(),
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

  Future<bool?> updateRequestImages(
      {required String reqId, required List<dynamic> images}) async {
    final Uri url = Uri.parse('$baseUrl/update-request');
    try {
      final client = http.Client();
      await client.post(url, body: {
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
    final Uri url = Uri.parse('$baseUrl/update-request');
    try {
      final client = http.Client();
      await client.post(url, body: {
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

  Future<List<dynamic>?> uploadResources(
      {required String reqId, List<String> images = const []}) async {
    final Uri url = Uri.parse('$baseUrl/upload-resources');

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
      handleError(er);
      return null;
    }
  }
}
