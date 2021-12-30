// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';

class PasswordInputField extends StatefulWidget {
  PasswordInputField({Key? key, required this.textController})
      : super(key: key);
  TextEditingController textController;

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool hidePassword = true;

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
              Icons.lock,
              color: GlobalStyleProperties.mainColor,
            ),
            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            Expanded(
              child: TextField(
                controller: widget.textController,
                obscureText: hidePassword,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                  color: GlobalStyleProperties.mainColor,
                  fontFamily: 'OpenSans',
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your Password',
                  hintStyle: GlobalStyleProperties.hintTextStyle,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            IconButton(
              onPressed: () => {
                setState(
                  () {
                    hidePassword = !hidePassword;
                  },
                ),
              },
              icon: const Icon(
                Icons.remove_red_eye,
                color: GlobalStyleProperties.mainColor,
              ),
              color: GlobalStyleProperties.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
