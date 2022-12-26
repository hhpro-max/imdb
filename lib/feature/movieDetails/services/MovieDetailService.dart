import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imdb/config/Config.dart';
import 'package:imdb/constants/ErrHandling.dart';
import 'package:imdb/feature/mainPage/screen/HomeScreen.dart';
import 'package:imdb/model/Movie.dart';
import 'package:imdb/provider/GetProvider.dart';
import 'package:get/get.dart';
class MovieDetailService {
  static void rateMovie({required BuildContext context,required Movie movie,required double rating}) async{
    final GetProvider getProvider = Get.find<GetProvider>();
    try{
      http.Response response = await http.post(Uri.parse("${Config.serverUrl}/movie/rateMovie"),
      headers: getProvider.userHttpHeaders,
        body: jsonEncode({
          'id':movie.id,
          'rating':rating
        })
      );
      ErrHandling.httpErrHandling(response: response, context: context, onSuccess: (){
       Movie testMovie = Movie.fromJson(jsonDecode(response.body));
        for(int i = 0;i < HomeScreen.newMovies.value!.length;i++){
          if(HomeScreen.newMovies.value![i].id==testMovie.id){
            HomeScreen.newMovies.value![i] = testMovie;
            break;
          }
        }
       for(int i = 0;i < HomeScreen.topRatedMovies.value!.length;i++){
         if(HomeScreen.topRatedMovies.value![i].id==testMovie.id){
           HomeScreen.topRatedMovies.value![i] = testMovie;
           break;
         }
       }
      });
    }catch(e){
      print(e);
    }
  }
  static void addComment({required BuildContext context,required Movie movie,required String comment}) async{
    final GetProvider getProvider = Get.find<GetProvider>();
    http.Response response = await http.post(Uri.parse("${Config.serverUrl}/movie/addComment"),
    headers: getProvider.userHttpHeaders,
      body: jsonEncode({
        "userId": getProvider.user.id,
        "movieId": movie.id,
        "comment":comment
      })
    );
    ErrHandling.httpErrHandling(response: response, context: context, onSuccess: (){
      print(jsonDecode(response.body));
    });
  }
}
