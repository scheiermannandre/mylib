// ignore_for_file: file_names, non_constant_identifier_names

class GlobalServerProperties {
  static String _ip = "192.168.0.9";
  static Uri RegisterUri =
      Uri.parse("http://" + _ip + ":45455/api/users/register");
  static Uri LoginUri = Uri.parse("http://" + _ip + ":45455/api/users/login");
  static Uri GetBook = Uri.parse("http://" + _ip + ":45455/api/books/1");

  static String _userExistsUri =
      "http://" + _ip + ":45455/api/users/userexists";
  static Uri GetUserExistUri(String email) {
    return Uri.parse(_userExistsUri + "/" + email);
  }

  static Uri PostNewBooksToDB =
      Uri.parse("http://" + _ip + ":45455/api/books/postnew");

  static Uri PutBookStatusToDB =
      Uri.parse("http://" + _ip + ":45455/api/books/update/readingstate");
  static Uri GetBookByOwningStateUri(int id, int offset, String owningState) {
    return Uri.parse("http://" +
        _ip +
        ":45455/api/books/byowningstate/" +
        id.toString() +
        "/" +
        offset.toString() +
        "/" +
        owningState);
  }

  static Uri GetBookByReadingStateUri(int id, int offset, String readingState) {
    return Uri.parse("http://" +
        _ip +
        ":45455/api/books/byreadingstate/" +
        id.toString() +
        "/" +
        offset.toString() +
        "/" +
        readingState);
  }

  static Uri GetBooksFromGoogle(String search) {
    return Uri.parse('https://www.googleapis.com/books/v1/volumes?q=' +
        search +
        '&maxResults=20');
  }
}
