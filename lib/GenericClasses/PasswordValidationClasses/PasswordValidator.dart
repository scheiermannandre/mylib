// ignore_for_file: file_names, non_constant_identifier_names

import 'package:mylib/GenericClasses/PasswordValidationClasses/Exceptions/InsecurePasswordLengthException.dart';

class PasswordValidator {
  PasswordValidator({int passwordLength = DefaultPasswordLength}) {
    if (passwordLength < DefaultPasswordLength) {
      throw InsecurePasswordLengthException(DefaultPasswordLength);
    }
    _passwordLength = passwordLength;
  }

  late int _passwordLength;
  static const int DefaultPasswordLength = 10;
  String _password = "";

  bool _hasUpperCase = false;
  bool _hasLowerCase = false;
  bool _hasNumber = false;
  bool _hasSpecialCharacter = false;
  bool _hasMinLength = false;
  bool _isValid = false;

  bool get HasUppercase {
    return _hasUpperCase;
  }

  bool get HasLowerCase {
    return _hasLowerCase;
  }

  bool get HasNumber {
    return _hasNumber;
  }

  bool get HasSpecialCharacter {
    return _hasSpecialCharacter;
  }

  bool get IsValid {
    return _isValid;
  }

  int get PasswordLength {
    return _passwordLength;
  }

  List<String> GetConditions() {
    List<String> conditions = <String>[];
    conditions.add(_passwordLength.toString() + " characters");
    conditions.add("one uppercase letter");
    conditions.add("one lowercase letter");
    conditions.add("one number");
    conditions.add("one special character");
    return conditions;
  }

  void SetPassword(String password) {
    _password = password;
    _hasMinLength = _password.length > _passwordLength;
    _hasUpperCase = _password.contains(RegExp(r'[A-Z]'));
    _hasLowerCase = _password.contains(RegExp(r'[a-z]'));
    _hasNumber = _password.contains(RegExp(r'[0-9]'));
    _hasSpecialCharacter =
        _password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    _isValid = _hasMinLength &&
        _hasUpperCase &&
        _hasLowerCase &&
        _hasNumber &&
        _hasSpecialCharacter;
  }
}
