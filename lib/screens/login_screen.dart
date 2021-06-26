import 'package:ami_design_pari_na/widgets/adpn_button.dart';
import 'package:ami_design_pari_na/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LogoWidget(),
            TextField(),
            ADPNButton(
              title: "LOGIN",
            )
          ],
        ),
      ),
    );
  }
}
