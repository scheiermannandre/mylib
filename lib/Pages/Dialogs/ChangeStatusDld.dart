// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingState.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateFinished.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateReading.dart';

Future changeStatusDialog(
    BuildContext context, ReadingState readingState) async {
  String text;
  if (readingState.toString() == ReadingStateNotStarted().toString()) {
    text = "Did you start reading?";
  } else if (readingState.toString() == ReadingStateReading().toString()) {
    text = "Did you finish reading?";
  } else if (readingState.toString() == ReadingStateFinished().toString()) {
    text = "Do you want to reset the status?";
  } else {
    throw Exception("ERROR");
  }
  var information = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
            child: Text(text, textAlign: TextAlign.center),
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 150,
                    height: 50,
                    child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Color.fromARGB(255, 48, 176, 99);
                            },
                          ),
                        ),
                        child: Text(
                          'Yeap!',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop("Change");
                        }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                ),
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.white;
                      },
                    ),
                  ),
                  child: Text(
                    'Nope!',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    // Hier passiert etwas anderes
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ]);
    },
  );
  return information;
}
