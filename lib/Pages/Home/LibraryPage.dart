// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/GlobalServerProperties.dart';
import 'package:mylib/GenericClasses/GlobalUserProperties.dart';
import 'package:mylib/GenericClasses/HTTPClientClasses/HTTPClient.dart';
import 'package:mylib/GenericClasses/HttpClient.dart';
import 'package:mylib/Pages/Dialogs/DescriptionDlg.dart';
import 'package:mylib/Pages/Home/BookGridCardLibrary.dart';

class LibraryPage extends StatefulWidget {
  //final BookCollection collection;

  //final bool isLibrary;
  bool refreshCounter = true;
  int libraryCount = 0;
  LibraryPage({
    Key? key,
    //this.collection,
    //required this.isLibrary,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    //int itemCount =
    return _LibraryPageState();
  }
}

class _LibraryPageState extends State<LibraryPage> {
  List<Book> books = [];
  bool isLoading = false;
  bool isEnd = false;
  int readOffset = 0;
  late ScrollController _controller;

  _scrollListener() async {
    var position = _controller.offset /
        (_controller.position.maxScrollExtent -
            _controller.position.minScrollExtent);
    if (position > 0.5 && !_controller.position.outOfRange) {
      //await _getMoreData(books.length);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    //ReadDataBase();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //ReadDataBase();
    //_getMoreData(books.length);
  }

  Future<void> _getMoreData(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      List<Book> tlist = await ReadDataBase();

      setState(() {
        if (tlist.length == 0) {
          isEnd = true;
        } else {
          books.addAll(tlist);
          index = books.length;
        }

        isLoading = false;
      });
    }
  }

  // Widget _buildBookGridCard(int index) {
  // return BookGridCardLibrary(
  //   book: widget.collection.libraryNew[index],
  //   onStatisticsPress: () {
  //     print('statistics button');
  //   },
  //   onStatusPress: () {
  //     _awaitReturnValueFromChangeStatusDlg(context, index);
  //   },
  //   onDeletePress: () {
  //     _awaitReturnValueFromDeleteBookDlg(context, index);
  //   },
  //   onPicTureTab: () {
  //     descriptionDlg(index, widget.collection.library[index], context);
  //   },
  // );
  // }

  // Widget _buildFuture() {
  //   JsonDecoder decoder = JsonDecoder();

  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
  //     child: GridView.builder(
  //       physics: BouncingScrollPhysics(),
  //       shrinkWrap: true,
  //       itemCount: widget.libraryCount,
  //       // widget.isLibrary == true
  //       //     ? widget.collection.library.length
  //       //     : widget.collection.wishlist.length,
  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //   childAspectRatio: 0.7,
  //   crossAxisCount: 2,
  //   crossAxisSpacing: 10,
  //   mainAxisSpacing: 10,
  // ),
  //       itemBuilder: (BuildContext context, int index) {
  //         if (widget.collection.libraryNew.containsKey(index)) {
  //           return _buildBookGridCard(index);
  //         } else {
  //           return FutureBuilder(
  //             future: HttpCall.getBookDB(index),
  //             builder: (context, snapshot) {
  //               if (snapshot.connectionState == ConnectionState.done) {
  //                 if (snapshot.data!.body != "") {
  //                   widget.collection.libraryNew[index] =
  //                       Book.fromJsonDB(decoder.convert(snapshot.data.body));
  //                   return _buildBookGridCard(index);
  //                 } else {
  //                   print("Error reading DataBase");
  //                   return Container();
  //                 }
  //               } else {
  //                 return Container();
  //               }
  //             }, // maybe a show placeholder widget?
  //           );
  //         }

