import 'dart:convert';

import 'package:password_saver/core/user.core.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

final userApiProvider = Provider((ref) {
  return UserAPI();
});

abstract class IUserAPI {
  // abstract api calls

  // register
  Future<Map<String, dynamic>> registerUser(
      {required String email,
      required String password,
      required String fullname});

  // login
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  });
}

class UserAPI implements IUserAPI {
  @override
  Future<Map<String, dynamic>> registerUser(
      {required String email,
      required String password,
      required String fullname}) async {
    final reqUrl = UserEndPoints.registerUrl;
    final reqBody = {
      "email": email,
      "password": password,
      "fullname": fullname
    };
    final response = await http.post(Uri.parse(reqUrl), body: reqBody);
    return jsonDecode(response.body);
  }

  @override
  Future<Map<String, dynamic>> loginUser(
      {required String email, required String password}) async {
    final reqUrl = UserEndPoints.loginUrl;
    final reqBody = {
      "email": email,
      "password": password,
    };
    final response = await http.post(Uri.parse(reqUrl), body: reqBody);
    return jsonDecode(response.body);
  }
}
