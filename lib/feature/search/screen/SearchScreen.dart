import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb/feature/search/services/searchServices.dart';
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  String searchVal =Get.arguments;
  Timer? searchOnStoppedTyping;
  var movies = [].obs;
  getMovies(BuildContext context, String searchString)async{
    movies.value = await SearchServices.findMovies(context: context, searchVal: searchString);
  }
  @override
  Widget build(BuildContext context) {
    getMovies(context, searchVal);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Container()),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width/2,
              child: TextFormField(
                initialValue: searchVal,
                onChanged: (value ) {
                  if(value.isNotEmpty){
                    const duration = Duration(milliseconds:1000); // set the duration that you want call search() after that.
                    if (searchOnStoppedTyping != null) {
                      searchOnStoppedTyping!.cancel(); // clear timer
                    }
                    searchOnStoppedTyping = Timer(duration, () => getMovies(context, value));
                  }
                },
                autofocus: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  hintText: "search",
                    prefixIcon: const Icon(Icons.search)),
                ),
            ),
            Expanded(child: Container()),
          ],
        ),
        backgroundColor: Colors.black,
      ),

      body: Obx(
          ()=>movies.value.isEmpty?const Text("no movie found"):GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 300,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
              itemCount: movies.value.length,
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed('/movieInfo',arguments: movies.value[index]);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 270,
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
                              image: NetworkImage(movies.value
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
                                movies.value[index].name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            movies.value[index].description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
      )
    );
  }
}
