

import 'package:flutter/material.dart';
import 'package:imdb/feature/userProfile/services/ProfileServices.dart';
import 'package:imdb/provider/GetProvider.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);
  GetProvider getProvider = Get.find<GetProvider>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("profile"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Icon(Icons.person,size: 80,),
                ),
                Expanded(child: Container()),
                TextButton(onPressed: (){}, child:const Text("edit" , style: TextStyle(color: Colors.green),)),
                TextButton(onPressed: ()async{await ProfileServices.logoutUser();Get.offAllNamed('/');}, child:const Text("log out" , style: TextStyle(color: Colors.red),)),
              ],
            ),
            const Divider(height: 30,color: Colors.black,),
            Text("USER NAME : ${getProvider.user.userName}"),
            const SizedBox(height: 20,),
            Text("PASSWORD : ${getProvider.user.password}"),
            const SizedBox(height: 20,),
            Text("EMAIL : ${getProvider.user.email}"),
            const SizedBox(height: 20,),
            Text("ID : ${getProvider.user.id}"),
            const SizedBox(height: 20,),
            Text("TYPE : ${getProvider.user.type}"),
          ],
        ),
      ),
    );
  }
}
