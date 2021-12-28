// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mylib/GenericClasses/GlobalUserProperties.dart';

class HttpCall {
  static String ipAddressDB = "http://192.168.0.6:5000";
  // static Future<List<Book>> getBooksGoogle(String search) async {
  //   List<Book> books = [];
  //   http.Response jsonResponse = await http.get(
  //       'https://www.googleapis.com/books/v1/volumes?q=' +
  //           search +
  //           '&maxResults=20');
  //   Map<String, dynamic> jsonBody = json.decode(jsonResponse.body);
  //   List<dynamic> list = jsonBody['items'] as List;
  //   list.forEach((element) {
  //     books.add(Book.fromJsonAPI(element['volumeInfo']));
  //   });

  //   return books;
  // }

  static Future<int> postLoginData(String email, String password) async {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    try {
      Map<String, dynamic> requestBody = {};
      requestBody["email"] = email;
      requestBody["password"] = password;
      Map<String, dynamic> loginDataMap = {};
      loginDataMap["user"] = requestBody;
      String loginData = encoder.convert(loginDataMap);

      final jsonResponse = await http.post(
          Uri.https(
            ipAddressDB,
            "/login",
          ),
          body: loginData,
          headers: {
            "accept": "application/json",
            "content-type": "application/json"
          });
      String serverResponse = jsonResponse.body;
      JsonDecoder decoder = const JsonDecoder();
      Map<String, dynamic> responseJson = decoder.convert(serverResponse);
      return responseJson["user"];
    } on SocketException {
      print('No Internet connection 😑');
      return -2;
    } on HttpException {
      print("Couldn't find the post 😱");
      return -2;
    } on FormatException {
      print("Bad response format 👎");
      return -2;
    }
  }

  static Future<int> postRegistrationData(String email, String password) async {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    try {
      Map<String, dynamic> requestBody = {};
      requestBody["email"] = email;
      requestBody["password"] = password;
      Map<String, dynamic> registrationDataMap = {};
      registrationDataMap["user"] = requestBody;
      String registrationData = encoder.convert(registrationDataMap);
      final jsonResponse = await http.post(
          Uri.https(
            ipAddressDB,
            "/register",
          ),
          body: registrationData,
          headers: {
            "accept": "application/json",
            "content-type": "application/json"
          });
      String serverResponse = jsonResponse.body;
      JsonDecoder decoder = JsonDecoder();
      Map<String, dynamic> responseJson = decoder.convert(serverResponse);
      return responseJson["user"];
    } on SocketException {
      print('No Internet connection 😑');
      return -2;
    } on HttpException {
      print("Couldn't find the post 😱");
      return -2;
    } on FormatException {
      print("Bad response format 👎");
      return -2;
    }
  }

  static Future getBookDB(int index) async {
    try {
      final jsonResponse = await http.get(
          Uri.https(
            ipAddressDB,
            "/books/" +
                GlobalUserProperties.UserId.toString() +
                "/" +
                index.toString(),
          ),
          headers: {
            "accept": "application/json",
            "content-type": "application/json"
          });
      return jsonResponse;
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
  }

  static Future getLibraryCountDB() async {
    try {
      final jsonResponse = await http.get(
          Uri.https(
            ipAddressDB,
            "/libcount/" + GlobalUserProperties.UserId.toString(),
          ),
          headers: {
            "accept": "application/json",
            "content-type": "application/json"
          });
      return jsonResponse;
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱😱😱😱😱");
    } on FormatException {
      print("Bad response format 👎");
    }
  }
}
