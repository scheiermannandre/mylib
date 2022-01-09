// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/GlobalServerProperties.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';
import 'package:mylib/GenericClasses/HTTPClientClasses/HTTPClient.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateLibrary.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateWishlist.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';
import 'package:mylib/Pages/Dialogs/AddBookDlg.dart';
import 'package:mylib/UIComponents/BookPreviewTile.dart';
import 'package:mylib/UIComponents/SnackBar.dart';

class SearchBookPage extends StatefulWidget {
  SearchBookPage({
    Key? key,
  }) : super(key: key);
  @override
  _SearchBookPageState createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage>
    with TickerProviderStateMixin {
  List<Book> foundBooks = [];
  List<Book> addedBooks = [];

  //BookCollection collection = new BookCollection();

  late TextEditingController _editingController;
  late ScrollController scrollViewController;
  bool isLoading = false;
  bool searchStarted = false;
  late AnimationController _controller;

  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();

    scrollViewController = ScrollController(initialScrollOffset: 0.0);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    _animation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    scrollViewController.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _controller.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _controller.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Scaffold(
          backgroundColor: GlobalStyleProperties.subColor,
          appBar: AppBar(
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.storage_rounded,
                      size: 26.0,
                    ),
                  )),
            ],
            toolbarHeight: 75,
            backgroundColor: GlobalStyleProperties.mainColor,
            title: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 40,
                        child: const Text(
                          "You are looking for: ",
                          style: TextStyle(
                            color: GlobalStyleProperties.detailAndTextColor,
                            fontFamily: 'OpenSans',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        height: 40,
                        child: Text(
                          _editingController.text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                            color: GlobalStyleProperties.detailAndTextColor,
                            fontFamily: 'OpenSans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              searchStarted == true
                  ? isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemCount: foundBooks.length,
                          padding: const EdgeInsets.fromLTRB(7.5, 5, 7.5, 5),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(height: 10);
                          },
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Column(
                              children: <Widget>[
                                BookPreviewTile(
                                  book: foundBooks[index],
                                  onAddToLibPress: () async {
                                    bool result = await MakeDecisionDlg(
                                        context, "Add Book to Library?");
                                    if (result) {
                                      Book newBook = foundBooks[index];
                                      newBook.readingState =
                                          ReadingStateNotStarted();
                                      newBook.owningState =
                                          OwningStateLibrary();
                                      addedBooks.add(newBook);
                                      CustomSnackbar.showSnackBar(
                                          context, "Added Book to cache!");
                                    }
                                    // _awaitReturnValueFromwhereToPutDlg(
                                    //     context, index);
                                  },
                                  onAddToWishlistPress: () async {
                                    bool result = await MakeDecisionDlg(
                                        context, "Add Book to Wishlist?");
                                    if (result) {
                                      Book newBook = foundBooks[index];
                                      newBook.readingState =
                                          ReadingStateNotStarted();
                                      newBook.owningState =
                                          OwningStateWishlist();
                                      addedBooks.add(newBook);
                                      CustomSnackbar.showSnackBar(
                                          context, "Added Book to cache!");
                                    }
                                  },
                                  onShowDetailsPress: () async {
                                    final result = await Navigator.of(context)
                                        .pushNamed('/details',
                                            arguments: foundBooks[index]);
                                    if (result == null) {
                                      return;
                                    }

                                    Book newBook = result as Book;
                                    addedBooks.add(newBook);
                                    CustomSnackbar.showSnackBar(
                                        context, "Added Book to cache!");
                                  },
                                ),
                              ],
                            );
                          },
                        )
                  : Align(
                      child: Container(
                        width: 250,
                        //alignment: Alignment.center,
                        child: Text(
                          "Don't be shy,\n start searching!",
                          style: TextStyle(
                            color: GlobalStyleProperties.detailAndTextColor,
                            fontSize: 30,
                            //fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
              Positioned(
                bottom: 10.0,
                left: 0.0,
                right: 0.0,
                child: SlideTransition(
                  position: _animation,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: GlobalStyleProperties.detailAndTextColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 3.0,
                              spreadRadius: .5,
                            )
                          ]),
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          ),
                          Expanded(
                            child: TextField(
                                controller: _editingController,
                                onChanged: (_) => setState(() {}),
                                //keyboardType: TextInputType.text,
                                style: TextStyle(
                                  color: GlobalStyleProperties.mainColor,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Looking for a new book?",
                                  hintStyle:
                                      GlobalStyleProperties.hintTextStyle,
                                ),
                                onEditingComplete: () {
                                  fetchBooksFromGoogle(_editingController.text);
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          ),
                          _editingController.text.trim().isEmpty
                              ? Container()
                              : IconButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(Icons.clear,
                                      color: GlobalStyleProperties.mainColor),
                                  onPressed: () => setState(
                                    () {
                                      _editingController.clear();
                                    },
                                  ),
                                ),
                          IconButton(
                              icon: Icon(
                                Icons.search,
                                color: GlobalStyleProperties.mainColor,
                              ),
                              onPressed: () {
                                fetchBooksFromGoogle(_editingController.text);
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.of(context).pop(addedBooks);
        return false;
      },
    );
  }

  // void _awaitReturnValueFromwhereToPutDlg(
  //     BuildContext context, int index) async {
  //   final result = await addBookDlg(context);

  //   try {
  //     if (result == "Cancel") {
  //       return;
  //     }
  //     if (result) const JsonEncoder encoder = JsonEncoder.withIndent('  ');

  //     var resBody = {};
  //     resBody["title"] = foundBooks[index].title;
  //     resBody["subtitle"] = foundBooks[index].subTitle;
  //     resBody["author"] = foundBooks[index].author;
  //     resBody["description"] = foundBooks[index].description;
  //     resBody["imagelink"] = foundBooks[index].imageLink;
  //     resBody["state"] = "Status.notStarted";
  //     if (result == "Library") {
  //       CustomSnackbar.showSnackBar(context, "Saving in Library");
  //       //collection.addToLibrary(books[index]);
  //       resBody["wishlib"] = "WishLib.library";
  //     } else if (result == "Wishlist") {
  //       CustomSnackbar.showSnackBar(context, "Saving in Wishlist");
  //       //collection.addToWishlist(books[index]);
  //       resBody["wishlib"] = "WishLib.wishList";
  //     }

  //     String str = encoder.convert(resBody);
  //     print(str);

  //     // final jsonResponse = await http.post(
  //     //     "http://192.168.0.6:5000/books/" +
  //     //         GlobalVariables.userId.toString(),
  //     //     body: str,
  //     //     headers: {
  //     //       "accept": "application/json",
  //     //       "content-type": "application/json"
  //     //     });

  //     // String body = jsonResponse.body;
  //     // JsonDecoder decoder = JsonDecoder();
  //     // Map<dynamic, dynamic> json = decoder.convert(body);
  //     print(json);
  //   } catch (e) {
  //     print(e);
  //   }
  //   setState(() {});
  // }

  void fetchBooksFromGoogle(String searchFor) async {
    FocusScope.of(context).unfocus();
    foundBooks.clear();
    isLoading = true;
    searchStarted = true;
    String jsonResponse = await HTTPClient.get(
        GlobalServerProperties.GetBooksFromGoogle(_editingController.text));
    //HttpCall.getBooksGoogle(_editingController.text);

    Map<String, dynamic> jsonBody = json.decode(jsonResponse);
    List<dynamic> list = jsonBody['items'] as List;
    List<Book> tmpBooks = [];
    list.forEach((element) {
      foundBooks.add(Book.fromJsonAPI(element['volumeInfo']));
    });

    // list.forEach((element) {
    //   books.add(Book.fromJsonAPI(element['volumeInfo']));
    // });
    // books.addAll(result);
    isLoading = false;
    setState(() {});
  }
}
