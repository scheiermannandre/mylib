// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateFinished.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateReading.dart';
import 'package:mylib/Pages/Dialogs/ChangeStatusDld.dart';
import 'package:mylib/Pages/Dialogs/DescriptionDlg.dart';
import 'package:mylib/Pages/Home/BookGridCardLibrary.dart';
import 'package:mylib/UIComponents/SnackBar.dart';

class BookGridView extends StatefulWidget {
  late Future<List<Book>> Function(int readOffset) getBooksDB;
  late Future<bool> Function(Book book) updateBookDB;
  late Future<bool> Function(Book book)? deleteBookDB;
  late Widget gridCard;
  bool refreshCounter = true;
  int libraryCount = 0;
  BookGridView({
    Key? key,
    required this.getBooksDB,
    required this.updateBookDB,
    this.deleteBookDB,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BookGridViewState();
  }
}

class _BookGridViewState extends State<BookGridView> {
  List<Book> books = [];
  bool isEnd = false;
  int readOffset = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      itemCount: books.length + 1, // pad data with an extra item at end
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        if (index < books.length) {
          return BookGridCardLibrary(
            book: books[index],
            onStatisticsPress: () {
              print('statistics button');
            },
            onStatusPress: () {
              _changeStatus(context, index);
            },
            onDeletePress: () {
              _deleteBook(context, index);
            },
            onPicTureTab: () {
              descriptionDlg(index, books[index], context);
            },
          );
        } else {
          // extra item will request next page & rebuild widget
          if (!isEnd) {
            GetBooksDB();
          }
          return isEnd
              ? Container()
              : const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void GetBooksDB() async {
    List<Book> tmpBooks = await widget.getBooksDB(readOffset);
    const int rowsPerRead = 20;
    if (tmpBooks.isEmpty || tmpBooks.length < rowsPerRead) {
      isEnd = true;
    }
    if (tmpBooks.length == rowsPerRead) {
      readOffset++;
    }
    books.addAll(tmpBooks);
    setState(() {});
  }

  void _deleteBook(BuildContext context, int index) async {
    // Book book;
    // final result = await deleteBookDialog(context, widget.isLibrary);
    // setState(() {
    //   if (result == "Delete") {
    //     widget.isLibrary == true
    //         ? widget.collection.library.removeAt(index)
    //         : widget.collection.wishlist.removeAt(index);
    //     CustomSnackbar.showSnackBar(context, "Book deleted");
    //     print("Deleting Book");
    //   } else if (result == "toWishlist" || result == "toLibrary") {
    //     widget.isLibrary == true
    //         ? book = widget.collection.library.removeAt(index)
    //         : book = widget.collection.wishlist.removeAt(index);
    //     String text;
    //     if (result == "toWishlist") {
    //       text = "Book moved to Wishlist";
    //       book.readingState = Status.notStarted;
    //       book.wishLib = WishLib.wishList;
    //     } else {
    //       text = "Book moved to Library";
    //       book.wishLib = WishLib.library;
    //     }
    //     widget.isLibrary == true
    //         ? widget.collection.wishlist.add(book)
    //         : widget.collection.library.add(book);
    //     CustomSnackbar.showSnackBar(context, text);
    //     print("Put Book on Wishlist");
    //   } else {
    //     print("do nothing");
    //   }
    // });
  }

  void _changeStatus(BuildContext context, int index) async {
    final result = await changeStatusDialog(context, books[index].readingState);
    if (result != "Change") {
      return;
    }
    if (books[index].readingState.toString() ==
        ReadingStateNotStarted().toString()) {
      books[index].readingState = ReadingStateReading();
    } else if (books[index].readingState.toString() ==
        ReadingStateReading().toString()) {
      books[index].readingState = ReadingStateFinished();
    } else if (books[index].readingState.toString() ==
        ReadingStateFinished().toString()) {
      books[index].readingState = ReadingStateNotStarted();
    } else {
      throw Exception("ERROR");
    }
    UpdateBookStatusDB(books[index]);
    CustomSnackbar.showSnackBar(context, "Status changed to finished");

    setState(() {});
  }

  void UpdateBookStatusDB(Book book) async {
    bool result = await widget.updateBookDB(book);
    setState(() {});
  }
}
