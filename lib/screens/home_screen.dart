import 'package:ami_design_pari_na/screens/settings_screen.dart';
import 'package:ami_design_pari_na/screens/splash_screen.dart';
import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:ami_design_pari_na/utils/database_helper.dart';
import 'package:ami_design_pari_na/utils/secure_storage.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final _user = _auth.currentUser;
      if (_user != null) {
        loggedInUser = _user;
        print(loggedInUser.email);
      } else {
        print("no user");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome, ${loggedInUser.displayName}",
          style: TextStyle(
            color: brandColor,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: brandColor,
        actions: [
          IconButton(
            icon: Icon(FeatherIcons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SettingsScreen.id,
              );
            },
          ),
        ],
        actionsIconTheme: IconThemeData(
          color: brandColor,
        ),
      ),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
