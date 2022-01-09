// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningState.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateLibrary.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateWishlist.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';
import 'package:mylib/Pages/Dialogs/AddBookDlg.dart';
import 'package:mylib/Pages/Dialogs/WhereToAddBookDlg.dart';

class ShowBookDetailsPage extends StatefulWidget {
  Book book;
  ShowBookDetailsPage({
    Key? key,
    required this.book,
  }) : super(key: key);
  @override
  _ShowBookDetailsPageState createState() => _ShowBookDetailsPageState();
}

class _ShowBookDetailsPageState extends State<ShowBookDetailsPage>
    with SingleTickerProviderStateMixin {
  Color green = Color.fromARGB(255, 48, 176, 99);
  Color black = Color.fromARGB(255, 59, 60, 59);
  Color grey = Color.fromARGB(255, 95, 91, 91);

  late AnimationController _controller;

  late Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..forward();

    _animation = Tween<Offset>(
      begin: const Offset(1.5, 0.0),
      end: const Offset(-0.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
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
    String title = widget.book.title;
    String subTitle = widget.book.subTitle.toString();
    String description = widget.book.description.toString();
    String imageStr = widget.book.imageLink.toString();

    ImageProvider image;

    if (imageStr == "") {
      image = AssetImage('assets/images/NoPicture.png');
    } else {
      //smallThumbnail -> zoom=5
      //thumbnail -> zoom=1
      //small -> zoom=2
      //medium -> zoom=3
      //large -> zoom=4
      //extraLarge -> zoom=6
      imageStr = imageStr.replaceAll("zoom=1", "zoom=2");

      image = Image.network(imageStr).image;
    }

    Widget _buildContainer(String header, String content, int maxLines) {
      return Container(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        decoration: BoxDecoration(
          color: black,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3.0,
              spreadRadius: .5,
            )
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              maxLines: 1,
              style: TextStyle(
                fontSize: 15,
                color: green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            ),
            Text(
              content,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                //fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: green,
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: TextStyle(
              //fontSize: 18,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    OwningState? result = await WhereToAddBookDlg(context);
                    if (result == null) {
                      return;
                    }
                    Book newBook = widget.book;
                    newBook.readingState = ReadingStateNotStarted();
                    if (result.toString() == OwningStateWishlist().toString()) {
                      newBook.owningState = OwningStateWishlist();
                    } else {
                      newBook.owningState = OwningStateLibrary();
                    }
                    Navigator.of(context).pop(newBook);
                  },
                  child: Icon(Icons.add),
                )),
          ],
        ),
        body: ListView.separated(
          itemCount: 4,
          padding: EdgeInsets.fromLTRB(7.5, 5, 7.5, 5),
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 10);
          },
          itemBuilder: (BuildContext context, int index) {
            return index == 0
                ? Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3.0,
                          spreadRadius: .5,
                        )
                      ],
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: MediaQuery.of(context).size.height * 0.66,
                    //width: MediaQuery.of(context).size.width * 0.225,
                  )
                : index == 1
                    ? _buildContainer("Title", title, 2)
                    : index == 2
                        ? _buildContainer("Subtitle", subTitle, 2)
                        : _buildContainer("Description", description, 100);
          },
        ),
        floatingActionButton: SlideTransition(
          position: _animation,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: green,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 3.0,
                    spreadRadius: .5,
                  )
                ]),
            child: FloatingActionButton.extended(
              backgroundColor: green,
              foregroundColor: Colors.white,
              onPressed: () async {
                OwningState? result = await WhereToAddBookDlg(context);
                if (result == null) {
                  return;
                }
                Book newBook = widget.book;
                newBook.readingState = ReadingStateNotStarted();
                if (result.toString() == OwningStateWishlist().toString()) {
                  newBook.owningState = OwningStateWishlist();
                } else {
                  newBook.owningState = OwningStateLibrary();
                }
                Navigator.of(context).pop(newBook);
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text("Add Book"),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }
}
