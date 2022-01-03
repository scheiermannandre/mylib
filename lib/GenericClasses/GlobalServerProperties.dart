// ignore_for_file: file_names, non_constant_identifier_names

class GlobalServerProperties {
  static Uri RegisterUri =
      Uri.parse("http://192.168.0.6:45455/api/users/register");
  static Uri LoginUri = Uri.parse("http://192.168.0.6:45455/api/users/login");
  static Uri GetBook = Uri.parse("http://192.168.0.6:45455/api/books/1");

  static String _userExistsUri =
      "http://192.168.0.6:45455/api/users/userexists";
  static Uri GetUserExistUri(String email) {
    return Uri.parse(_userExistsUri + "/" + email);
  }
}
