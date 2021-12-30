// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylib/GenericClasses/PasswordValidationClasses/Exceptions/InsecurePasswordLengthException.dart';
import 'dart:convert';

import 'package:mylib/GenericClasses/PasswordValidationClasses/PasswordValidator.dart';

void main() {
  group('Password validation', () {
    test("Test - PasswordValidator with default length = 10", () {
      PasswordValidator validator = PasswordValidator();
      expect(PasswordValidator.DefaultPasswordLength, validator.PasswordLength);
    });
    test("Test - PasswordValidator with length = 15", () {
      PasswordValidator validator = PasswordValidator(passwordLength: 15);
      expect(15, validator.PasswordLength);
    });

    test("Test - PasswordValidator with invalid length < 10", () {
      expect(() => PasswordValidator(passwordLength: 9),
          throwsA(const TypeMatcher<InsecurePasswordLengthException>()));
    });
  });
}
