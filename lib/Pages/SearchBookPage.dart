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
  List<Book> books = [];

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
                          itemCount: books.length,
                          padding: const EdgeInsets.fromLTRB(7.5, 5, 7.5, 5),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(height: 10);
                          },
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Column(
                              children: <Widget>[
                                BookPreviewTile(
                                  book: books[index],
                                  onAddPress: () {
                                    _awaitReturnValueFromwhereToPutDlg(
                                        context, index);
                                  },
                                  onShowDetailsPress: () async {
                                    final result = await Navigator.of(context)
                                        .pushNamed('/details',
                                            arguments: books[index]);
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
        Navigator.of(context).pop(books);
        return false;
      },
    );
  }

  void _awaitReturnValueFromwhereToPutDlg(
      BuildContext context, int index) async {
    //final result = await addBookDlg(context);

    // try {
    //   if (result != "Cancel") {
    //     const JsonEncoder encoder = JsonEncoder.withIndent('  ');

    //     var resBody = {};
    //     resBody["title"] = bookBooks[index].title;
    //     resBody["subtitle"] = bookBooks[index].subTitle;
    //     resBody["author"] = bookBooks[index].author;
    //     resBody["description"] = bookBooks[index].description;
    //     resBody["imagelink"] = bookBooks[index].imageLink;
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

    //     final jsonResponse = await http.post(
    //         "http://192.168.0.6:5000/books/" +
    //             GlobalVariables.userId.toString(),
    //         body: str,
    //         headers: {
    //           "accept": "application/json",
    //           "content-type": "application/json"
    //         });

    //     String body = jsonResponse.body;
    //     JsonDecoder decoder = JsonDecoder();
    //     Map<dynamic, dynamic> json = decoder.convert(body);
    //     print(json);
    //   } else {
    //     print("do nothing");
    //   }
    // } catch (e) {
    //   print(e);
    // }
    // setState(() {});
  }

  void fetchBooksFromGoogle(String searchFor) async {
    FocusScope.of(context).unfocus();
    books.clear();
    isLoading = true;
    searchStarted = true;
    String jsonResponse = await HTTPClient.get(
        GlobalServerProperties.GetBooksFromGoogle(_editingController.text));
    //HttpCall.getBooksGoogle(_editingController.text);

    Map<String, dynamic> jsonBody = json.decode(jsonResponse);
    List<dynamic> list = jsonBody['items'] as List;
    List<Book> tmpBooks = [];
    list.forEach((element) {
      books.add(Book.fromJsonAPI(element['volumeInfo']));
    });

    // list.forEach((element) {
    //   books.add(Book.fromJsonAPI(element['volumeInfo']));
    // });
    // books.addAll(result);
    isLoading = false;
    setState(() {});
  }
}
