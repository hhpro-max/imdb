import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb/feature/404/screen/404Page.dart';
import 'package:imdb/feature/addMoviePage/screen/AddMoviePage.dart';
import 'package:imdb/feature/authPage/screen/CreatAccountPage.dart';
import 'package:imdb/feature/authPage/screen/LoginPage.dart';
import 'package:imdb/feature/mainPage/screen/HomeScreen.dart';
import 'package:imdb/feature/movieDetails/screen/MovieDetailPage.dart';
import 'package:imdb/feature/search/screen/SearchScreen.dart';
import 'package:imdb/feature/userProfile/screen/UserProfilePage.dart';
import 'package:imdb/provider/GetProvider.dart';

void main() {
  //initial provider
  GetProvider getProvider = Get.put<GetProvider>(GetProvider());
  runApp(GetMaterialApp(
    unknownRoute: GetPage(name:"/undefined",page: ()=>const UndefinedPage()),
    initialRoute: "/",
    getPages: [
      GetPage(name: "/", page: () => HomeScreen()),
      GetPage(name: "/login", page:()=> LoginPage()),
      GetPage(name: '/register', page: ()=>CreatAccountPage()),
      GetPage(name: '/profile', page: ()=>UserProfilePage()),
      GetPage(name: "/addMovie", page: ()=>const AddMoviePage()),
      GetPage(name: "/movieInfo", page: ()=>MovieDetailPage()),
      GetPage(name: "/search", page: ()=>SearchScreen())
    ],
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
