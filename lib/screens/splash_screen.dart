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
  // setting a Secure Storage object for storing and retrieving secure storage data
  final SecureStorage _secureStorage = SecureStorage();
  String _email;

  @override
  void initState() {
    // getting data from secure storage at the initial level of this application
    _secureStorage.readSecureData('email').then((value) {
      _email = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Animated Splash Screen is a third party package which will
      // show us a splash screen and then route us to the next screen
      body: AnimatedSplashScreen(
        // for next screen, if our secure storage has authentication data,
        // then it will directly take us to the khoj The Search screen
        // and if there is no authentication data then it will take us to
        // login screen where we can log in to our application or sign up
        nextScreen: _email != null ? KhojScreen() : LoginScreen(),
        // this splash argument will take our logo png file as input
        splash: "assets/images/logo.png",
        curve: Curves.fastOutSlowIn,
        // duration dictates how much time our splash screen will show
        duration: 500,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        // this splashIconSize will select our logo png files width
        splashIconSize: 300,
      ),
    );
  }
}
