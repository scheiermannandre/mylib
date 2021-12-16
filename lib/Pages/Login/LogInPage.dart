// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/Constants.dart';

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
          decoration: Globals.boxDecorationStyle,
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
        color: Globals.detailAndTextColor,
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
          color: Globals.mainColor,
          fontFamily: 'OpenSans',
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.email,
            color: Globals.mainColor,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 60,
            minHeight: 48,
          ),
          hintText: 'Enter your Email',
          hintStyle: Globals.hintTextStyle,
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
          color: Globals.mainColor,
          fontFamily: 'OpenSans',
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: Globals.mainColor,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 60,
            minHeight: 48,
          ),
          hintText: 'Enter your Password',
          hintStyle: Globals.hintTextStyle,
        ),
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        child: const Text(
          'Forgot Password?',
          style: Globals.textStyle,
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
        color: Globals.mainColor,
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Globals.detailAndTextColor,
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
    // if (emailText.text == "admin" && passText.text == "000") {
    //   Navigator.pushNamed(context, '/home');
    // } else {
    //   int userId = await HttpCall.postLoginData(emailText.text, passText.text);
    //   if (userId == -2) {
    //     authMessageDlg(
    //         context, 'No connection to server... \n😑', "Try again later!");
    //   } else if (userId == -1) {
    //     authMessageDlg(context, "Username or Password invalid.", "Try Again!");
    //   } else {
    //     Navigator.pushNamed(context, '/home', arguments: userId);
    //     GlobalVariables.userId = userId;
    //   }
    // }
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => {},
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Globals.detailAndTextColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Globals.detailAndTextColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
