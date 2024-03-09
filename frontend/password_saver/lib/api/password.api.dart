import 'dart:convert';

import 'package:password_saver/core/password.core.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

final passwordApiProvider = Provider((ref) => PasswordAPI());

abstract class IPasswordAPI {
  Future<Map<String, dynamic>> createPassword(
      {required String title,
      required String description,
      required String value,
      required String pin,
      required String accessToken});

  Future<Map<String, dynamic>> getUserPasswords({required String accessToken});
}

class PasswordAPI implements IPasswordAPI {
  @override
  Future<Map<String, dynamic>> createPassword(
      {required String title,
      required String description,
      required String value,
      required String pin,
      required String accessToken}) async {
    final reqUrl = PasswordEndPoints.createUrl;
    final reqBody = {
      "title": title,
      "description": description,
      "value": value,
      "pin": pin
    };
    final reqHeaders = {"Authorization": "Bearer $accessToken"};
    final response =
        await http.post(Uri.parse(reqUrl), body: reqBody, headers: reqHeaders);
    return jsonDecode(response.body);
  }

  @override
  Future<Map<String, dynamic>> getUserPasswords(
      {required String accessToken}) async {
    final reqUrl = PasswordEndPoints.getUserPasswords;
    final reqHeaders = {"Authorization": "Bearer $accessToken"};
    final response = await http.get(Uri.parse(reqUrl), headers: reqHeaders);
    return jsonDecode(response.body);
  }
}
