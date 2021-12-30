// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';
import 'package:mylib/UIComponents/BigRoundedButton.dart';
import 'package:mylib/UIComponents/ClickableText.dart';
import 'package:mylib/UIComponents/EmailInputField.dart';
import 'package:mylib/UIComponents/HeadlineText.dart';
import 'package:mylib/UIComponents/PasswordInputValidationField.dart';

class SignUpPage extends StatefulWidget {
  bool hasMinLength = false;
  bool hasDigits = false;
  bool hasUppercase = false;
  bool hasLowerCase = false;
  bool hasSpecialCharacters = false;
  bool passwordFormatValid = true;
  bool passwordMatch = true;

  SignUpPage({
    Key? key,
  }) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();
  final FocusNode focusNodePasswordTF = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNodePasswordTF.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNodePasswordTF.dispose();
    super.dispose();
  }

  void _passwordTextChanged() {
    if (passTextController.text.isNotEmpty) {
      if (passTextController.text[passTextController.text.length - 1] == " ") {
        passTextController.text = passTextController.text.trimRight();
        passTextController.selection = TextSelection.fromPosition(
          TextPosition(offset: passTextController.text.length),
        );
      }
    }
  }

  Future<void> _tryRegister() async {
    //FocusScope.of(context).unfocus();

    // if (passTextController.text == repeatPassTextController.text &&
    //     passTextController.text.isNotEmpty &&
    //     widget.passwordFormatValid &&
    //     widget.passwordMatch) {
    //   int userId = await HttpCall.postRegistrationData(
    //       emailTextController.text, passTextController.text);

    //   if (userId == -2) {
    //     AuthMessageDlg(
    //         context, 'No connection to server... \n😑', "Try again later!");
    //   } else if (userId == -1) {
    //     AuthMessageDlg(context, "User already exists.", "Login!");
    //     //widget.tabController.animateTo(0);
    //   } else {
    //     AuthMessageDlg(context, "User succesfully registered.", "Login!");
    //     //widget.tabController.animateTo(0);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    widget.hasUppercase = passTextController.text.contains(RegExp(r'[A-Z]'));
    widget.hasDigits = passTextController.text.contains(RegExp(r'[0-9]'));
    widget.hasLowerCase = passTextController.text.contains(RegExp(r'[a-z]'));
    widget.hasSpecialCharacters =
        passTextController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    widget.hasMinLength = passTextController.text.length > 10;

    if ((widget.hasUppercase &&
            widget.hasDigits &&
            widget.hasLowerCase &&
            widget.hasSpecialCharacters &&
            widget.hasMinLength) ||
        (passTextController.text.isEmpty && !focusNodePasswordTF.hasFocus)) {
      /*
         * Wenn alle notwendigkeiten eingehalten sind, wird das Passwort als gültig gekennzeichent.
         */
      widget.passwordFormatValid = true;
    } else {
      widget.passwordFormatValid = false;
      widget.passwordMatch = false;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 10.0,
          ),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              ),
              const Center(
                child: FlutterLogo(
                  size: 200,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              ),
              HeadlineText(text: "Sign Up"),
              const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
              EmailInputField(textController: emailTextController),
              const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
              PasswordInputValidaionField(
                textController: passTextController,
              ),
              BigRoundedButton(
                  onpressed: () => _tryRegister(), text: "Register"),
              ClickableText(
                unclickableMessage: "Already have an account?",
                clickableMessage: "Login!",
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
