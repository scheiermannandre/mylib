// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mylib/GenericClasses/HTTPClientClasses/Exceptions/HTTPPostException.dart';

class HTTPClient {
  static http.Client client = http.Client();
  static Future<String> Post(Uri uri, String requestBody) async {
    try {
      Response jsonResponse = await client
          .post(uri,
              body: requestBody,
              headers: {
                "accept": "application/json",
                "content-type": "application/json"
              },
              encoding: Encoding.getByName('utf-8'))
          .timeout(const Duration(seconds: 30));

      return jsonResponse.body;
      // String serverResponse = jsonResponse.body;
      // JsonDecoder decoder = const JsonDecoder();
      // return decoder.convert(serverResponse);
    } on Exception catch (ex) {
      String msg = "";
      if (ex is SocketException) {
        msg = 'No Internet connection 😑';
      } else if (ex is HttpException) {
        msg = "Couldn't find the post 😱";
      } else if (ex is SocketException) {
        msg = "Bad response format 👎";
      } else {
        msg = "Unexpected Error occured!";
      }
      throw HTTPPostException(msg, ex);
    }
  }

  static Future<String> get(Uri uri) async {
    try {
      Response jsonResponse = await client.get(uri, headers: {
        "accept": "application/json",
        "content-type": "application/json"
      });
      return jsonResponse.body;
    } on Exception catch (ex) {
      String msg = "";
      if (ex is SocketException) {
        msg = 'No Internet connection 😑';
      } else if (ex is HttpException) {
        msg = "Couldn't find the post 😱";
      } else if (ex is SocketException) {
        msg = "Bad response format 👎";
      } else {
        msg = "Unexpected Error occured!";
      }
      throw HTTPPostException(msg, ex);
    }
  }

  static Future<String> put(Uri uri, String requestBody) async {
    try {
      Response jsonResponse = await client
          .put(uri,
              body: requestBody,
              headers: {
                "accept": "application/json",
                "content-type": "application/json"
              },
              encoding: Encoding.getByName('utf-8'))
          .timeout(const Duration(seconds: 30));

      return jsonResponse.body;
      // String serverResponse = jsonResponse.body;
      // JsonDecoder decoder = const JsonDecoder();
      // return decoder.convert(serverResponse);
    } on Exception catch (ex) {
      String msg = "";
      if (ex is SocketException) {
        msg = 'No Internet connection 😑';
      } else if (ex is HttpException) {
        msg = "Couldn't find the post 😱";
      } else if (ex is SocketException) {
        msg = "Bad response format 👎";
      } else {
        msg = "Unexpected Error occured!";
      }
      throw HTTPPostException(msg, ex);
    }
  }
}
