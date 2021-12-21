// ignore_for_file: file_names, non_constant_identifier_names

import 'package:mylib/GenericClasses/BookClasses/Book.dart';

abstract class OwningState {
  void AddToLibrary(Book book) {}
  void AddToWishlist(Book book) {}
  @override
  String toString() {
    return runtimeType.toString();
  }
}
