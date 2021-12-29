// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController passwordTextController = TextEditingController();
  bool hidePassword = true;
  PasswordInputField({Key? key}) : super(key: key);

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GlobalStyleProperties.boxDecorationStyle,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                controller: widget.passwordTextController,
                obscureText: widget.hidePassword,
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
                    widget.hidePassword = !widget.hidePassword;
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
