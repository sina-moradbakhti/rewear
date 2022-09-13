import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rewear/config/app_init.dart';
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

  Future<User?> googleSignInCheck({
    required GoogleSignInAccount result,
  }) async {
    final Uri url = Uri.parse('$baseUrl/google-check-user');
    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'fullname': result.displayName ?? '',
        'email': result.email,
        'googleId': result.id
      });
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (decodedResponse['data'] != null) {
          return User.fromJson(decodedResponse['data']);
        } else {
          return null;
        }
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

  Future<bool> resetPassword(String email) async {
    final Uri url = Uri.parse('$baseUrl/reset-password');
    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'email': email,
      });
      if (response.statusCode == 200) return true;
      final decodedResponse = jsonDecode(response.body);
      handleError(MyErrorException(
          message: decodedResponse['message'],
          title: decodedResponse['error_code']));
      return false;
    } catch (er) {
      debugPrint(er.toString());
      handleError(er);
      return false;
    }
  }

  Future<bool> resetPasswordApproval(String email, String code) async {
    final Uri url = Uri.parse('$baseUrl/reset-password-approve');
    try {
      final client = http.Client();
      final response =
          await client.post(url, body: {'email': email, 'code': code});
      if (response.statusCode == 200) return true;
      final decodedResponse = jsonDecode(response.body);
      handleError(MyErrorException(
          message: decodedResponse['message'],
          title: decodedResponse['error_code']));
      return false;
    } catch (er) {
      debugPrint(er.toString());
      handleError(er);
      return false;
    }
  }

  Future<bool> changePassword(String email, String password) async {
    final Uri url = Uri.parse('$baseUrl/change-password');
    try {
      final client = http.Client();
      final response =
          await client.post(url, body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        AppInit().user = User.fromJson(decodedResponse['data']);
        await AppInit().user.updateCache();
        return true;
      }
      final decodedResponse = jsonDecode(response.body);
      handleError(MyErrorException(
          message: decodedResponse['message'],
          title: decodedResponse['error_code']));
      return false;
    } catch (er) {
      debugPrint(er.toString());
      handleError(er);
      return false;
    }
  }

  Future<User?> registerWithGoogle(
      {required String fullname,
      required String email,
      required String userType,
      required String googleId}) async {
    final Uri url = Uri.parse('$baseUrl/google-signup');
    try {
      final client = http.Client();
      final response = await client.post(url, body: {
        'fullname': fullname,
        'email': email,
        'userType': userType,
        'googleId': googleId
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
