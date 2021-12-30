// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names

import 'package:mylib/GenericClasses/PasswordValidationClasses/Exceptions/InsecurePasswordLengthException.dart';
import 'package:mylib/GenericClasses/PasswordValidationClasses/PasswordCondition.dart';

///The PasswordValidator checks a password for some conditions.
///When cunstructed a length greater 10 needs to be set!
///The validator checks for length, one uppercase, one lowercase, one number and one special char.
class PasswordValidator {
  static const int DefaultPasswordLength = 10;

  PasswordValidator({int passwordLength = DefaultPasswordLength}) {
    if (passwordLength < DefaultPasswordLength) {
      throw InsecurePasswordLengthException(DefaultPasswordLength);
    }
    _passwordLength = passwordLength;

    _passwordConditions["MinLength"] =
        PasswordCondition(_passwordLength.toString() + " characters");
    _passwordConditions["UpperCase"] =
        PasswordCondition("one uppercase letter");
    _passwordConditions["LowerCase"] =
        PasswordCondition("one lowercase letter");

    _passwordConditions["Number"] = PasswordCondition("one number");
    _passwordConditions["SpecialChar"] =
        PasswordCondition("one special character");
  }

  late int _passwordLength;
  String _password = "";
  final Map<String, PasswordCondition> _passwordConditions = Map();

  bool _isValid = false;

  bool get HasUpperCase {
    return _passwordConditions["UpperCase"]!.IsFulfilled;
  }

  bool get HasLowerCase {
    return _passwordConditions["LowerCase"]!.IsFulfilled;
  }

  bool get HasNumber {
    return _passwordConditions["Number"]!.IsFulfilled;
  }

  bool get HasSpecialCharacter {
    return _passwordConditions["SpecialChar"]!.IsFulfilled;
  }

  bool get HasMinLength {
    return _passwordConditions["MinLength"]!.IsFulfilled;
  }

  bool get IsValid {
    return _isValid;
  }

  int get PasswordLength {
    return _passwordLength;
  }

  List<PasswordCondition> GetConditions() {
    List<PasswordCondition> conditions = [];
    _passwordConditions.forEach((key, value) {
      conditions.add(value);
    });
    return conditions;
  }

  void SetPassword(String password) {
    _password = password;
    _verificatePassword();
  }

  void _verificatePassword() {
    _verificateLength();
    _verificateUpperCase();
    _verificateLowerCase();
    _verificateNumber();
    _verificateSpecialChar();

    _isValid = HasMinLength &&
        HasUpperCase &&
        HasLowerCase &&
        HasNumber &&
        HasSpecialCharacter;
  }

  void _verificateLength() {
    _passwordConditions["MinLength"]!.IsFulfilled =
        _password.length > _passwordLength;
  }

  void _verificateUpperCase() {
    _passwordConditions["UpperCase"]!.IsFulfilled =
        _password.contains(RegExp(r'[A-Z]'));
  }

  void _verificateLowerCase() {
    _passwordConditions["LowerCase"]!.IsFulfilled =
        _password.contains(RegExp(r'[a-z]'));
  }

  void _verificateNumber() {
    _passwordConditions["Number"]!.IsFulfilled =
        _password.contains(RegExp(r'[0-9]'));
  }

  void _verificateSpecialChar() {
    _passwordConditions["SpecialChar"]!.IsFulfilled =
        _password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }
}
