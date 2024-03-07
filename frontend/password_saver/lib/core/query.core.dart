class PasswordEndPoints {
  // base URL
  static String basePasswordUrl = 'http://localhost:3000/api/v1/passwords';

  static String createUrl = '$basePasswordUrl/create';
  static String deleteUrl = '$basePasswordUrl/delete';
  static String updateUrl = '$basePasswordUrl/update';
  static String getPasswordQueriesUrl = '$basePasswordUrl/get-queries';
}
