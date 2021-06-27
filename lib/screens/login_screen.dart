import 'package:ami_design_pari_na/screens/signup_screen.dart';
import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:ami_design_pari_na/widgets/adpn_button.dart';
import 'package:ami_design_pari_na/widgets/adpn_text_field.dart';
import 'package:ami_design_pari_na/widgets/logo_widget.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_page";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LOGIN",
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  child: ADPNButton(
                    title: "LOGIN",
                    onTap: () {
                      print("Username: $_username");
                      print("Password: $_password");
                    },
                  ),
                )
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.id);
              },
              child: Text(
                "Don't have an acount?",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
