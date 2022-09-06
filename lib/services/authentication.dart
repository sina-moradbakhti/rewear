import 'package:flutter/material.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/services/http.services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rewear/models/errorException.dart';

class AuthenticationServices extends HttpServices {
  Future<User?> signIn(
      {required String email,
      required String password,
      required String registerType}) async {
    final Uri url = Uri.parse('$baseUrl/sign-in');

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

  Future<User?> register(
      {required String fullname,
      required String email,
      required String password,
      required String userType,
      required String registerType}) async {
    final Uri url = Uri.parse('$baseUrl/new-user');
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
