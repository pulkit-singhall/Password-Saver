// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_saver/api/password.api.dart';
import 'package:password_saver/controllers/user.controller.dart';
import 'package:password_saver/core/userTokens.core.dart';
import 'package:password_saver/routes/route.dart';

final passwordControllerProvider =
    StateNotifierProvider<PasswordController, bool>((ref) {
  final passwordApi = ref.watch(passwordApiProvider);
  return PasswordController(passwordApi: passwordApi);
});

class PasswordController extends StateNotifier<bool> {
  final IPasswordAPI passwordApi;
  PasswordController({required this.passwordApi}) : super(false);

  Future<void> createPassword({
    required BuildContext context,
    required String title,
    required String description,
    required String value,
    required String pin,
    required WidgetRef ref,
  }) async {
    final userController = ref.watch(userControllerProvider.notifier);
    final result = await userController.verifyUser(ref: ref);
    if (result) {
      final accessToken = ref.watch(userAccessTokenProvider);
      await passwordApi.createPassword(
          title: title,
          description: description,
          value: value,
          pin: pin,
          accessToken: accessToken);
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context, Routes.registerRoute());
    }
  }

  Future<List<dynamic>> getUserPasswords(
      {required WidgetRef ref, required BuildContext context}) async {
    final userController = ref.watch(userControllerProvider.notifier);
    final result = await userController.verifyUser(ref: ref);
    if (result) {
      final accessToken = ref.watch(userAccessTokenProvider);
      final jsonResponse =
          await passwordApi.getUserPasswords(accessToken: accessToken);
      final success = jsonResponse['success'];
      if (success == "true") {
        final userPasswords = jsonResponse['data']['userPasswords'];
        return userPasswords;
      } else {
        return [];
      }
    } else {
      Navigator.pushReplacement(context, Routes.registerRoute());
      return [];
    }
  }

  Future<void> deletePassword(
      {required String passwordID,
      required WidgetRef ref,
      required BuildContext context}) async {
    final userController = ref.watch(userControllerProvider.notifier);
    final result = await userController.verifyUser(ref: ref);
    if (result) {
      final accessToken = ref.watch(userAccessTokenProvider);
      final success = await passwordApi.deletePassword(
          accessToken: accessToken, passwordID: passwordID);
      if (success == "true") {
        print('Password Deleted');
      } else {
        print('Password not deleted');
      }
    } else {
      Navigator.pushReplacement(context, Routes.registerRoute());
    }
  }
}
