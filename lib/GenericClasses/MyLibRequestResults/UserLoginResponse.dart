// ignore: file_names
// ignore_for_file: non_constant_identifier_names, file_names, unused_import

import 'package:mylib/GenericClasses/UserClasses/User.dart';

class UserLoginResponse {
  int? UserId;
  late String Email = "";
  late bool UserExists = false;
  late bool LoginApproved = false;

  UserLoginResponse() {}
  UserLoginResponse.fromJson(Map<String, dynamic> json)
      : UserId = json['userId'],
        Email = json['email'],
        UserExists = json['userExists'],
        LoginApproved = json['loginApproved'];
}
