import 'package:ami_design_pari_na/screens/splash_screen.dart';
import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:ami_design_pari_na/utils/database_helper.dart';
import 'package:ami_design_pari_na/utils/secure_storage.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_page';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        leading: IconButton(
          icon: Icon(
            FeatherIcons.arrowLeft,
            color: brandColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "SETTINGS",
          style: TextStyle(
            color: brandColor,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: brandColor,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
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
            TextButton(
              onPressed: () async {
                try {
                  await _dbProvider.dropTable(
                    DBProvider.tableName,
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Test Database : Drop"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  var data = await _dbProvider.queryAll(
                    DBProvider.tableName,
                  );
                  print(data);
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Test Database : Query"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _secureStorage.deleteSecureData('email');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    SplashScreen.id,
                    (route) => false,
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: Text("LOGOUT"),
            ),
          ],
        ),
      ),
    );
  }
}
