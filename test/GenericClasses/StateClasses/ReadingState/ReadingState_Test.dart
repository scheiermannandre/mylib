// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingState.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateFinished.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateReading.dart';

void main() {
  group('ReadingState.toString Test', () {
    test("ReadingStateNotStarted.toString test", () {
      final ReadingState readingState = ReadingStateNotStarted();
      expect("ReadingStateNotStarted", readingState.toString());
    });
    test("ReadingStateReading.toString test", () {
      final ReadingState readingState = ReadingStateReading();
      expect("ReadingStateReading", readingState.toString());
    });
    test("ReadingStateFinished.toString test", () {
      final ReadingState readingState = ReadingStateFinished();
      expect("ReadingStateFinished", readingState.toString());
    });
  });
}
