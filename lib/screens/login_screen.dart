import 'package:ami_design_pari_na/screens/khoj_screen.dart';
import 'package:ami_design_pari_na/screens/signup_screen.dart';
import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:ami_design_pari_na/utils/secure_storage.dart';
import 'package:ami_design_pari_na/widgets/adpn_button.dart';
import 'package:ami_design_pari_na/widgets/adpn_text_field.dart';
import 'package:ami_design_pari_na/widgets/logo_widget.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_page";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final SecureStorage _secureStorage = SecureStorage();
  String _email;
  String _password;
  bool _loading = false;

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
        child: ModalProgressHUD(
          inAsyncCall: _loading,
          color: brandColor,
          child: SingleChildScrollView(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: ADPNTextField(
                        onChanged: (value) {
                          _email = value;
                        },
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        hintText: "Email",
                        icon: FeatherIcons.atSign,
                        isSensitive: false,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                        onTap: () async {
                          try {
                            setState(() {
                              _loading = true;
                            });
                            final user = await _auth.signInWithEmailAndPassword(
                              email: _email,
                              password: _password,
                            );
                            if (user != null) {
                              print("Successfully Authenticated.");
                              await _secureStorage.writeSecureData(
                                'email',
                                _email,
                              );
                              setState(() {
                                _loading = false;
                              });
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                KhojScreen.id,
                                (route) => false,
                              );
                            }
                          } catch (e) {
                            print(e);
                            setState(() {
                              _loading = false;
                            });
                            errorAlert(context, "Invalid Email or Password");
                          }
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
                      color: brandColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
