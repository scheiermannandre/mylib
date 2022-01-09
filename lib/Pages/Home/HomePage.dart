// ignore_for_file: unused_local_variable, file_names, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/GlobalServerProperties.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';
import 'package:mylib/GenericClasses/GlobalUserProperties.dart';
import 'package:mylib/GenericClasses/HTTPClientClasses/HTTPClient.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateReading.dart';
import 'package:mylib/Pages/Home/CurrentlyReading.dart';
import 'package:mylib/Pages/Home/BookGridView.dart';
import 'package:mylib/UIComponents/ExpandingFloatingActionButton.dart';
import 'package:mylib/UIComponents/SideBar.dart';

//shift + alt + f -> code einrücken
//Comment Code Block Ctrl+K+C/Ctrl+K+U
class HomePage extends StatefulWidget {
  final int userId;
  HomePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  int tabIndex = 0;
  late TabController tabController;
  late AnimationController _controller;

  double width = 125;
  bool isExpanded = true;
  @override
  void initState() {
    super.initState();
    GlobalUserProperties.UserId = widget.userId;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    tabController =
        TabController(initialIndex: tabIndex, vsync: this, length: 3);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    tabController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print("App is about to Open after Pause");
        setState(() {});
        break;
      case AppLifecycleState.paused:
        print("App is about to Pause");
        break;
      default:
        break;
    }
  }

  @override
  Future<bool> didPopRoute() async {
    print("App is about to Close");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        drawer: SideBar(),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                title: const Text("BookSpace"),
                expandedHeight: 100.0,
                backgroundColor: GlobalStyleProperties.mainColor,
                centerTitle: true,
                pinned: true,
                floating: true,
                bottom: _buildTabs(),
              ),
            ];
          },
          body: _buildBody(),
        ),
        floatingActionButton: ExpandingFloatingActionButton(
          onTab: () async {
            final result = await Navigator.of(context).pushNamed('/searchBook');
            List<Book> newBooks = result as List<Book>;
            if (newBooks.isEmpty) {
              return;
            }
            SaveBooks(newBooks);
            setState(() {});
          },
          width: width,
          isExpanded: isExpanded,
          onExpandText: "Add Book",
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0) {
      return false;
    }
    if (notification is UserScrollNotification == false) {
      return false;
    }
    final UserScrollNotification userScroll =
        notification as UserScrollNotification;
    switch (userScroll.direction) {
      case ScrollDirection.forward:
        {
          if (userScroll.metrics.maxScrollExtent !=
              userScroll.metrics.minScrollExtent) {
            _controller.forward();
            setState(() {
              width = 125.0;
              isExpanded = true;
            });
          }
          break;
        }
      case ScrollDirection.reverse:
        {
          if (userScroll.metrics.maxScrollExtent !=
              userScroll.metrics.minScrollExtent) {
            _controller.reverse();
            setState(() {
              width = 50.0;
              isExpanded = false;
            });
          }
          break;
        }
      case ScrollDirection.idle:
        break;
    }
    return false;
  }

  Future<void> SaveBooks(List<Book> newBooks) async {
    const int rowsPerRead = 20;
    Uri uri = GlobalServerProperties.PostNewBooksToDB;
    String body = jsonEncode(newBooks.map((e) => e.toJson()).toList());
    List<Map<String, dynamic>> mapOfbooks =
        newBooks.map((e) => e.toJson()).toList();
    String responseBody = await HTTPClient.Post(uri, body);
  }

  Future<List<Book>> GetBooksInLibrary(int readOffset) async {
    Uri uri = GlobalServerProperties.GetBookByOwningStateUri(
        GlobalUserProperties.UserId, readOffset, "OwningStateLibrary");
    String responseBody = await HTTPClient.get(uri);
    Iterable l = json.decode(responseBody);
    List<Book> tmpBooks =
        List<Book>.from(l.map((model) => Book.fromJsonDB(model)));
    return tmpBooks;
  }

  Future<List<Book>> GetBooksOnWishlist(int readOffset) async {
    Uri uri = GlobalServerProperties.GetBookByOwningStateUri(
        GlobalUserProperties.UserId, readOffset, "OwningStateWishlist");
    String responseBody = await HTTPClient.get(uri);
    Iterable l = json.decode(responseBody);
    List<Book> tmpBooks =
        List<Book>.from(l.map((model) => Book.fromJsonDB(model)));
    return tmpBooks;
  }

  Future<List<Book>> GetCurrentlyReadingBooks(int readOffset) async {
    Uri uri = GlobalServerProperties.GetBookByReadingStateUri(
        GlobalUserProperties.UserId,
        readOffset,
        ReadingStateReading().toString());
    String responseBody = await HTTPClient.get(uri);
    Iterable l = json.decode(responseBody);
    List<Book> tmpBooks =
        List<Book>.from(l.map((model) => Book.fromJsonDB(model)));
    return tmpBooks;
  }

  Future<bool> UpdateBookStatusDB(Book book) async {
    Uri uri = GlobalServerProperties.PutBookStatusToDB;
    String body = json.encode(book.toJson());
    String responseBody = await HTTPClient.put(uri, body);
    return true;
  }

  PreferredSizeWidget _buildTabs() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: TabBar(
        controller: tabController,
        labelColor: GlobalStyleProperties.detailAndTextColor,
        unselectedLabelColor: Colors.black,
        indicatorColor: GlobalStyleProperties.detailAndTextColor,
        tabs: const [
          Tab(text: "Library"),
          Tab(text: "Reading"),
          Tab(text: "Wishlist"),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: TabBarView(
            controller: tabController,
            children: [
              BookGridView(
                getBooksDB: GetBooksInLibrary,
                updateBookDB: UpdateBookStatusDB,
                deleteBookDB: null,
              ),
              CurrentlyReadingPage(readDataDB: GetCurrentlyReadingBooks),
              BookGridView(
                getBooksDB: GetBooksOnWishlist,
                updateBookDB: UpdateBookStatusDB,
                deleteBookDB: null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
