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

  static Uri GetBookByOwningStateUri(int id, int offset, String owningState) {
    return Uri.parse("http://192.168.0.6:45455/api/books/byowningstate/" +
        id.toString() +
        "/" +
        offset.toString() +
        "/" +
        owningState);
  }

  static Uri GetBooksFromGoogle(String search) {
    return Uri.parse('https://www.googleapis.com/books/v1/volumes?q=' +
        search +
        '&maxResults=20');
  }
}
