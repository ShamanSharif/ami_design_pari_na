import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(90),
          child: Image(image: AssetImage("assets/images/logo.png")),
        ),
      ),
    );
  }
}
