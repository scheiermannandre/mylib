// ignore_for_file: file_names

class InvalidBookParameterException implements Exception {
  final String message;
  final String parameter;
  final String value;

  InvalidBookParameterException(this.message, this.parameter, this.value);

  @override
  String toString() {
    return "Invalid value for Book parameter! Parameter: $parameter Message: $message Value: $value";
  }
}
