import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_sanctum_auth_app/models/user.dart';
import 'package:flutter_sanctum_auth_app/services/dio.dart';

class Auth extends ChangeNotifier {
  bool _isloggedin = false;
  String? _token;
  User? user;
  bool _loading = false;

  bool get authinticated => _isloggedin;
  bool get processing => _loading;
  void login({required Map creds, required context, required message}) async {
    try {
      _loading = true;
      notifyListeners();
      Dio.Response response = await dio().post('/sanctum/token', data: creds);
      var token = response.data['token'];
      debugPrint(token);
      tryToken(token);
      _isloggedin = true;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  void tryToken(String token) async {
    try {
      Dio.Response response = await dio().get('sanctum/user',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }));
      debugPrint(response.data.toString());
      user = User.formjson(response.data);
      _token = token;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void logout() async {
    try {
      Dio.Response response = await dio().delete('sanctum/logout',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
          }));
      debugPrint(response.data.toString());
      _isloggedin = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
