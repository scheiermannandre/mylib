// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateFinished.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateReading.dart';
import 'package:mylib/Pages/Dialogs/ChangeStatusDld.dart';
import 'package:mylib/Pages/Dialogs/DescriptionDlg.dart';
import 'package:mylib/UIComponents/BookListCard.dart';
import 'package:mylib/UIComponents/SnackBar.dart';

class CurrentlyReadingPage extends StatefulWidget {
  late Future<List<Book>> Function(int readOffset) readDataDB;

  CurrentlyReadingPage({Key? key, required this.readDataDB}) : super(key: key);

  @override
  _CurrentlyReadingPageState createState() => _CurrentlyReadingPageState();
}

class _CurrentlyReadingPageState extends State<CurrentlyReadingPage> {
  bool isEnd = false;
  List<Book> books = [];
  int readOffset = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: books.length + 1,
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        if (index < books.length) {
          return BookListCard(
            book: books[index],
            onStatusPress: () {
              _awaitReturnValueFromChangeStatusDlg(context, books[index]);
            },
            onPicTureTab: () {
              descriptionDlg(index, books[index], context);
            },
          );
        } else {
          if (!isEnd) {
            ReadDataBase();
          }
          //_getMoreData(index);
          return isEnd
              ? Text('End')
              : Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<Book>> ReadDataBase() async {
    List<Book> tmpBooks = await widget.readDataDB(readOffset);

    const int rowsPerRead = 20;
    if (tmpBooks.isEmpty || tmpBooks.length < rowsPerRead) {
      isEnd = true;
    }
    if (tmpBooks.length == rowsPerRead) {
      readOffset++;
    }
    books.addAll(tmpBooks);

    setState(() {});
    return tmpBooks;
  }

  void _awaitReturnValueFromChangeStatusDlg(
      BuildContext context, Book book) async {
    final result = await changeStatusDialog(context, book.readingState);
    setState(() {
      String text = "";
      if (result == "Change") {
        if (book.readingState.toString() ==
            ReadingStateNotStarted().toString()) {
          book.readingState = ReadingStateReading();
          text = "Reading";
        } else if (book.readingState.toString() ==
            ReadingStateReading().toString()) {
          book.readingState = ReadingStateFinished();
          text = "Finished";
        } else if (book.readingState.toString() ==
            ReadingStateFinished().toString()) {
          book.readingState = ReadingStateNotStarted();
          text = "NotStarted";
        } else {
          throw Exception("ERROR");
        }
        CustomSnackbar.showSnackBar(context, "Status changed to finished");

        print("changing Status");
      } else {
        print("do nothing");
      }
    });
  }
}
