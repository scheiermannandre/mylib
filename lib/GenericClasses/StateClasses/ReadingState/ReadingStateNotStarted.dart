// ignore_for_file: non_constant_identifier_names, file_names

import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingState.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateReading.dart';

class ReadingStateNotStarted extends ReadingState {
  @override
  void ChangeState(Book book) {
    book.readingState = ReadingStateReading();
  }
}
