// ignore_for_file: file_names

class BookAlreadyInWishlistException implements Exception {
  String message;
  BookAlreadyInWishlistException(this.message);

  @override
  String toString() {
    return "Invalid statechange! Message: $message";
  }
}
