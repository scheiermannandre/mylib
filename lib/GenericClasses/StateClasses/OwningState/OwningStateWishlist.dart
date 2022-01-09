// ignore_for_file: non_constant_identifier_names, file_names

import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/Exceptions/BookAlreadyInLibraryException.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningState.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateLibrary.dart';

class OwningStateWishlist extends OwningState {
  @override
  void AddToLibrary(Book book) {
    book.owningState = OwningStateLibrary();
  }

  @override
  void AddToWishlist(Book book) {
    throw BookAlreadyInLibraryException(
        "Book: " + book.itemId.toString() + " is already in the wishlist!");
  }
}
