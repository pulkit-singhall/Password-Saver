import 'package:riverpod/riverpod.dart';

final userTokenProvider = StateNotifierProvider<UserTokens, bool>((ref) {
  return UserTokens();
});

final userAccessTokenProvider = Provider((ref) {
  final userToken = ref.watch(userTokenProvider.notifier);
  return userToken.accessToken;
});

final userRefreshTokenProvider = Provider((ref) {
  final userToken = ref.watch(userTokenProvider.notifier);
  return userToken.refreshToken;
});

class UserTokens extends StateNotifier<bool> {
  UserTokens() : super(false);

  String accessToken = 'accessToken';
  String refreshToken = 'refreshToken';

  void updateAccessToken({required String incomingAccessToken}) {
    accessToken = incomingAccessToken;
  }

  void updateRefreshToken({required String incomingRefreshToken}) {
    refreshToken = incomingRefreshToken;
  }
}
