// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TextTile extends StatefulWidget {
  TextTile(
      {Key? key, required this.icon, required this.text, required this.color})
      : super(key: key);
  IconData icon;
  String text;
  Color color;

  @override
  _TextTileState createState() => _TextTileState();
}

class _TextTileState extends State<TextTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: widget.color,
          ),
          const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          Text(
            widget.text.toString(),
            style: TextStyle(
                color: widget.color, fontFamily: 'OpenSans', fontSize: 13),
          ),
        ],
      ),
    );
  }
}
