// ignore_for_file: file_names

import 'package:flutter/material.dart';

Future AuthMessageDlg(
    BuildContext context, String message, String buttonText) async {
  var information = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return const Color.fromARGB(255, 48, 176, 99);
                          },
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
  return information;
  // if (information == "close") {
  //   Navigator.of(context, rootNavigator: true).pop();
  // }
}
