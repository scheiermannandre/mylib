// ignore_for_file: file_names, unused_field

class PasswordCondition {
  PasswordCondition(this.ConditionName, this.ConditionDescription);
  bool IsFulfilled = false;
  final String ConditionDescription;
  final String ConditionName;
}
