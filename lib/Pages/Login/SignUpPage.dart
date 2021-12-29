// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';
import 'package:mylib/UIComponents/EmailInputField.dart';
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

  Widget _buildEntryText() {
    return const Text(
      'Sign Up',
      style: TextStyle(
        color: GlobalStyleProperties.detailAndTextColor,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
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

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _tryRegister(),
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: GlobalStyleProperties.mainColor,
        child: const Text(
          'Register',
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

  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () => {Navigator.pushNamed(context, '/login')},
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.only(
            bottom: 5, // Space between underline and text
          ),
          child: const Text(
            'Already have an Account?',
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
            'Login!',
            style: GlobalStyleProperties.textStyle,
          ),
        ),
      ]),
    );
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
              _buildEntryText(),
              EmailInputField(),
              const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
              PasswordInputValidaionField(),
              _buildRegisterBtn(),
              _buildLoginBtn(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPasswordExtensionTile() {
    return <Widget>[
      _buildSubTile('You need at least 10 Characters', widget.hasMinLength),
      _buildSubTile(
          'You need at least one uppercase Letter', widget.hasUppercase),
      _buildSubTile(
          'You need at least one lowercase Letter', widget.hasLowerCase),
      _buildSubTile('You need at least one Number', widget.hasDigits),
      _buildSubTile('You need at least one Special Character',
          widget.hasSpecialCharacters),
    ];
  }

  Widget _buildSubTile(String text, bool fulfilled) {
    Color color = fulfilled == false
        ? GlobalStyleProperties.errorColor
        : GlobalStyleProperties.mainColor;
    Icon icon = Icon(
      fulfilled == false ? Icons.cancel_outlined : Icons.check_circle_outline,
      color: color,
      size: 16,
    );
    return SizedBox(
      height: 50,
      child: ListTile(
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.fromLTRB(22, 0, 0, 0),
        dense: true,
        leading: icon,
        title: Transform.translate(
          offset: const Offset(-17, 0),
          child: Text(
            text,
            style:
                TextStyle(color: color, fontFamily: 'OpenSans', fontSize: 13),
          ),
        ),
      ),
    );
  }
}
