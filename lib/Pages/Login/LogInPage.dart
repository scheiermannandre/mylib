// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalServerProperties.dart';
import 'package:mylib/GenericClasses/HTTPClientClasses/HTTPClient.dart';
import 'package:mylib/GenericClasses/MyLibRequestResults/UserLoginResponse.dart';
import 'package:mylib/GenericClasses/PasswordValidationClasses/PasswordValidator.dart';
import 'package:mylib/GenericClasses/UserClasses/User.dart';
import 'package:mylib/Pages/Dialogs/AuthMessageDlg.dart';
import 'package:mylib/UIComponents/BigRoundedButton.dart';
import 'package:mylib/UIComponents/ClickableText.dart';
import 'package:mylib/UIComponents/EmailInputField.dart';
import 'package:mylib/UIComponents/HeadlineText.dart';
import 'package:mylib/UIComponents/PasswordInputField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  int tabIndex = 0;

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();
  PasswordValidator passwordValidator = PasswordValidator(passwordLength: 10);

  @override
  void initState() {
    super.initState();
    emailTextController.text = "hallo@gmail.com";
    passTextController.text = "ABC123efg.";
    passwordValidator.SetPassword(passTextController.text);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            HeadlineText(text: "Sign In"),
            const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
            EmailInputField(textController: emailTextController),
            const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
            PasswordInputField(
              textController: passTextController,
            ),
            BigRoundedButton(onpressed: _tryLogin, text: "Login"),
            ClickableText(
              unclickableMessage: "Don't have an account?",
              clickableMessage: "Sign Up!",
              onTap: () => Navigator.pushReplacementNamed(context, '/signup'),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
            ClickableText(
              clickableMessage: "Forgot Password?",
              onTap: () => print('Forgot Password Button Pressed'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _tryLogin() async {
    print("Trying to login");
    FocusScope.of(context).unfocus();
    passwordValidator.SetPassword(passTextController.text);
    if (!passwordValidator.IsValid) {
      AuthMessageDlg(context, "Invalid password format!", "Try Again!");
      return;
    }
    User user = User(emailTextController.text, passTextController.text);
    user.UserId = -1;
    UserLoginResponse userLoginResponse = await LoginUser(user);
    if (!userLoginResponse.LoginApproved) {
      AuthMessageDlg(context, "Username or Password wrong!", "Try Again!");
      return;
    }
    Navigator.pushReplacementNamed(context, '/home',
        arguments: userLoginResponse.UserId);
    // if (emailText.text == "admin" && passText.text == "000") {
    //   Navigator.pushNamed(context, '/home');
    // } else {
    //   int userId = await HttpCall.postLoginData(emailText.text, passText.text);
    //   if (userId == -2) {
    //     AuthMessageDlg(
    //         context, 'No connection to server... \n😑', "Try again later!");
    //   } else if (userId == -1) {
    //     AuthMessageDlg(context, "Username or Password invalid.", "Try Again!");
    //   } else {
    //     Navigator.pushNamed(context, '/home', arguments: userId);
    //     GlobalUserProperties.UserId = userId;
    //   }
    // }
  }

  Future<UserLoginResponse> LoginUser(User user) async {
    Uri uri = GlobalServerProperties.LoginUri;
    String responseBody = await HTTPClient.Post(uri, user.toJson());
    UserLoginResponse userLoginResponse =
        UserLoginResponse.fromJson(json.decode(responseBody));

    return userLoginResponse;
  }
}
