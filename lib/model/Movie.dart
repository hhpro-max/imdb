import 'dart:convert';

import 'Rating.dart';

class Movie {
  final String name;
  final List<dynamic> images;
  final List<dynamic> categories;
  final List<dynamic> characters;
  final String description;
  final List<dynamic>? ratings;
  final String? id;
  List<dynamic>? comments;

  Movie(
      {required this.name,
      required this.images,
      required this.categories,
      required this.characters,
      required this.description,
      this.id,
      this.ratings,
      this.comments
      });


  factory Movie.fromJson(Map<String, dynamic> json) {

    return Movie(
      name: json["name"]!,
      images: List.of(json["image"]![0].replaceAll("[", "").replaceAll("]", "").split(",")).map((i) => i).toList(),
      categories:
          List.of(json["category"]![0].replaceAll("[", "").replaceAll("]", "").split(",")).map((i) => i).toList(),
      characters:
          List.of(json["characters"]![0].replaceAll("[", "").replaceAll("]", "").split(",")).map((i) => i).toList(),
      description: json["description"]!,
      ratings: List.of(json["rating"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
      id: json["_id"],
      comments: List.of(json["comments"]).map((i) => i /* can't generate it properly yet */).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "images": jsonEncode(images),
      "categories": jsonEncode(categories),
      "characters": jsonEncode(characters),
      "description": description,
      "ratings": jsonEncode(ratings),
      "id": id,
      "comments":jsonEncode(comments)
    };
  }
//


}
