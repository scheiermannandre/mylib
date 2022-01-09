// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalServerProperties.dart';
import 'package:mylib/GenericClasses/HTTPClientClasses/HTTPClient.dart';
import 'package:mylib/GenericClasses/MyLibRequestResults/UserExistsResponse.dart';
import 'package:mylib/GenericClasses/MyLibRequestResults/UserRegisteredResponse.dart';
import 'package:mylib/GenericClasses/PasswordValidationClasses/PasswordValidator.dart';
import 'package:mylib/GenericClasses/UserClasses/User.dart';
import 'package:mylib/Pages/Dialogs/AuthMessageDlg.dart';
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
    emailTextController.text = "hallo@gmail.com";
    passTextController.text = "ABC123efg.";
    passwordValidator.SetPassword(passTextController.text);
    focusNodePasswordTF.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNodePasswordTF.dispose();
    super.dispose();
  }

  Future<void> _tryRegister() async {
    FocusScope.of(context).unfocus();
    if (passwordValidator.IsValid) {
      User newUser = User(emailTextController.text, passTextController.text);
      bool userExists = await UserExists(newUser);
      if (userExists) {
        AuthMessageDlg(context, "User already exists!", "Ok!");
        return;
      }
      bool registered = await RegisterUser(newUser);
      if (!registered) {
        AuthMessageDlg(context, "Couldn't register User!", "Ok!");
        return;
      }
      bool buttonPressed =
          await AuthMessageDlg(context, "Successfully registered", "Login!");
      if (buttonPressed) {
        Navigator.pushReplacementNamed(context, '/login');
      }
      //Map<String, dynamic> response = await HTTPClient.Post(uri, newUser.toJson());
    }
  }

  Future<bool> UserExists(User user) async {
    Uri uri = GlobalServerProperties.GetUserExistUri(user.Email);
    String responseBody = await HTTPClient.get(uri);
    UserExistsResponse userExistsResponse =
        UserExistsResponse.fromJSON(json.decode(responseBody));

    return userExistsResponse.UserExists;
  }

  Future<bool> RegisterUser(User user) async {
    Uri uri = GlobalServerProperties.RegisterUri;
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    String body = encoder.convert(user.toJson());
    String responseBody = await HTTPClient.Post(uri, body);
    UserRegisteredResponse userRegisteredResponse =
        UserRegisteredResponse.fromJSON(json.decode(responseBody));

    return userRegisteredResponse.UserRegistered;
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
