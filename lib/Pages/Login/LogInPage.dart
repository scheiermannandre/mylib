// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';

import 'package:mylib/GenericClasses/GlobalUserProperties.dart';
import 'package:mylib/GenericClasses/HttpClient.dart';
import 'package:mylib/Pages/Dialogs/AuthMessageDlg.dart';

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
            _buildText("SignIn"),
            _buildEmailTF(),
            _buildPasswordTF(),
            _buildLoginBtn(),
            _buildSignupBtn(),
            _buildForgotPasswordBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildCommonScaffold(Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: GlobalStyleProperties.boxDecorationStyle,
          height: 60.0,
          child: child,
        ),
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: GlobalStyleProperties.detailAndTextColor,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmailTF() {
    return _buildCommonScaffold(
      TextField(
        controller: emailText,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          color: GlobalStyleProperties.mainColor,
          fontFamily: 'OpenSans',
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.email,
            color: GlobalStyleProperties.mainColor,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 60,
            minHeight: 48,
          ),
          hintText: 'Enter your Email',
          hintStyle: GlobalStyleProperties.hintTextStyle,
        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
    return _buildCommonScaffold(
      TextField(
        controller: passText,
        obscureText: true,
        style: const TextStyle(
          color: GlobalStyleProperties.mainColor,
          fontFamily: 'OpenSans',
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: GlobalStyleProperties.mainColor,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 60,
            minHeight: 48,
          ),
          hintText: 'Enter your Password',
          hintStyle: GlobalStyleProperties.hintTextStyle,
        ),
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 5, // Space between underline and text
          ),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: GlobalStyleProperties.mainColor,
            width: 1.0, // Underline thickness
          ))),
          child: const Text(
            'Forgot Password?',
            style: GlobalStyleProperties.textStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _tryLogin(),
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: GlobalStyleProperties.mainColor,
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: GlobalStyleProperties.detailAndTextColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => {Navigator.pushReplacementNamed(context, '/signup')},
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.only(
            bottom: 5, // Space between underline and text
          ),
          child: const Text(
            'Don\'t have an Account?',
            style: GlobalStyleProperties.textStyle,
          ),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(2.5, 0, 2.5, 0)),
        Container(
          padding: const EdgeInsets.only(
            bottom: 5, // Space between underline and text
          ),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: GlobalStyleProperties.mainColor,
            width: 1.0, // Underline thickness
          ))),
          child: const Text(
            'SignUp!',
            style: GlobalStyleProperties.textStyle,
          ),
        ),
      ]),
    );
  }
}
