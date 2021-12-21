// ignore_for_file: file_names

import 'package:flutter/material.dart';

class GlobalStyleProperties {
  static const Color mainColor = Color.fromARGB(255, 48, 176, 99);
  static const Color subColor = Color.fromARGB(255, 59, 60, 59);
  static const Color detailAndTextColor = Colors.white;
  static const Color errorColor = Colors.red;
  static const hintTextStyle = TextStyle(
    color: mainColor,
    fontFamily: 'OpenSans',
  );

  static const TextStyle hintTextStyleOnError = TextStyle(
    color: errorColor,
    fontFamily: 'OpenSans',
  );

  static const TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  static BoxDecoration boxDecorationStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}
