// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/BookClasses/Exceptions/EmptyBookParameterException.dart';
import 'package:mylib/GenericClasses/BookClasses/Exceptions/InvalidBookParameterException.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningState.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateLibrary.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateWishlist.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingState.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';

void main() {
  group('Constructing Book', () {
    int id = 1;
    String title = "title";
    String subTitle = "subTitle";
    String author = "author";
    String description = "description";
    String imageLink = "imageLink";
    ReadingState readingState = ReadingStateNotStarted();
    OwningState owningState = OwningStateWishlist();
    test("Test - Building via valid builder", () {
      final Book book = BookBuilder()
          .setId(id)
          .setTitle(title)
          .setSubTitle(subTitle)
          .setAuthor(author)
          .setDescription(description)
          .setImageLink(imageLink)
          .setReadingState(readingState)
          .setOwningState(owningState)
          .buildBook();

      expect(id, book.id);
      expect(title, book.title);
      expect(subTitle, book.subTitle);
      expect(author, book.author);
      expect(description, book.description);
      expect(imageLink, book.imageLink);
      expect(readingState, book.readingState);
      expect(owningState, book.owningState);
    });

    test("Test - Building with invalid id", () {
      expect(() => BookBuilder().setId(-1).buildBook(),
          throwsA(const TypeMatcher<InvalidBookParameterException>()));
      expect(() => BookBuilder().setId(0).buildBook(),
          throwsA(const TypeMatcher<InvalidBookParameterException>()));
    });

    test("Test - Building with empty title", () {
      expect(() => BookBuilder().setId(1).buildBook(),
          throwsA(const TypeMatcher<EmptyBookParameterException>()));
    });
    test("Test - Building via Copy-Constructor", () {
      final Book refBook = BookBuilder()
          .setId(id)
          .setTitle(title)
          .setSubTitle(subTitle)
          .setAuthor(author)
          .setDescription(description)
          .setImageLink(imageLink)
          .setReadingState(readingState)
          .setOwningState(owningState)
          .buildBook();

      final bookCopy = Book.fromBook(refBook);
      expect(id, bookCopy.id);
      expect(title, bookCopy.title);
      expect(subTitle, bookCopy.subTitle);
      expect(author, bookCopy.author);
      expect(description, bookCopy.description);
      expect(imageLink, bookCopy.imageLink);
      expect(readingState, bookCopy.readingState);
      expect(owningState, bookCopy.owningState);
    });
  });
}
