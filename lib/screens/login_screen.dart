import 'package:ami_design_pari_na/widgets/adpn_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Image(
            image: AssetImage("assets/images/logo.png"),
          ),
          TextField(),
          TextField(),
          ADPNButton(
            title: "LOGIN",
          )
        ],
      )),
    );
  }
}
