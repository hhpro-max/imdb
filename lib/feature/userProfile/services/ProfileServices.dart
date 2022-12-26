import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imdb/config/Config.dart';
import 'package:imdb/provider/GetProvider.dart';
import 'package:get/get.dart';
class ProfileServices{
  static final GetProvider _getProvider = Get.find<GetProvider>();
  static logoutUser()async{
    String uri = Config.serverUrl;
    http.Response response =  await http.post(Uri.parse('$uri/auth/logout'));
    _getProvider.reSetUser();
  }
}