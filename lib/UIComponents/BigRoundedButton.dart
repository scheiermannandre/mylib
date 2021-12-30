// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';

class BigRoundedButton extends StatefulWidget {
  BigRoundedButton({Key? key, required this.onpressed, required this.text})
      : super(key: key);
  VoidCallback onpressed;
  String text;
  @override
  _BigRoundedButtonState createState() => _BigRoundedButtonState();
}

class _BigRoundedButtonState extends State<BigRoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.infinity, 50),
            elevation: 5.0,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            primary: GlobalStyleProperties.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: widget.onpressed,
          child: Text(
            widget.text,
            style: const TextStyle(
              color: GlobalStyleProperties.detailAndTextColor,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ));
  }
}
