// ignore_for_file: file_names

class BookAlreadyInLibraryException implements Exception {
  String message;
  BookAlreadyInLibraryException(this.message);
}
