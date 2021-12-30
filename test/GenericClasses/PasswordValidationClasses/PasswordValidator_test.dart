// ignore_for_file: file_names, unused_import

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylib/GenericClasses/PasswordValidationClasses/Exceptions/InsecurePasswordLengthException.dart';
import 'package:mylib/GenericClasses/PasswordValidationClasses/PasswordCondition.dart';
import 'dart:convert';

import 'package:mylib/GenericClasses/PasswordValidationClasses/PasswordValidator.dart';

void main() {
  group('Password validation', () {
    Map<String, PasswordCondition> getCondtionMap(
        PasswordValidator passwordValidator) {
      List<PasswordCondition> conditions = passwordValidator.GetConditions();
      Map<String, PasswordCondition> _passwordConditions = Map();
      for (PasswordCondition condition in conditions) {
        _passwordConditions[condition.ConditionName] = condition;
      }
      return _passwordConditions;
    }

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

    test("Test - Password too short", () {
      PasswordValidator passwordValidator = PasswordValidator();
      passwordValidator.SetPassword("123");
      Map<String, PasswordCondition> passwordConditions =
          getCondtionMap(passwordValidator);
      expect(false, passwordConditions["MinLength"]!.IsFulfilled);
      expect(false, passwordValidator.IsValid);
    });

    test("Test - Password has no UpperCase letter", () {
      PasswordValidator passwordValidator = PasswordValidator();
      passwordValidator.SetPassword("123");
      Map<String, PasswordCondition> passwordConditions =
          getCondtionMap(passwordValidator);
      expect(false, passwordConditions["UpperCase"]!.IsFulfilled);
      expect(false, passwordValidator.IsValid);
    });

    test("Test - Password has no LowerCase letter", () {
      PasswordValidator passwordValidator = PasswordValidator();
      passwordValidator.SetPassword("123");
      Map<String, PasswordCondition> passwordConditions =
          getCondtionMap(passwordValidator);
      expect(false, passwordConditions["LowerCase"]!.IsFulfilled);
      expect(false, passwordValidator.IsValid);
    });

    test("Test - Password has no SpecialChar", () {
      PasswordValidator passwordValidator = PasswordValidator();
      passwordValidator.SetPassword("123");
      Map<String, PasswordCondition> passwordConditions =
          getCondtionMap(passwordValidator);
      expect(false, passwordConditions["SpecialChar"]!.IsFulfilled);
      expect(false, passwordValidator.IsValid);
    });

    test("Test - Password has no number", () {
      PasswordValidator passwordValidator = PasswordValidator();
      passwordValidator.SetPassword("abc");
      Map<String, PasswordCondition> passwordConditions =
          getCondtionMap(passwordValidator);
      expect(false, passwordConditions["SpecialChar"]!.IsFulfilled);
      expect(false, passwordValidator.IsValid);
    });

    test("Test - Password is valid", () {
      PasswordValidator passwordValidator = PasswordValidator();
      passwordValidator.SetPassword("abc123EFG.");

      Map<String, PasswordCondition> passwordConditions =
          getCondtionMap(passwordValidator);
      expect(true, passwordConditions["MinLength"]!.IsFulfilled);
      expect(true, passwordConditions["UpperCase"]!.IsFulfilled);
      expect(true, passwordConditions["LowerCase"]!.IsFulfilled);
      expect(true, passwordConditions["Number"]!.IsFulfilled);
      expect(true, passwordConditions["SpecialChar"]!.IsFulfilled);
      expect(true, passwordValidator.IsValid);
    });

    test("Test - is password empty", () {
      PasswordValidator passwordValidator = PasswordValidator();
      expect(true, passwordValidator.IsPasswordEmpty());
      passwordValidator.SetPassword("Ab.4567890");
      expect(false, passwordValidator.IsPasswordEmpty());
    });

    test("Test - get password conditions", () {
      PasswordValidator passwordValidator = PasswordValidator();
      List<PasswordCondition> conditions = passwordValidator.GetConditions();
      expect(5, conditions.length);
    });
  });
}
