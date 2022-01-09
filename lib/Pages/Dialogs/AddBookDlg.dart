// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/GlobalStyleProperties.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningState.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateLibrary.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateWishlist.dart';

Future<bool> MakeDecisionDlg(BuildContext context, String dlgMessage) async {
  var information = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
          child: Text(dlgMessage),
        ),
        actions: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
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
                            return GlobalStyleProperties.mainColor;
                          },
                        ),
                      ),
                      child: Text(
                        "Go ahead",
                        style: TextStyle(
                            color: GlobalStyleProperties.detailAndTextColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              ),
              // Container(
              //   width: 150,
              //   height: 50,
              //   child: TextButton(
              //       style: ButtonStyle(
              //         shape: MaterialStateProperty.resolveWith(
              //           (states) => RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30.0),
              //           ),
              //         ),
              //         backgroundColor: MaterialStateProperty.resolveWith<Color>(
              //           (Set<MaterialState> states) {
              //             return GlobalStyleProperties.mainColor;
              //           },
              //         ),
              //       ),
              //       child: Text(
              //         'Put To Wishlist',
              //         style: TextStyle(
              //             color: GlobalStyleProperties.detailAndTextColor),
              //       ),
              //       onPressed: () {
              //         Navigator.of(context).pop(OwningStateWishlist());
              //       }),
              // ),
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
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
