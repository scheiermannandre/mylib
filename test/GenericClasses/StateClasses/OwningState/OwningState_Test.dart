// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningState.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateLibrary.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateWishlist.dart';

void main() {
  group('OwningState.toString Test', () {
    test("OwningStateLibrary.toString test", () {
      final OwningState owningState = OwningStateLibrary();
      expect("OwningStateLibrary", owningState.toString());
    });
    test("OwningStateWishlist.toString test", () {
      final OwningState owningState = OwningStateWishlist();
      expect("OwningStateWishlist", owningState.toString());
    });
  });
}
