// ignore_for_file: file_names, non_constant_identifier_names

import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingState.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';

class ReadingStateFinished extends ReadingState {
  @override
  void ChangeState(Book book) {
    book.readingState = ReadingStateNotStarted();
  }
}
