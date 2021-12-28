// ignore_for_file: file_names

class UnknownReadingStateException implements Exception {
  final String message;
  final String state;

  UnknownReadingStateException(this.message, this.state);

  @override
  String toString() {
    return "Unknown ReadingState! State: $state Message: $message";
  }
}
