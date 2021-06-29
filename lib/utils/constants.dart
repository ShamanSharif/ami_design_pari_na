// This is a separate file for keeping all the constants
// away from other files so there will be consistance between colors
// Plus one can easily change to their desired color from here

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

Color buttonTextColor = Color(0xFFFFFFFF);
Color brandColor = Color(0xFF5E17EB);
Color textFieldColor = Color(0xFFF2F2F2);
Color dimBlackColor = Color(0xFF606060);
Color bloodRed = Color(0xFFD70000);
Color calmGreen = Color(0xFF13845B);

// this Alert Widget is Created with the help of CoolAlert Package
// this function is for showing various errors that may occur
// during the execution of this application
void errorAlert(BuildContext context, String text) => CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      backgroundColor: brandColor,
      confirmBtnColor: brandColor,
      text: text,
    );
