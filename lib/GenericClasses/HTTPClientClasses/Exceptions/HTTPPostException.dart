// ignore_for_file: file_names

class HTTPPostException implements Exception {
  final String message;
  final Exception inner;
  HTTPPostException(this.message, this.inner);

  @override
  String toString() {
    return "Post Exception! Message: $message";
  }
}
