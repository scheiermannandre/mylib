// ignore_for_file: file_names

import 'dart:convert';

class User {
  User(this.Email, this.PasswordHash, {this.Id = 0});
  late int Id;
  late String Email;
  late String PasswordHash;

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Email': Email,
        'PasswordHash': PasswordHash,
      };

  User.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        Email = json['Email'],
        PasswordHash = json['PasswordHash'];

  String toJsonStr() {
    return jsonEncode(toJson());
  }
}
