import 'package:password_saver/api/user.api.dart';
import 'package:riverpod/riverpod.dart';

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
      required String fullname}) async {
    final jsonResponse = await userAPI.registerUser(
        email: email, password: password, fullname: fullname);
  }
}
