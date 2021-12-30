// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';
import 'package:mylib/GenericClasses/PasswordValidationClasses/PasswordCondition.dart';
import 'package:mylib/GenericClasses/PasswordValidationClasses/PasswordValidator.dart';
import 'package:mylib/UIComponents/TextTile.dart';

class PasswordInputValidaionField extends StatefulWidget {
  bool hidePassword = true;

  PasswordInputValidaionField({
    Key? key,
    required this.textController,
    required this.passwordValidator,
  }) : super(key: key);
  TextEditingController textController;
  PasswordValidator passwordValidator;

  @override
  _PasswordInputValidaionFieldState createState() =>
      _PasswordInputValidaionFieldState();
}

class _PasswordInputValidaionFieldState
    extends State<PasswordInputValidaionField> with TickerProviderStateMixin {
  AnimationController? _controller;
  //FocusNode focusNode = FocusNode();

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
    // focusNode.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
    //focusNode.dispose();
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
                Icon(
                  Icons.lock,
                  color: _evaluateColor(),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                Expanded(
                  child: TextField(
                    onChanged: (text) => {
                      setState(() {
                        widget.passwordValidator.SetPassword(text);
                      })
                    },
                    //focusNode: focusNode,
                    controller: widget.textController,
                    obscureText: widget.hidePassword,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(
                      color: _evaluateColor(),
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
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _evaluateColor(),
                  ),
                  //color: GlobalStyleProperties.mainColor,
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

  Color _evaluateColor() {
    if (widget.passwordValidator.IsPasswordEmpty()) {
      return GlobalStyleProperties.mainColor;
    } else {
      return widget.passwordValidator.IsValid
          ? GlobalStyleProperties.mainColor
          : GlobalStyleProperties.errorColor;
    }
  }

  Widget _buildPasswordConditions() {
    List<PasswordCondition> passwordConditions =
        widget.passwordValidator.GetConditions();
    Column conditionColumn = Column(
      children: [],
    );

    for (PasswordCondition condition in passwordConditions) {
      conditionColumn.children.add(
        TextTile(
            icon: condition.IsFulfilled
                ? Icons.check_circle_outline
                : Icons.cancel_outlined,
            text: condition.ConditionDescription,
            color: condition.IsFulfilled ? Colors.green : Colors.red),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: conditionColumn,
    );
  }
}
