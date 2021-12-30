// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mylib/GenericClasses/PasswordValidationClasses/PasswordValidator.dart';
import 'package:mylib/UIComponents/BigRoundedButton.dart';
import 'package:mylib/UIComponents/ClickableText.dart';
import 'package:mylib/UIComponents/EmailInputField.dart';
import 'package:mylib/UIComponents/HeadlineText.dart';
import 'package:mylib/UIComponents/PasswordInputValidationField.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();
  PasswordValidator passwordValidator = PasswordValidator(passwordLength: 10);

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
    FocusScope.of(context).unfocus();

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
                passwordValidator: passwordValidator,
              ),
              BigRoundedButton(
                  onpressed: () => {
                        if (passwordValidator.IsValid)
                          {_tryRegister()}
                        else
                          {
                            //DoNothing
                          }
                      },
                  text: "Register"),
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
