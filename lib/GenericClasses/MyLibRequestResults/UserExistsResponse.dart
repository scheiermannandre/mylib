// ignore_for_file: file_names

import 'package:mylib/GenericClasses/UserClasses/User.dart';

class UserExistsResponse {
  bool UserExists = false;

  UserExistsResponse.fromJSON(Map<String, dynamic> json) {
    UserExists = json["userExists"];
  }
}
