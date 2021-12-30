// ignore_for_file: file_names, unused_field

class PasswordCondition {
  PasswordCondition(this._conditionText);
  bool IsFulfilled = false;
  final String _conditionText;
  String get Condition {
    return _conditionText;
  }
}
