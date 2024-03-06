class UserEndPoints {
  // base URL
  static String baseUserUrl = 'https://localhost:3000/api/v1/users';

  static String loginUrl = '$baseUserUrl/login';
  static String registerUrl = '$baseUserUrl/register';
  static String logoutUrl = '$baseUserUrl/logout';
  static String currentUserUrl = '$baseUserUrl/current-user';
  static String changePasswordUrl = '$baseUserUrl/change-password';
  static String changeAvatarUrl = '$baseUserUrl/change-avatar';
}
