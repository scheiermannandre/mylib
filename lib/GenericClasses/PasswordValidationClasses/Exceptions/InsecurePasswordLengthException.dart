// ignore_for_file: file_names

class InsecurePasswordLengthException implements Exception {
  final int passwordLength;
  InsecurePasswordLengthException(this.passwordLength);

  @override
  String toString() {
    return "The password is too short and therefore treated as insecure! Necessary length: $passwordLength";
  }
}
