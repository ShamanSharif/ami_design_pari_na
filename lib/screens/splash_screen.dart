import 'package:ami_design_pari_na/screens/khoj_screen.dart';
import 'package:ami_design_pari_na/utils/secure_storage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_page';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorage _secureStorage = SecureStorage();
  String _email;

  @override
  void initState() {
    _secureStorage.readSecureData('email').then((value) {
      _email = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        nextScreen: _email != null ? KhojScreen() : LoginScreen(),
        splash: "assets/images/logo.png",
        curve: Curves.fastOutSlowIn,
        duration: 500,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        splashIconSize: 300,
      ),
    );
  }
}
