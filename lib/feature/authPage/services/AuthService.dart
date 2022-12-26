import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imdb/config/Config.dart';
import 'package:imdb/constants/ErrHandling.dart';
import 'package:imdb/constants/Utils.dart';
import 'package:imdb/model/User.dart';
import 'package:imdb/provider/GetProvider.dart';
import 'package:get/get.dart';

class AuthService {
  static GetProvider getProvider = Get.find<GetProvider>();

  static signUpUser(
      {required BuildContext context,
      required String email,
      required String userName,
      required String password}) async {
    try {
      String url = Config.serverUrl;
      User user = User(
          userName: userName,
          email: email,
          password: password,
          type: "",
          favorites: [],
          id: "");
      http.Response response = await http.post(Uri.parse("$url/auth/register"),
          body: jsonEncode(user.toJson()), headers: getProvider.userHttpHeaders);
      ErrHandling.httpErrHandling(
          response: response,
          context: context,
          onSuccess: () {
            Utils.showSnackBar(
                context, "account created check your email and login");
          });
    } catch (e) {
      print("ERR -> $e");
    }
  }

  static signInUser(
      {required BuildContext context,required String userName, required String password}) async {
    try {
      String url = Config.serverUrl;
      http.Response response = await http.post(Uri.parse("$url/auth/login"),
          body: jsonEncode({"userName": userName, "password": password}),
          headers: getProvider.userHttpHeaders);
      ErrHandling.httpErrHandling(response: response, context: context, onSuccess: () async{
        getProvider.setUser(jsonDecode(response.body));
        getProvider.userHttpHeaders['Cookie'] = response.headers['set-cookie'] ?? "";
        Get.toNamed("/");
      });
    } catch (e) {
      print("ERR -> $e");
    }

  }
}
