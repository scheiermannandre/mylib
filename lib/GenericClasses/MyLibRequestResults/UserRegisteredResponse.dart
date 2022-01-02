// ignore_for_file: file_names

import 'package:mylib/GenericClasses/UserClasses/User.dart';

class UserRegisteredResponse {
  late bool UserRegistered;

  UserRegisteredResponse.fromJSON(Map<String, dynamic> json) {
    UserRegistered = json["userRegistered"];
  }
}
