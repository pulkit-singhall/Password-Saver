import 'dart:convert';

import 'package:password_saver/core/query.core.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

final queryApiProvider = Provider((ref) => QueryAPI());

abstract class IQueryAPI {
  Future<Map<String, dynamic>> createQuery(
      {required String question,
      required String answer,
      required String passwordID,
      required String accessToken});

  Future<String> deleteQuery(
      {required String accessToken, required String queryID});

  Future<Map<String, dynamic>> getPasswordQueries(
      {required String accessToken, required String passwordID});
}

class QueryAPI implements IQueryAPI {
  @override
  Future<Map<String, dynamic>> createQuery(
      {required String question,
      required String answer,
      required String passwordID,
      required String accessToken}) async {
    final reqUrl = '${QueryEndPoints.createUrl}/$passwordID';
    final reqBody = {"question": question, "answer": answer};
    final reqHeaders = {"Authorization": "Bearer $accessToken"};
    final response =
        await http.post(Uri.parse(reqUrl), body: reqBody, headers: reqHeaders);
    return jsonDecode(response.body);
  }

  @override
  Future<String> deleteQuery(
      {required String accessToken, required String queryID}) async {
    final reqUrl = '${QueryEndPoints.deleteUrl}/$queryID';
    final reqHeaders = {"Authorization": "Bearer $accessToken"};
    final response = await http.delete(Uri.parse(reqUrl), headers: reqHeaders);
    final json = jsonDecode(response.body);
    return json['success'];
  }

  @override
  Future<Map<String, dynamic>> getPasswordQueries(
      {required String accessToken, required String passwordID}) async {
    final reqUrl = '${QueryEndPoints.getPasswordQueriesUrl}/$passwordID';
    final reqHeaders = {"Authorization": "Bearer $accessToken"};
    final response = await http.get(Uri.parse(reqUrl), headers: reqHeaders);
    return jsonDecode(response.body); 
  }
}
