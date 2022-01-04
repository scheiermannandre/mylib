// ignore_for_file: unused_local_variable, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';
import 'package:mylib/GenericClasses/GlobalUserProperties.dart';
import 'package:mylib/Pages/Home/LibraryPage.dart';

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
  late ScrollController scrollViewController;

  late AnimationController _controller;
  // BookCollection collection = new BookCollection();

  PageController pageController = PageController();
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

    scrollViewController = ScrollController(initialScrollOffset: 0.0);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    _controller.dispose();

    tabController.dispose();
    scrollViewController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print("App is about to Open after Pause");
        //UseGoogleDrive.instance.signInSilently();
        // List<dynamic> jsonList = await UseGoogleDrive.instance.loadLibrary();
        // collection.clear();
        // collection =  BookCollection.loadJson(jsonList);
        setState(() {});
        break;
      case AppLifecycleState.paused:
        print("App is about to Pause");
        //await UseGoogleDrive.instance.saveLibrary(collection);
        break;
      default:
        break;
    }
  }

  @override
  Future<bool> didPopRoute() async {
    print("App is about to Close");
    //await UseGoogleDrive.instance.saveLibrary(collection);
    return false;
  }

  Widget myAnimatedWidget = FloatingActionButton.extended(
    key: const ValueKey(1),
    onPressed: () {},
    icon: const Icon(Icons.add),
    label: const Text(
      "Add book!",
      style: TextStyle(color: GlobalStyleProperties.detailAndTextColor),
    ),
  );

  double width = 125;
  bool isExpanded = true;
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _controller.forward();
              setState(() {
                width = 125.0;
                isExpanded = true;
                myAnimatedWidget = FloatingActionButton.extended(
                  key: const ValueKey(1),
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text(
                    "Add book!",
                    style: TextStyle(
                        color: GlobalStyleProperties.detailAndTextColor),
                  ),
                );
              });
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _controller.reverse();
              setState(() {
                width = 50.0;
                isExpanded = false;
              });
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
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        //drawer: SideBar(),
        body: NestedScrollView(
          controller: scrollViewController,
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
                // flexibleSpace: Stack(
                //   children: <Widget>[
                //     Positioned.fill(
                //       top: 30,
                //       bottom: 30,
                //       child: FlutterLogo(
                //         size: 100,
                //       ),
                //     ),
                //   ],
                // ),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: Align(
                      //alignment: Alignment.centerLeft,
                      child: Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        //width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        child: TabBar(
                          controller: tabController,
                          labelColor: GlobalStyleProperties.detailAndTextColor,
                          unselectedLabelColor: Colors.black,
                          indicatorColor:
                              GlobalStyleProperties.detailAndTextColor,
                          tabs: const [
                            Tab(text: "Library"),
                            Tab(text: "Reading"),
                            Tab(text: "Wishlist"),
                          ],
                        ),
                      ),
                    )),
              ),
            ];
          },
          body: Stack(
            children: [
              MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    // LibraryPage(
                    //   collection: collection,
                    //   // bookCollection: collection.library,
                    //   // notNeededbookCollection: collection.wishlist,
                    //   isLibrary: true,
                    // ),
                    LibraryPage(),
                    //const Text("Library"),
                    const Text("Reading"),
                    const Text("Wishlist"),
                    // LibraryPage(
                    //   collection: collection,
                    //   // bookCollection: collection.library,
                    //   // notNeededbookCollection: collection.wishlist,
                    //   isLibrary: true,
                    // ),
                    // CurrentlyReadingPage(collection: collection,),
                    // LibraryPage(
                    //   collection: collection,
                    //   // bookCollection: collection.wishlist,
                    //   // notNeededbookCollection: collection.library,
                    //   isLibrary: false,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: GestureDetector(
          onTap: () async {
            final result = await Navigator.of(context).pushNamed('/searchBook');
          },
          child: AnimatedContainer(
            //color: green,
            width: width,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: GlobalStyleProperties.mainColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 3.0,
                    spreadRadius: .5,
                  )
                ]),
            duration: const Duration(milliseconds: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isExpanded
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
                      )
                    : Container(),
                const Icon(
                  Icons.add,
                  color: GlobalStyleProperties.detailAndTextColor,
                  size: 25,
                ),
                isExpanded
                    ? const Expanded(
                        child: Text(
                          "Add Book!",
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: GlobalStyleProperties.detailAndTextColor,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
