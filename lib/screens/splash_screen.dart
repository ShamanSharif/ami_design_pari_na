import 'package:ami_design_pari_na/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(90),
          child: LogoWidget(),
        ),
      ),
    );
  }
}
