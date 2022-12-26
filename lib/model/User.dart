import 'dart:convert';

import 'package:get/get.dart';

class User {
  final String userName;
  final String email;
  final String password;
  final String type;
  var userType = "".obs;
  final List<dynamic> favorites;
  final String id;
  User({required this.userName,required this.email,required this.password,required this.type,required this.favorites ,required this.id}){
    userType.value = type;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json["userName"],
      email: json["email"],
      password: json["password"],
      type: json["type"],
      favorites: List.of(json["favorites"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
      id: json["_id"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userName": this.userName,
      "email": this.email,
      "password": this.password,
      "type": this.type,
      "favorites": jsonEncode(this.favorites),
      "id":id
    };
  }
//

}
