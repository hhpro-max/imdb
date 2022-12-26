import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get/get.dart';
import 'package:imdb/config/Config.dart';
import 'package:imdb/constants/ErrHandling.dart';
import 'package:imdb/constants/Utils.dart';
import 'package:imdb/model/Movie.dart';
import 'package:imdb/provider/GetProvider.dart';
class AddMovieServices{
  static addMovie({
    required BuildContext context,
    required String name,
    required String description,
    required List<String> characters,
    required List<String> categories,
    required List<File> images
}) async {
    try{
      final cloudinary = CloudinaryPublic("dd80e37ys", "lrmkg9da");
      List<String> imageUrls=[];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      Movie movie= Movie(name: name, images: imageUrls, categories: categories, characters: characters, description: description);
      http.Response response= await http.post(Uri.parse('${Config.serverUrl}/movie/addMovie'),
          headers: Get.find<GetProvider>().userHttpHeaders,
          body: jsonEncode(movie.toJson())
      );
      ErrHandling.httpErrHandling(response: response, context: context, onSuccess: (){
        Utils.showSnackBar(context, 'Movie Added Successfully!');
        Get.offAllNamed('/');
      });
    }catch(e){
      print(e);
    }
  }
}