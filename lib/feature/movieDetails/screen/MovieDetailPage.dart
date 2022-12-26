import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:imdb/feature/movieDetails/services/MovieDetailService.dart';
import 'package:imdb/feature/movieDetails/widget/Stars.dart';
import 'package:imdb/model/Movie.dart';
import 'package:imdb/provider/GetProvider.dart';
import 'package:get/get.dart';

class MovieDetailPage extends StatelessWidget {
  MovieDetailPage({Key? key}) : super(key: key);
  Movie movie = Get.arguments;
  double avgRating = 0;
  double myRating = 0;
  final TextEditingController _commentTextController = TextEditingController();
  void calculateAvgRating() {
    double totalRating = 0;
    for (int i = 0; i < movie.ratings!.length; i++) {
      totalRating += movie.ratings![i]["rating"];
      if (movie.ratings![i]["userId"] == Get
          .find<GetProvider>()
          .user
          .id) {
        myRating = double.parse(movie.ratings![i]["rating"].toString());
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / movie.ratings!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    calculateAvgRating();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Info"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: ListView(

          children: [
            getSlider(movie),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stars(rating: avgRating),
                const SizedBox(width: 30,),
                Text(avgRating.toString())
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  "Movie Name : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(movie.name),
                const SizedBox(
                  width: 30,
                ),
                const Text("categories : ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                getCategories(movie, context)
              ],
            ),
            const Divider(),
            const Text(
              "Description : ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(movie.description),
            ),
            const Text(
              "Characters : ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            getCharacters(movie),
            const Text(
              "Your Rating on this Movie :",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) =>
                    Icon(
                      Icons.star,
                      color: Colors.yellow[300],
                    ),
                onRatingUpdate: (rating) {
                    MovieDetailService.rateMovie(context: context, movie: movie, rating: rating);
                },
              ),
            ),
            const Divider(),
            const Text(
              "Comments ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: _commentTextController,
              minLines: 5,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "write your comment",
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  MovieDetailService.addComment(context: context, movie: movie, comment: _commentTextController.text);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((
                        states) => Colors.black)
                ),
                child: const Text("submit"),
              ),
            ),
            Divider(indent: MediaQuery.of(context).size.width/4,endIndent: MediaQuery.of(context).size.width/4,color: Colors.black),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              height: 750,
              child: ListView.builder(itemCount: movie.comments!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context,int index){
                    return Container(
                      padding: const EdgeInsets.all(10),
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)
                      ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [const Text("USER : ",style: TextStyle(fontWeight: FontWeight.bold),),Text(movie.comments![index]["userId"])],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(movie.comments![index]["comment"],overflow: TextOverflow.ellipsis,),
                            )
                          ],
                        )
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}

CarouselSlider getSlider(Movie slides) {
  return CarouselSlider.builder(
    itemCount: slides.images.length,
    itemBuilder: (context, int1, int2) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(slides.images[int1].replaceAll('"', '')),
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
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      viewportFraction: 0.8,
    ),
  );
}

getCharacters(Movie movie) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 22,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movie.characters.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.black12),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(movie.characters[index],
                  overflow: TextOverflow.ellipsis),
            );
          }),
    ),
  );
}

getCategories(Movie movie, BuildContext context) {
  return SizedBox(
    height: 20,
    width: MediaQuery
        .of(context)
        .size
        .width / 2,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movie.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(1),
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child:
            Text(movie.categories[index], overflow: TextOverflow.ellipsis),
          );
        }),
  );
}
