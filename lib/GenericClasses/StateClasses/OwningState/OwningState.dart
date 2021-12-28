// ignore_for_file: file_names, non_constant_identifier_names

import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/Exceptions/UnknownOwningStateException.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateLibrary.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateWishlist.dart';

abstract class OwningState {
  void AddToLibrary(Book book) {}
  void AddToWishlist(Book book) {}

  static OwningState SetOwningStateFromString(String owningState) {
    OwningState stateLibrary = OwningStateLibrary();
    OwningState stateWishlist = OwningStateWishlist();
    if (owningState == stateLibrary.runtimeType.toString()) {
      return stateLibrary;
    } else if (owningState == stateWishlist.runtimeType.toString()) {
      return stateWishlist;
    } else {
      throw UnknownOwningStateException(
          "Tried to Construct a OwningState from an unknown State-String!",
          owningState);
    }
  }

  @override
  String toString() {
    return runtimeType.toString();
  }
}
