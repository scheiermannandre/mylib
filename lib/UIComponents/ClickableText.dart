// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';

class ClickableText extends StatefulWidget {
  ClickableText(
      {Key? key,
      this.unclickableMessage = "",
      required this.clickableMessage,
      required this.onTap})
      : super(key: key);
  String unclickableMessage;
  String clickableMessage;
  VoidCallback onTap;
  @override
  _ClickableTextState createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  double spaceBetweenUnderlineAndText = 0; //0 sets the next possible space

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(
            bottom:
                spaceBetweenUnderlineAndText, // Space between underline and text
          ),
          child: Text(
            widget.unclickableMessage,
            style: GlobalStyleProperties.textStyle,
          ),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(2.5, 0, 2.5, 0)),
        Container(
          padding: EdgeInsets.only(
            bottom:
                spaceBetweenUnderlineAndText, // Space between underline and text
          ),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: GlobalStyleProperties.mainColor,
            width: 1.0, // Underline thickness
          ))),
          child: InkWell(
            onTap: widget.onTap,
            child: Text(
              widget.clickableMessage,
              style: GlobalStyleProperties.textStyle,
            ),
          ),
        ),
      ],
    );
  }
}
