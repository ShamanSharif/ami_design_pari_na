import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

Color buttonColor = Color(0xFFFFFFFF);
Color brandColor = Color(0xFF5E17EB);
Color textFieldColor = Color(0xFFF2F2F2);
Color dimBlackColor = Color(0xFF606060);

void errorAlert(BuildContext context, String text) => CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      backgroundColor: brandColor,
      confirmBtnColor: brandColor,
      text: text,
    );
