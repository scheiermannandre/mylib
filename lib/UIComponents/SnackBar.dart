// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomSnackbar {
  final String message;
  const CustomSnackbar({
    required this.message,
  });

  static showSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    Color black = Color.fromARGB(200, 59, 60, 59);
    final snack = SnackBar(
      backgroundColor: black,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: Duration(milliseconds: 1000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
