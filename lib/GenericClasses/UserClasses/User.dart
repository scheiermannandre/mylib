// ignore_for_file: file_names

import 'dart:convert';

class User {
  User(this.Email, this.PasswordHash, {this.UserId = 0});
  late int UserId;
  late String Email;
  late String PasswordHash;

  Map<String, dynamic> toJson() => {
        'UserId': UserId,
        'Email': Email,
        'PasswordHash': PasswordHash,
      };

  User.fromJson(Map<String, dynamic> json)
      : UserId = json['UserId'],
        Email = json['Email'],
        PasswordHash = json['PasswordHash'];

  String toJsonStr() {
    return jsonEncode(toJson());
  }
}
