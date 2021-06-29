import 'package:ami_design_pari_na/screens/splash_screen.dart';
import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:ami_design_pari_na/utils/database_helper.dart';
import 'package:ami_design_pari_na/utils/secure_storage.dart';
import 'package:ami_design_pari_na/widgets/logo_widget.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_page';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // creating a instance variable for using Firebase Authentication
  final _auth = FirebaseAuth.instance;
  final _dbProvider = DBProvider.instance;
  // setting a Secure Storage object for storing and retrieving secure storage data
  final SecureStorage _secureStorage = SecureStorage();
  User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    // this function is used for getting the current user from firebase
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
          "SETTINGS & INFO",
          style: TextStyle(
            color: brandColor,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: brandColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 250,
            child: LogoWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "\"Ami Design Pari Na\" is a Evaluation Project built with Flutter (a Cross Platform Software Development Kit) built for EvidentBD Ltd.\n\nAll of it's source code is freely available on my Github (https://github.com/pieas-asif/)",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
          ),
          TextButton(
            onPressed: () async {
              try {
                // deleting secure storage data
                await _secureStorage.deleteSecureData('email');
                // signing out from firebase authentication
                await _auth.signOut();
                // navigate back to splash screen
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SplashScreen.id,
                  (route) => false,
                );
              } catch (e) {
                print(e);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.logOut,
                  color: bloodRed,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "LOGOUT",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: bloodRed,
                  ),
                ),
              ],
            ),
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
            child: Text(
              "Test Database : Drop",
              style: TextStyle(
                color: calmGreen,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                var data = await _dbProvider.queryAll(
                  DBProvider.tableName,
                );
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(data.toString()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: Text(
                          'Close',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } catch (e) {
                print(e);
              }
            },
            child: Text(
              "Test Database : Query",
              style: TextStyle(
                color: calmGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
