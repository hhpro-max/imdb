import 'package:flutter/material.dart';

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "page not found 404 err"
        ),
      ),
    );
  }
}
