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
import 'dart:convert';

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

    test("Test - Building via valid builder", () {
      expect(id, book.bookId);
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
      final bookCopy = Book.fromBook(book);
      expect(id, bookCopy.bookId);
      expect(title, bookCopy.title);
      expect(subTitle, bookCopy.subTitle);
      expect(author, bookCopy.author);
      expect(description, bookCopy.description);
      expect(imageLink, bookCopy.imageLink);
      expect(readingState, bookCopy.readingState);
      expect(owningState, bookCopy.owningState);
    });

    test("Test - Building from JsonDB", () {
      Map<String, dynamic> bookJson = jsonDecode(
          "{\"Id\":1,\"Title\":\"BookTest\",\"SubTitle\":\"The API Testing\"," +
              "\"Author\":\"Me\",\"Description\":\"Testing the Library API\"," +
              "\"ImageLink\":\"https://notavailable.de\",\"ReadingState\":\"ReadingStateNotStarted\",\"OwningState\":\"OwningStateWishlist\"}");
      final bookFromJson = Book.fromJsonDB(bookJson);
      expect(bookJson["Id"], bookFromJson.bookId);
      expect(bookJson["Title"], bookFromJson.title);
      expect(bookJson["SubTitle"], bookFromJson.subTitle);
      expect(bookJson["Author"], bookFromJson.author);
      expect(bookJson["Description"], bookFromJson.description);
      expect(bookJson["ImageLink"], bookFromJson.imageLink);
      expect(bookJson["ReadingState"], bookFromJson.readingState.toString());
      expect(bookJson["OwningState"], bookFromJson.owningState.toString());
    });

    test("Test - Building from JsonDB Invalid Id", () {
      Map<String, dynamic> bookJson = jsonDecode(
          "{\"Id\":0,\"Title\":\"BookTest\",\"SubTitle\":\"The API Testing\"," +
              "\"Author\":\"Me\",\"Description\":\"Testing the Library API\"," +
              "\"ImageLink\":\"https://notavailable.de\",\"ReadingState\":\"ReadingStateNotStarted\",\"OwningState\":\"OwningStateWishlist\"}");
      expect(() => Book.fromJsonDB(bookJson),
          throwsA(const TypeMatcher<InvalidBookParameterException>()));
      bookJson["Id"] = -1;
      expect(() => Book.fromJsonDB(bookJson),
          throwsA(const TypeMatcher<InvalidBookParameterException>()));
    });

    test("Test - Building from JsonDB Id is NULL", () {
      Map<String, dynamic> bookJson = jsonDecode(
          "{\"Title\":\"BookTest\",\"SubTitle\":\"The API Testing\"," +
              "\"Author\":\"Me\",\"Description\":\"Testing the Library API\"," +
              "\"ImageLink\":\"https://notavailable.de\",\"ReadingState\":\"ReadingStateNotStarted\",\"OwningState\":\"OwningStateWishlist\"}");
      expect(() => Book.fromJsonDB(bookJson),
          throwsA(const TypeMatcher<InvalidBookParameterException>()));
    });

    test("Test - Building from JsonDB title is NULL", () {
      Map<String, dynamic> bookJson = jsonDecode(
          "{\"Id\":0,\"SubTitle\":\"The API Testing\"," +
              "\"Author\":\"Me\",\"Description\":\"Testing the Library API\"," +
              "\"ImageLink\":\"https://notavailable.de\",\"ReadingState\":\"ReadingStateNotStarted\",\"OwningState\":\"OwningStateWishlist\"}");
      expect(() => Book.fromJsonDB(bookJson),
          throwsA(const TypeMatcher<InvalidBookParameterException>()));
    });

    test("Test - Building from JsonDB nullable parameter are NULL", () {
      Map<String, dynamic> bookJson =
          jsonDecode("{\"Id\":1,\"Title\":\"BookTest\"}");

      final Book bookFromJson = Book.fromJsonDB(bookJson);

      expect(bookJson["Id"], bookFromJson.bookId);
      expect(bookJson["Title"], bookFromJson.title);
      expect(null, bookFromJson.subTitle);
      expect(null, bookFromJson.author);
      expect(null, bookFromJson.description);
      expect(null, bookFromJson.imageLink);
      expect(ReadingStateNotStarted().runtimeType,
          bookFromJson.readingState.runtimeType);
      expect(OwningStateWishlist().runtimeType,
          bookFromJson.owningState.runtimeType);
    });
  });
}
