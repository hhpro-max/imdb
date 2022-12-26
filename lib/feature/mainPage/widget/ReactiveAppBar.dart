import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imdb/config/Config.dart';
import 'package:imdb/feature/userProfile/screen/UserProfilePage.dart';
import 'package:imdb/provider/GetProvider.dart';
import 'package:get/get.dart';

class ReactiveAppBar {
  
  static GetProvider getProvider = Get.find<GetProvider>();
  static Timer? searchOnStoppedTyping;

  static AppBar getAppBar(BuildContext context) {
    return firstAppBar;
  }

  static var firstAppBar = AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(color: Colors.black),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/logo.png",
              fit: BoxFit.cover,
              height: 50,
              width: 50,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Row(
            children: const [Icon(Icons.drag_handle_outlined), Text("MENU")],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 10,
          child: SizedBox(
            height: 40,
            child: TextFormField(
              
              onChanged: (value ) {
                if(value.isNotEmpty){
                  const duration = Duration(milliseconds:1000); // set the duration that you want call search() after that.
                  if (searchOnStoppedTyping != null) {
                    searchOnStoppedTyping!.cancel(); // clear timer
                  }
                  searchOnStoppedTyping = Timer(duration, () => Get.toNamed('/search',arguments: value));
                }
              },
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  hintText: "search",
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              if (getProvider.user.userName.isEmpty) {
                Get.toNamed("/login");
              } else {
                Get.toNamed('/profile');
              }
            },
            icon: const Icon(Icons.person)),
        Obx(() => getProvider.user.userType.value == Config.userAdminType
            ? IconButton(
                onPressed: () {
                  Get.toNamed("/addMovie");
                },
                icon: const Icon(Icons.add))
            : Container())
      ],
    ),
  );

// static var secondAppBar = AppBar(
//   flexibleSpace: Container(
//     decoration: const BoxDecoration(color: Colors.black),
//   ),
//   title: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Container(
//
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(50),
//           child: Image.asset(
//             "assets/logo.png",
//             fit: BoxFit.cover,
//             height: 50,
//             width: 50,
//           ),
//         ),
//       ),
//       InkWell(
//         onTap: (){},
//         child: Row(
//           children: const[
//             Icon(Icons.drag_handle_outlined),
//             Text("MENU")
//           ],
//         ),
//       ),
//       const SizedBox(width: 10,),
//       Expanded(
//         flex: 10,
//         child: SizedBox(
//           height: 40,
//           child: TextFormField(
//             decoration: const InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(7)),
//                 ),
//                 hintText: "search",
//                 prefixIcon: Icon(Icons.search)),
//           ),
//         ),
//       ),
//       IconButton(onPressed: (){
//         if(getProvider.user.userName.isEmpty){
//           Get.toNamed("/login");
//         }else{
//           Get.toNamed('/profile');
//         }
//       }, icon: const Icon(Icons.person)),
//       IconButton(onPressed: (){}, icon: const Icon(Icons.bookmark)),
//       IconButton(onPressed: (){}, icon: const Icon(Icons.stacked_line_chart)),
//       Obx(() => getProvider.user.userType.value == Config.userAdminType?IconButton(onPressed: (){Get.toNamed("/addMovie");}, icon:const  Icon(Icons.add)):Container())
//     ],
//   ),
// );

}
