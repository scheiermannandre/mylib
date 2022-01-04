// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/BookClasses/Book.dart';


void descriptionDlg(int index, Book book, BuildContext context) async {
  Color green = Color.fromARGB(255, 48, 176, 99);
  Color textFields = Color.fromARGB(255, 216, 249, 218);
  Color grey = Color.fromARGB(255, 95, 91, 91);

  String title = book.title;
  String? author = book.author;

  String? subTitle = book.subTitle;
  String? description = book.description;

  if (title == null) {
    title = "";
  }
  if (author == null) {
    author = "";
  }
  if (subTitle == null) {
    subTitle = "";
  }
  if (description == null) {
    description = "";
  }
  var information = await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        backgroundColor: grey,
        titlePadding: EdgeInsets.fromLTRB(8.75, 10, 8.75, 0),
        title: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                // constraints: BoxConstraints(
                //   maxHeight: MediaQuery.of(context).size.height * 0.15,
                // ),
                child: TextFormField(
                  maxLines: null,
                  initialValue: title,
                  readOnly: true,
                  style: TextStyle(
                    fontSize: 20,
                    color: green,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(8.75, 0, 8.75, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              "Author",
              style: TextStyle(
                  color: green, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(8.75, 0, 8.75, 15),
            child: TextFormField(
              maxLines: null,
              initialValue: author,
              readOnly: true,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.75, 0, 8.75, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              "Subtitle",
              style: TextStyle(
                  color: green, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(8.75, 0, 8.75, 15),
            child: TextFormField(
              maxLines: null,
              initialValue: subTitle,
              readOnly: true,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(8.75, 0, 8.75, 0),
            child: Text(
              "Description",
              style: TextStyle(
                  color: green, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(8.75, 0, 8.75, 15),
            child: TextFormField(
              maxLines: null,
              initialValue: description,
              readOnly: true,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      );
    },
  );
}
