import 'package:ami_design_pari_na/screens/splash_screen.dart';
import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:ami_design_pari_na/utils/database_helper.dart';
import 'package:ami_design_pari_na/utils/storage.dart';
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
  final _dbProvider = DBProvider.instance;
  final SecureStorage _secureStorage = SecureStorage();
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
            icon: Icon(FeatherIcons.logOut),
            onPressed: () async {
              await _secureStorage.deleteSecureData('email');
              Navigator.pushNamedAndRemoveUntil(
                context,
                SplashScreen.id,
                (route) => false,
              );
            },
          ),
        ],
        actionsIconTheme: IconThemeData(
          color: brandColor,
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            try {
              await _dbProvider.insert(DBProvider.tableName, {
                DBProvider.userId: loggedInUser.uid,
                DBProvider.timeStamp: DateTime.now().toString(),
                DBProvider.values: "5,4,3,2,1",
              });
            } catch (e) {
              print(e);
            }
          },
          child: Text("Test Database : Insert"),
        ),
      ),
    );
  }
}
