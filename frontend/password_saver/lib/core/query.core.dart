class QueryEndPoints {
  // base URL
  static String baseQueryUrl = 'http://localhost:3000/api/v1/queries';

  static String createUrl = '$baseQueryUrl/create';
  static String deleteUrl = '$baseQueryUrl/delete';
  static String updateUrl = '$baseQueryUrl/update';
  static String getPasswordQueriesUrl = '$baseQueryUrl/get-queries';
}
