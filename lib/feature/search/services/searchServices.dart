import 'dart:convert';

import 'package:imdb/config/Config.dart';
import 'package:imdb/constants/ErrHandling.dart';
import 'package:imdb/model/Movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:imdb/provider/GetProvider.dart';
class SearchServices{
  static Future<List<Movie>> findMovies({
    required BuildContext context,
    required String searchVal,
}) async{
    List<Movie> movies = [];
    try{
      http.Response response = await http.get(Uri.parse("${Config.serverUrl}/movie/search/$searchVal"),
      headers: Get.find<GetProvider>().userHttpHeaders
      );
      ErrHandling.httpErrHandling(response: response, context: context, onSuccess: (){
        for (int i = 0; i < jsonDecode(response.body).length; i++){
          movies.add(Movie.fromJson(jsonDecode(response.body)[i]));
        }
      });
    }catch(e){
      print(e);
    }

    return movies;
  }
}