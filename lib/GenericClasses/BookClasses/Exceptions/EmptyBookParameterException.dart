// ignore_for_file: file_names

class EmptyBookParameterException implements Exception {
  final String message;
  final String parameter;
  EmptyBookParameterException(this.message, this.parameter);

  @override
  String toString() {
    return "Book parameter was empty! Parameter: $parameter Message: $message";
  }
}
