import 'package:ami_design_pari_na/screens/dekhao_screen.dart';
import 'package:ami_design_pari_na/screens/khoj_screen.dart';
import 'package:ami_design_pari_na/screens/photo_viewer_screen.dart';
import 'package:ami_design_pari_na/screens/settings_screen.dart';
import 'package:ami_design_pari_na/screens/login_screen.dart';
import 'package:ami_design_pari_na/screens/signup_screen.dart';
import 'package:ami_design_pari_na/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Quicksand",
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        KhojScreen.id: (context) => KhojScreen(),
        DekhaoScreen.id: (context) => DekhaoScreen(),
        PhotoViewerScreen.id: (context) => PhotoViewerScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
      },
    );
  }
}
