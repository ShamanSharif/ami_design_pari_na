import 'package:ami_design_pari_na/screens/settings_screen.dart';
import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:ami_design_pari_na/utils/database_helper.dart';
import 'package:ami_design_pari_na/widgets/adpn_button.dart';
import 'package:ami_design_pari_na/widgets/adpn_text_field.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ami_design_pari_na/screens/dekhao_screen.dart';
import 'package:page_transition/page_transition.dart';

class KhojScreen extends StatefulWidget {
  static const String id = 'khoj_page';
  @override
  _KhojScreenState createState() => _KhojScreenState();
}

class _KhojScreenState extends State<KhojScreen> {
  final _auth = FirebaseAuth.instance;
  final _dbProvider = DBProvider.instance;
  User loggedInUser;
  String _inputField;
  String _searchField;
  bool _result;

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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Welcome, ${loggedInUser.displayName}",
          // "Welcome",
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Image(
                  image: AssetImage(
                    _result == null
                        ? "assets/images/ok.png"
                        : _result
                            ? "assets/images/true.png"
                            : "assets/images/false.png",
                  ),
                  width: 350,
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ADPNTextField(
                      onChanged: (value) {
                        _inputField = value;
                      },
                      textInputAction: TextInputAction.next,
                      hintText: "Input (e.g. 2,6,3,1,5,...)",
                      icon: FeatherIcons.type,
                      isSensitive: false,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ADPNTextField(
                      onChanged: (value) {
                        _searchField = value;
                      },
                      textInputType: TextInputType.number,
                      hintText: "Search (e.g. 2)",
                      icon: FeatherIcons.search,
                      isSensitive: false,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ADPNButton(
                  title: "KHOJ",
                  onTap: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if (_inputField == null ||
                        _inputField == "" ||
                        _searchField == null ||
                        _searchField == "") {
                      errorAlert(context, "Give me some Input. Will You?");
                    } else {
                      var inputData = _inputField;
                      var searchData = _searchField;
                      bool valid = true;
                      int searchNumber;
                      List<int> inputNumbers = [];
                      List inputList;

                      inputData = inputData.split(" ").join("");
                      inputList = inputData.split(",");
                      for (var i in inputList) {
                        try {
                          inputNumbers.add(int.parse(i));
                        } catch (e) {
                          valid = false;
                          print(e);
                          errorAlert(context,
                              "Only put INTEGERS separated by comma in the input field");
                        }
                      }
                      inputNumbers.sort((b, a) => a.compareTo(b));
                      print(inputNumbers);
                      try {
                        searchNumber = int.parse(searchData.trim());
                      } catch (e) {
                        valid = false;
                        errorAlert(context,
                            "Only put one integer. nothing more, nothing less");
                      }

                      if (valid) {
                        _result = null;
                        for (int i in inputNumbers) {
                          if (i == searchNumber) {
                            setState(() {
                              _result = true;
                            });
                          }
                        }
                        if (_result == null) {
                          setState(() {
                            _result = false;
                          });
                        }
                      }
                      try {
                        await _dbProvider.insert(DBProvider.tableName, {
                          DBProvider.userId: loggedInUser.uid,
                          DBProvider.timeStamp: DateTime.now().toString(),
                          DBProvider.values: inputNumbers.toString(),
                        });
                      } catch (e) {
                        print(e);
                        errorAlert(context, "Some Database Error $e");
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.search),
            label: "KHOJ The Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.image),
            label: "DEKHAO Chobi",
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeftJoined,
                child: DekhaoScreen(),
                childCurrent: KhojScreen(),
              ),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
