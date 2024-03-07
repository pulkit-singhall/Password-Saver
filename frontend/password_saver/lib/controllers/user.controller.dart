// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_saver/api/user.api.dart';
import 'package:password_saver/core/userTokens.core.dart';
import 'package:password_saver/routes/route.dart';

final userControllerProvider =
    StateNotifierProvider<UserController, bool>((ref) {
  final userApi = ref.watch(userApiProvider);
  return UserController(userAPI: userApi);
});

class UserController extends StateNotifier<bool> {
  final UserAPI userAPI;
  UserController({required this.userAPI}) : super(false);
  // isLoading

  Future<void> registerUser(
      {required String email,
      required String password,
      required String fullname,
      required BuildContext context}) async {
    final jsonResponse = await userAPI.registerUser(
        email: email, password: password, fullname: fullname);
    final success = jsonResponse['success'];
    if (success == "true") {
      Navigator.push(context, Routes.loginRoute());
    } else {
      print("Error in register: ${jsonResponse['error']}");
    }
  }

  Future<void> loginUser({
    required String password,
    required String email,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final jsonResponse =
        await userAPI.loginUser(email: email, password: password);
    final success = jsonResponse['success'];
    if (success == "true") {
      final accessToken = jsonResponse['data']['accessToken'];
      final refreshToken = jsonResponse['data']['refreshToken'];
      final userToken = ref.watch(userTokenProvider.notifier);
      userToken.updateAccessToken(incomingAccessToken: accessToken);
      userToken.updateRefreshToken(incomingRefreshToken: refreshToken);
      Navigator.pushReplacement(context, Routes.dashboardRoute());
    } else {
      print("Error in login: ${jsonResponse['error']}");
    }
  }
}
