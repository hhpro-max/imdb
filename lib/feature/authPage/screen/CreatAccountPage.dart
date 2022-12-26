import 'package:flutter/material.dart';
import 'package:imdb/feature/authPage/services/AuthService.dart';
import 'package:get/get.dart';

class CreatAccountPage extends StatelessWidget {
  CreatAccountPage({Key? key}) : super(key: key);
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("REGISTER YOUR ACCOUNT"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _userName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: "username"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: "email"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: "password"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Get.off('/login');
                      },
                      child: const Text(
                        "or login to your account",
                        style: TextStyle(color: Colors.cyan),
                      )),
                  Expanded(child: Container()),
                  ElevatedButton(
                    onPressed: () {
                      AuthService.signUpUser(
                          context: context,
                          email: _email.text,
                          userName: _userName.text,
                          password: _password.text);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black)),
                    child: const Text("REGISTER"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
