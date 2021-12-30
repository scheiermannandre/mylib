// ignore_for_file: file_names

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';
import 'package:mylib/UIComponents/TextTile.dart';

class PasswordInputValidaionField extends StatefulWidget {
  bool hidePassword = true;
  bool hasMinLength = false;
  bool hasDigits = false;
  bool hasUppercase = false;
  bool hasLowerCase = false;
  bool hasSpecialCharacters = false;

  PasswordInputValidaionField({
    Key? key,
    required this.textController,
  }) : super(key: key);
  TextEditingController textController;
  // List<String> passwordConditions;

  @override
  _PasswordInputValidaionFieldState createState() =>
      _PasswordInputValidaionFieldState();
}

class _PasswordInputValidaionFieldState
    extends State<PasswordInputValidaionField> with TickerProviderStateMixin {
  AnimationController? _controller;

  bool selected = false;
  bool expanded = false;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      upperBound: 0.5,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GlobalStyleProperties.boxDecorationStyle,
      child: Column(
        children: [
          Padding(
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
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
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
                const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_controller!),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        if (expanded) {
                          _controller!.reverse(from: 0.5);
                        } else {
                          _controller!.forward(from: 0.0);
                        }
                        expanded = !expanded;
                        selected = !selected;
                      });
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: selected ? _buildPasswordConditions() : Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordConditions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: Column(
        children: [
          TextTile(
              icon: Icons.cancel_outlined,
              text: '10 Characters',
              color: Colors.red),
          TextTile(
              icon: Icons.cancel_outlined,
              text: 'one uppercase Letter',
              color: Colors.red),
          TextTile(
              icon: Icons.cancel_outlined,
              text: 'one lowercase Letter',
              color: Colors.red),
          TextTile(
              icon: Icons.cancel_outlined,
              text: 'one Number',
              color: Colors.red),
          TextTile(
              icon: Icons.cancel_outlined,
              text: 'one Special Character',
              color: Colors.red),
        ],
      ),
    );
  }
}
