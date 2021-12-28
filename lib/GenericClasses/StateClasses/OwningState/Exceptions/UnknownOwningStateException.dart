// ignore_for_file: file_names

class UnknownOwningStateException implements Exception {
  final String message;
  final String state;

  UnknownOwningStateException(this.message, this.state);

  @override
  String toString() {
    return "Unknown OwningState! State: $state Message: $message";
  }
}
