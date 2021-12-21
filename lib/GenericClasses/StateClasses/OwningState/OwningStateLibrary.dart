// ignore_for_file: non_constant_identifier_names, file_names

import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/Exceptions/BookAlreadyInLibraryException.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningState.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateWishlist.dart';

class OwningStateLibrary extends OwningState {
  @override
  void AddToLibrary(Book book) {
    throw BookAlreadyInLibraryException(
        "Book: " + book.id.toString() + " is already in the library!");
  }

  @override
  void AddToWishlist(Book book) {
    book.owningState = OwningStateWishlist();
  }
}
