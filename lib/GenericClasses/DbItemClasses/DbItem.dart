// ignore_for_file: file_names

import 'package:mylib/GenericClasses/BookClasses/Exceptions/InvalidBookParameterException.dart';
import 'package:mylib/GenericClasses/StaticMethodsClass.dart';

abstract class DbItem {
  late int itemId;
  late int userId;

  DbItem(this.itemId, this.userId);
  DbItem.fromJson(Map<String, dynamic> json) {
    int? tmpItemId = json['itemId'];
    int? tmpUserId = json['userId'];
    itemId = 0;
    // CheckParameter(tmpItemId);
    userId = CheckParameter(tmpUserId!.toInt());
  }

  Map<String, dynamic> toJson();

  dynamic CheckParameter(dynamic parameter) {
    if (StaticMethods.IsNull(parameter)) {
      throw InvalidBookParameterException(
          "Fetched book-Json from DB doesn't contain a Id", "Id", "NULL");
    }

    return parameter;
  }
}
