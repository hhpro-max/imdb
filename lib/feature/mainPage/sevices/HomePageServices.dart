import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imdb/config/Config.dart';
import 'package:imdb/constants/ErrHandling.dart';
import 'package:imdb/constants/Utils.dart';
import 'package:imdb/model/Movie.dart';
import 'package:http/http.dart' as http;

class HomePageServices{
  static String url = Config.serverUrl;
  static Future<List<Movie>> getSliderMovies({required BuildContext context}) async{
    List<Movie> sliders = [];
    try{
     http.Response res = await http.get(Uri.parse("$url/movie/sliders"));
     ErrHandling.httpErrHandling(response: res, context: context, onSuccess: (){
       for(int i = 0; i < jsonDecode(res.body).length ;i++){
         sliders.add(Movie.fromJson(jsonDecode(res.body)[i]));
       }
     });
    }catch(e){
      Utils.showSnackBar(context, e.toString());
    }
    return sliders;
  }
  static Future<List<Movie>> getNewMovies({required BuildContext context}) async{
    List<Movie> sliders = [];
    try{
      http.Response res = await http.get(Uri.parse("$url/movie/newMovies"));
      ErrHandling.httpErrHandling(response: res, context: context, onSuccess: (){
        for(int i = 0; i < jsonDecode(res.body).length ;i++){
          sliders.add(Movie.fromJson(jsonDecode(res.body)[i]));
        }
      });
    }catch(e){
      Utils.showSnackBar(context, e.toString());
    }
    return sliders;
  }
  static Future<List<Movie>> getTopRatedMovies({required BuildContext context}) async{
    List<Movie> sliders = [];
    try{
      http.Response res = await http.get(Uri.parse("$url/movie/topRatedMovies"));
      ErrHandling.httpErrHandling(response: res, context: context, onSuccess: (){
        for(int i = 0; i < jsonDecode(res.body).length ;i++){
          sliders.add(Movie.fromJson(jsonDecode(res.body)[i]));
        }
      });
    }catch(e){
      Utils.showSnackBar(context, e.toString());
    }
    return sliders;
  }
}

