// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';

class HeadlineText extends StatefulWidget {
  HeadlineText({Key? key, required this.text}) : super(key: key);
  String text;
  @override
  _HeadlineTextState createState() => _HeadlineTextState();
}

class _HeadlineTextState extends State<HeadlineText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
        color: GlobalStyleProperties.detailAndTextColor,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
