import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb/feature/mainPage/sevices/HomePageServices.dart';
import 'package:imdb/feature/mainPage/widget/ReactiveAppBar.dart';
import 'package:imdb/model/Movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:imdb/provider/GetProvider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var moviesSlider = (null as List<Movie>?).obs;
  var newMovies = (null as List<Movie>?).obs;
  var topRatedMovies = (null as List<Movie>?).obs;
  fetchMoviesSlider(BuildContext context) async {
    moviesSlider.value =
        await HomePageServices.getSliderMovies(context: context);
  }

  fetchNewMovies(BuildContext context) async {
    newMovies.value = await HomePageServices.getNewMovies(context: context);
  }
  fetchTopRatedMovies(BuildContext context) async {
    topRatedMovies.value = await HomePageServices.getTopRatedMovies(context: context);
  }

  @override
  Widget build(BuildContext context) {
    fetchMoviesSlider(context);
    fetchNewMovies(context);
    fetchTopRatedMovies(context);
    return Scaffold(
        appBar: ReactiveAppBar.getAppBar(context),
        body: ListView(
          children: [
            Obx(() => moviesSlider.value == null
                ? const Center(child: CircularProgressIndicator())
                : moviesSlider.value!.isEmpty
                    ? const Center(child: Text("NO DATA"))
                    : getSlider(moviesSlider.value!)),
            const SizedBox(
              height: 30,
            ),
            Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("New Movies"),
                    Text(
                      "show more",
                      style: TextStyle(color: Colors.cyan),
                    )
                  ],
                )),

            Obx(() => newMovies.value == null
                ? const Center(child: CircularProgressIndicator())
                : newMovies.value!.isEmpty
                    ? const Center(child: Text("NO DATA"))
                    : getMovieListView(newMovies.value!)),
            Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Top Rated Movies"),
                    Text(
                      "show more",
                      style: TextStyle(color: Colors.cyan),
                    )
                  ],
                )),

            Obx(() => newMovies.value == null
                ? const Center(child: CircularProgressIndicator())
                : newMovies.value!.isEmpty
                ? const Center(child: Text("NO DATA"))
                : getMovieListView(topRatedMovies.value!)),
            const Divider(height: 50,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("telephone : 09xxx12xx",style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("address : home sit front the computer",style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Text("communication ways :",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  Icon(Icons.telegram),
                  Icon(Icons.terminal_sharp),
                  Icon(Icons.webhook)
                ],
              ),
            )
          ],
        )
    );
  }
}

CarouselSlider getSlider(List<Movie> slides) {
  return CarouselSlider.builder(
    itemCount: slides.length,
    itemBuilder: (context, int1, int2) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(slides[int1].images[0].replaceAll('"', '')),
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

Widget getMovieListView(List<Movie> newMovies){
  double calculateAvgRating(Movie movie) {
    double avgRating = 0;
    double totalRating = 0;
    for (int i = 0; i < movie.ratings!.length; i++) {
      totalRating += movie.ratings![i]["rating"];
    }

    if (totalRating != 0) {
      avgRating = totalRating / movie.ratings!.length;
    }
    return avgRating;
  }
  return SizedBox(
    height: 300,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: newMovies.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            Get.toNamed('/movieInfo',arguments: newMovies[index]);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            height: 300,
            width: 170,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: const BorderRadius.all(
                    Radius.circular(10.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    image: DecorationImage(
                      image: NetworkImage(newMovies
                          [index].images[0]
                          .replaceAll('"', '')
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 140,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                        newMovies[index].name,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    newMovies[index].description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.star,color: Colors.yellow,size: 20,),
                      Text(calculateAvgRating(newMovies[index]).toString())
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}
