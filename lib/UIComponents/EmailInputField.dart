// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';

class EmailInputField extends StatefulWidget {
  final TextEditingController emailText = TextEditingController();

  EmailInputField({Key? key}) : super(key: key);

  @override
  _EmailInputFieldState createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GlobalStyleProperties.boxDecorationStyle,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.email,
              color: GlobalStyleProperties.mainColor,
            ),
            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            Expanded(
              child: TextField(
                controller: widget.emailText,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: GlobalStyleProperties.mainColor,
                  fontFamily: 'OpenSans',
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your Email',
                  hintStyle: GlobalStyleProperties.hintTextStyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
