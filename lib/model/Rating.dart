class Rating {
  final String userId;
  final double rating;

  Rating({required this.userId, required this.rating});

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "rating": rating,
    };
  }

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userId: json["userId"],
      rating: double.parse(json["rating"]),
    );
  }

}
