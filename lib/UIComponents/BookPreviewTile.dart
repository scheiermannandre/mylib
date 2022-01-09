// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/BookClasses/Book.dart';

class BookPreviewTile extends StatefulWidget {
  final Book book;
  final VoidCallback onAddToLibPress;
  final VoidCallback onAddToWishlistPress;

  final VoidCallback onShowDetailsPress;
  //final Function onPicTureTab;

  BookPreviewTile({
    Key? key,
    required this.book,
    required this.onAddToLibPress,
    required this.onAddToWishlistPress,
    required this.onShowDetailsPress,
    //this.onPicTureTab,
  }) : super(key: key);
  @override
  _BookPreviewTileState createState() => _BookPreviewTileState();
}

class _BookPreviewTileState extends State<BookPreviewTile> {
  @override
  Widget build(BuildContext context) {
    Color green = Color.fromARGB(255, 48, 176, 99);

    Color black = Color.fromARGB(255, 59, 60, 59);

    ImageProvider image;

    if (widget.book.imageLink == "") {
      image = AssetImage('assets/images/NoPicture.png');
    } else {
      image = Image.network(widget.book.imageLink.toString()).image;
    }
    return GestureDetector(
      onTap: widget.onShowDetailsPress,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width * 0.975,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3.0,
              spreadRadius: .5,
            )
          ],
          color: black,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Container(
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
                height: MediaQuery.of(context).size.height * 0.155,
                width: MediaQuery.of(context).size.width * 0.225,
              ),
            ),
            Container(
              //color: Colors.blue,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Text(
                      widget.book.title,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 14,
                        color: green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      widget.book.author.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.library_books_outlined),
                        onPressed: widget.onAddToLibPress,
                        color: green,
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart_outlined),
                        onPressed: widget.onAddToWishlistPress,
                        color: green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: IconButton(
                onPressed: widget.onShowDetailsPress,
                icon: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
