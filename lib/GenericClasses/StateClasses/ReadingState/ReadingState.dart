// ignore_for_file: file_names, non_constant_identifier_names

import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/Exceptions/UnknownReadingStateException.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateFinished.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateReading.dart';

abstract class ReadingState {
  void ChangeState(Book book) {}

  static ReadingState SetReadingStateFromString(String readingState) {
    ReadingState stateNotStarted = ReadingStateNotStarted();
    ReadingState stateReading = ReadingStateReading();
    ReadingState stateFinished = ReadingStateFinished();
    if (readingState == stateNotStarted.runtimeType.toString()) {
      return stateNotStarted;
    } else if (readingState == stateReading.runtimeType.toString()) {
      return stateReading;
    } else if (readingState == stateFinished.runtimeType.toString()) {
      return stateFinished;
    } else {
      throw UnknownReadingStateException(
          "Tried to Construct a ReadingState from an unknown State-String!",
          readingState);
    }
  }

  @override
  String toString() {
    return runtimeType.toString();
  }
}
