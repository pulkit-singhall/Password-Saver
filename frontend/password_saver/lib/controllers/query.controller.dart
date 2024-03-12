// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_saver/api/query.api.dart';
import 'package:password_saver/controllers/user.controller.dart';
import 'package:password_saver/core/userTokens.core.dart';
import 'package:password_saver/routes/route.dart';

final queryControllerProvider =
    StateNotifierProvider<QueryController, bool>((ref) {
  final queryApi = ref.watch(queryApiProvider);
  return QueryController(queryApi: queryApi);
});

class QueryController extends StateNotifier<bool> {
  final QueryAPI queryApi;
  QueryController({required this.queryApi}) : super(false);

  Future<void> createQuery(
      {required String question,
      required String answer,
      required String passwordID,
      required BuildContext context,
      required WidgetRef ref}) async {
    final userController = ref.watch(userControllerProvider.notifier);
    final result = await userController.verifyUser(ref: ref);
    if (result) {
      final accessToken = ref.watch(userAccessTokenProvider);
      await queryApi.createQuery(
          question: question,
          answer: answer,
          passwordID: passwordID,
          accessToken: accessToken);
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context, Routes.registerRoute());
    }
  }

  Future<void> deleteQuery(
      {required String queryID,
      required BuildContext context,
      required WidgetRef ref}) async {
    final userController = ref.watch(userControllerProvider.notifier);
    final result = await userController.verifyUser(ref: ref);
    if (result) {
      final accessToken = ref.watch(userAccessTokenProvider);
      await queryApi.deleteQuery(accessToken: accessToken, queryID: queryID);
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context, Routes.registerRoute());
    }
  }

  Future<List<Map<String, dynamic>>> getPasswordQueries(
      {required String passwordID,
      required WidgetRef ref,
      required BuildContext context}) async {
    final userController = ref.watch(userControllerProvider.notifier);
    final result = await userController.verifyUser(ref: ref);
    if (result) {
      final accessToken = ref.watch(userAccessTokenProvider);
      final jsonResponse = await queryApi.getPasswordQueries(
          accessToken: accessToken, passwordID: passwordID);
      final success = jsonResponse['success'];
      if (success == "true") {
        return jsonResponse['data']['passwordQueries'];
      }
      return [];
    } else {
      Navigator.pushReplacement(context, Routes.registerRoute());
      return [];
    }
  }
}
