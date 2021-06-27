import 'package:ami_design_pari_na/screens/home_screen.dart';
import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:ami_design_pari_na/utils/storage.dart';
import 'package:ami_design_pari_na/widgets/adpn_button.dart';
import 'package:ami_design_pari_na/widgets/adpn_text_field.dart';
import 'package:ami_design_pari_na/widgets/logo_widget.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "signup_page";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final SecureStorage _secureStorage = SecureStorage();
  String _fullname;
  String _email;
  String _password;
  bool _loading = false;

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
        child: ModalProgressHUD(
          inAsyncCall: _loading,
          color: brandColor,
          child: SingleChildScrollView(
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
                      _fullname = value;
                    },
                    textInputType: TextInputType.name,
                    hintText: "Full Name",
                    icon: FeatherIcons.user,
                    isSensitive: false,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ADPNTextField(
                    onChanged: (value) {
                      _email = value;
                    },
                    textInputType: TextInputType.emailAddress,
                    hintText: "Email",
                    icon: FeatherIcons.atSign,
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
                            setState(() {
                              _loading = true;
                            });
                            if (_fullname == null ||
                                _fullname.trim().length < 3) {
                              setState(() {
                                _loading = false;
                              });
                              errorAlert(context,
                                  "Name must be at least 3 characters.");
                            } else if (_email == null || _email == "") {
                              setState(() {
                                _loading = false;
                              });
                              errorAlert(
                                  context, "Must be a valid Email address.");
                            } else if (_password == null ||
                                _password.length < 6) {
                              setState(() {
                                _loading = false;
                              });
                              errorAlert(context,
                                  "Password must be at least 6 characters.");
                            } else {
                              try {
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                  email: _email,
                                  password: _password,
                                );
                                if (newUser != null) {
                                  print("Successfully Authenticated.");
                                  await newUser.user
                                      .updateProfile(displayName: _fullname);
                                  await _secureStorage.writeSecureData(
                                    'email',
                                    _email,
                                  );
                                  setState(() {
                                    _loading = false;
                                  });
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    HomeScreen.id,
                                    (route) => false,
                                  );
                                }
                              } catch (e) {
                                print(e);
                                setState(() {
                                  _loading = false;
                                });
                                errorAlert(
                                    context, "Invalid Email or Password");
                              }
                            }
                          }),
                      IconButton(
                        icon: Icon(FeatherIcons.helpCircle),
                        iconSize: 38,
                        color: brandColor,
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Full Name: ",
                                    style: TextStyle(
                                      color: brandColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "Full Name must be at least 3 characters. It may include alphabets and numbers and spaces.",
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
                                    text: "Email: ",
                                    style: TextStyle(
                                      color: brandColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "Email must be a valid email address.",
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
        ),
      ),
    );
  }
}
