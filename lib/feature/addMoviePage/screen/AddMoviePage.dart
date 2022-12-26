import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb/constants/Utils.dart';
import 'package:imdb/feature/addMoviePage/services/AddMovieServices.dart';
import 'package:imdb/model/Movie.dart';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({Key? key}) : super(key: key);

  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  List<File> images = [];
  List<String> categories = [];

  List<String> characters = [];
  String categoryValue = "action";
  List<String> defaultCategories = [
    "action",
    "comedy",
    "drama",
    "dreadful",
    "historical"
  ];

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _charactersController = TextEditingController();
  void selectImages() async {
    var res = await Utils.pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MOVIE"),
        elevation: 2,
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              images.isEmpty
                  ? GestureDetector(
                onTap: selectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Select Movie Images',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : getSlider(images),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                  ),
                  labelText: "Movie Name",
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                  ),
                  labelText: "description",
                ),
                minLines: 5,
                maxLines: 100,
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 20,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.black12),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(characters[index],
                          overflow: TextOverflow.ellipsis),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextFormField(
                      controller: _charactersController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                          ),
                          labelText: "characters",
                          hintText: "enter name and then press add button"),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if(_charactersController.text.isNotEmpty){
                            characters.add(_charactersController.text);
                            _charactersController.text = "";
                            print(characters);
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
                      ),
                      child: const Text("ADD CHAR"))
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: DropdownButton(
                        value: categoryValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onChanged: (String? newVal){
                          setState(() {
                            categoryValue = newVal!;
                          });
                        },
                        items: defaultCategories.map((String item) => DropdownMenuItem(value: item,child: Text(item),)).toList(),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(onPressed: (){setState(() {
                    categories.add(categoryValue);
                    categories = categories.toSet().toList();
                  });},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black)
                  ), child:const Text('ADD CATEGORY'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.black12),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(categories[index],
                          overflow: TextOverflow.ellipsis),
                    );
                  },
                ),
              ),
              Container(

                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () async{
                       await AddMovieServices.addMovie(context: context, name: _nameController.text, description: _descriptionController.text, characters: characters, categories: categories, images: images);
                    },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 50),
                    backgroundColor: Colors.black
                  ),
                    child: const Text("submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

CarouselSlider getSlider(List<File> slides) {
  return CarouselSlider.builder(
    itemCount: slides.length,
    itemBuilder: (context, int1, int2) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: FileImage(slides[int1]),
            fit: BoxFit.cover,
          ),
        ),
      );
    },
    options: CarouselOptions(
      height: 380.0,
      enlargeCenterPage: true,
      autoPlay: true,
      aspectRatio: 16 / 9,
      autoPlayCurve: Curves.fastOutSlowIn,
      enableInfiniteScroll: true,
      autoPlayAnimationDuration: const Duration(milliseconds: 2000),
      viewportFraction: 0.8,
    ),
  );
}
