import 'package:ami_design_pari_na/screens/home_screen.dart';
import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:ami_design_pari_na/widgets/adpn_button.dart';
import 'package:ami_design_pari_na/widgets/adpn_text_field.dart';
import 'package:ami_design_pari_na/widgets/logo_widget.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "signup_page";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  String _username;
  String _password;

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
          "SIGN UP",
          style: TextStyle(
            color: brandColor,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: brandColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(90),
              child: LogoWidget(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ADPNTextField(
                onChanged: (value) {
                  _username = value;
                },
                hintText: "Username",
                icon: FeatherIcons.user,
                isSensitive: false,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ADPNTextField(
                onChanged: (value) {
                  _password = value;
                },
                hintText: "Password",
                icon: FeatherIcons.key,
                isSensitive: true,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 38,
                  ),
                  ADPNButton(
                    title: "SIGN UP",
                    onTap: () async {
                      // print("Username: $_username");
                      // print("Password: $_password");
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                          email: _username,
                          password: _password,
                        );
                        if (newUser != null) {
                          print("Successfully Authenticated.");
                          Navigator.pushNamed(context, HomeScreen.id);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(FeatherIcons.helpCircle),
                    iconSize: 38,
                    color: brandColor,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Username: ",
                                style: TextStyle(
                                  color: brandColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "username must be at least 3 characters. It may include alphabets and numbers.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: dimBlackColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Password: ",
                                style: TextStyle(
                                  color: brandColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "password must be at least 6 characters. It may include alphabet, numbers and symbols.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: dimBlackColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
