// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/BookClasses/Book.dart';

class BookListCard extends StatefulWidget {
  final Book book;
  final VoidCallback onStatusPress;
  final VoidCallback onPicTureTab;

  BookListCard({
    Key? key,
    required this.book,
    required this.onStatusPress,
    required this.onPicTureTab,
  }) : super(key: key);
  @override
  _BookListCardState createState() => _BookListCardState();
}

class _BookListCardState extends State<BookListCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color green = Color.fromARGB(255, 48, 176, 99);
    String? author = widget.book.author;
    String title = widget.book.title;
    String? subTitle = widget.book.subTitle;
    String? imageStr = widget.book.imageLink;
    ImageProvider image;

    if (author == null) {
      author = "";
    }
    if (title == null) {
      title = "";
    }
    if (subTitle == null) {
      subTitle = "";
    }
    if (imageStr == null) {
      image = AssetImage('assets/images/NoPicture.png');
    } else {
      image = Image.network(widget.book.imageLink.toString()).image;
    }

    return InkWell(
      onTap: widget.onPicTureTab,
      child: Align(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.75,
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey,
                blurRadius: 5.0,
                spreadRadius: 0,
              )
            ],
            image: DecorationImage(
              image: image,
              fit: BoxFit.fill,
              alignment: Alignment.center,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: green,
            child: IconButton(
              iconSize: 25,
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                widget.onStatusPress();
                print(widget.book.readingState);
                setState(() {});
              },
            ),
          ),
        ),
      ),
    );
  }
}
