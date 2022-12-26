

import 'package:imdb/model/User.dart';

class GetProvider{
    Map<String,String> userHttpHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
    };
    User _user = User(userName: "", email: "", password: "", type: "", favorites: [], id: "");
    User get user => _user;
    void setUser(Map<String,dynamic> user){
        _user = User.fromJson(user);
    }
    void reSetUser(){
        _user = User(userName: "", email: "", password: "", type: "", favorites: [], id: "");
    }
}