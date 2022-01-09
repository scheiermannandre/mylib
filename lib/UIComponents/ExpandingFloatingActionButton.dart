// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';

class ExpandingFloatingActionButton extends StatefulWidget {
  late VoidCallback onTab;
  late double width;
  late bool isExpanded;
  late String onExpandText;
  ExpandingFloatingActionButton({
    Key? key,
    required this.onTab,
    required this.width,
    required this.isExpanded,
    required this.onExpandText,
  }) : super(key: key);

  @override
  _ExpandingFloatingActionButtonState createState() =>
      _ExpandingFloatingActionButtonState();
}

class _ExpandingFloatingActionButtonState
    extends State<ExpandingFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTab,
      child: AnimatedContainer(
        width: widget.width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: GlobalStyleProperties.mainColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 3.0,
                spreadRadius: .5,
              )
            ]),
        duration: const Duration(milliseconds: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.isExpanded
                ? const Padding(
                    padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
                  )
                : Container(),
            const Icon(
              Icons.add,
              color: GlobalStyleProperties.detailAndTextColor,
              size: 25,
            ),
            widget.isExpanded
                ? Expanded(
                    child: Text(
                      widget.onExpandText,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        color: GlobalStyleProperties.detailAndTextColor,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
