// ignore_for_file: file_names

class BookAlreadyInLibraryException implements Exception {
  String message;
  BookAlreadyInLibraryException(this.message);

  @override
  String toString() {
    return "Invalid statechange! Message: $message";
  }
}
