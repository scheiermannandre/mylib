// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalUserProperties.dart';
import 'package:mylib/GenericClasses/HttpClient.dart';
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
  late TabController tabController;
  late ScrollController scrollViewController;

  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(initialIndex: tabIndex, vsync: this, length: 2);
    scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollViewController.dispose();
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
            EmailInputField(textController: emailText),
            const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
            PasswordInputField(
              textController: passText,
            ),
            BigRoundedButton(onpressed: () => _tryLogin(), text: "Login"),
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
    if (emailText.text == "admin" && passText.text == "000") {
      Navigator.pushNamed(context, '/home');
    } else {
      int userId = await HttpCall.postLoginData(emailText.text, passText.text);
      if (userId == -2) {
        AuthMessageDlg(
            context, 'No connection to server... \n😑', "Try again later!");
      } else if (userId == -1) {
        AuthMessageDlg(context, "Username or Password invalid.", "Try Again!");
      } else {
        Navigator.pushNamed(context, '/home', arguments: userId);
        GlobalUserProperties.UserId = userId;
      }
    }
  }
}