  //         // return widget.isLibrary == true
  //         //     ? BookGridCardLibrary(
  //         //         book: widget.collection.library[index],
  //         //         onStatisticsPress: () {
  //         //           print('statistics button');
  //         //         },
  //         //         onStatusPress: () {
  //         //           _awaitReturnValueFromChangeStatusDlg(context, index);
  //         //         },
  //         //         onDeletePress: () {
  //         //           _awaitReturnValueFromDeleteBookDlg(context, index);
  //         //         },
  //         //         onPicTureTab: () {
  //         //           descriptionDlg(
  //         //               index, widget.collection.library[index], context);
  //         //         },
  //         //       )
  //         //     : BookGridCardWishlist(
  //         //         book: widget.collection.wishlist[index],
  //         //         onDeletePress: () {
  //         //           _awaitReturnValueFromDeleteBookDlg(context, index);
  //         //         },
  //         //         onPicTureTab: () {
  //         //           descriptionDlg(
  //         //               index, widget.collection.wishlist[index], context);
  //         //         },
  //         //       );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    JsonDecoder decoder = const JsonDecoder();
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      controller: _controller,
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
              _awaitReturnValueFromChangeStatusDlg(context, index);
            },
            onDeletePress: () {
              _awaitReturnValueFromDeleteBookDlg(context, index);
            },
            onPicTureTab: () {
              descriptionDlg(index, books[index], context);
            },
          );
        } else {
          // extra item will request next page & rebuild widget
          if (!isEnd) {
            ReadDataBase();
          }
          //_getMoreData(index);
          return isEnd ? Text('End') : CircularProgressIndicator();
        }
      },
    );
    return CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return BookGridCardLibrary(
                book: books[index],
              );
            },
            childCount: books.length,
          ),
        ),
        SliverFillRemaining(
            child: Center(
          child: isEnd ? Text('End') : CircularProgressIndicator(),
        )),
      ],
    );
    //return _buildFuture();
    // if (widget.refreshCounter) {
    //   return FutureBuilder(
    //     future: ReadDataBase(), // HttpCall.getLibraryCountDB(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         Object? test = snapshot.data;
    //         // final response = decoder.convert(snapshot.data);
    //         // widget.libraryCount = response["librarycount"];
    //         // return _buildFuture();
    //         return Container();
    //       } else {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     }, // maybe a show placeholder widget?
    //   );
    // } else {
    //   return Container();
    // }
  }

  Future<List<Book>> ReadDataBase() async {
    const int rowsPerRead = 20;
    Uri uri = GlobalServerProperties.GetBookByOwningStateUri(
        GlobalUserProperties.UserId, readOffset, "OwningStateLibrary");
    String responseBody = await HTTPClient.get(uri);
    Iterable l = json.decode(responseBody);
    List<Book> tmpBooks =
        List<Book>.from(l.map((model) => Book.fromJsonDB(model)));
    if (tmpBooks.isEmpty || tmpBooks.length < rowsPerRead) {
      isEnd = true;
    }
    books.addAll(tmpBooks);
    readOffset++;

    setState(() {});
    return tmpBooks;
  }

  void _awaitReturnValueFromDeleteBookDlg(
      BuildContext context, int index) async {
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

  void _awaitReturnValueFromChangeStatusDlg(
      BuildContext context, int index) async {
    // final result = await changeStatusDialog(
    //     context, widget.collection.library[index].readingState);
    // setState(() {
    //   if (result == "Change") {
    //     switch (widget.collection.library[index].readingState) {
    //       case Status.notStarted:
    //         {
    //           widget.collection.library[index].readingState = Status.reading;
    //           CustomSnackbar.showSnackBar(context, "Status changed to reading");
    //           break;
    //         }
    //       case Status.reading:
    //         {
    //           widget.collection.library[index].readingState = Status.finished;
    //           CustomSnackbar.showSnackBar(
    //               context, "Status changed to finished");
    //           break;
    //         }
    //       case Status.finished:
    //         {
    //           widget.collection.library[index].readingState = Status.notStarted;
    //           CustomSnackbar.showSnackBar(
    //               context, "Status changed to not started yet");
    //           break;
    //         }
    //     }
    //     //CustomSnackbar.showSnackBar(context, "Book deleted");
    //     print("changing Status");
    //   } else {
    //     print("do nothing");
    //   }
    // });
  }
}
