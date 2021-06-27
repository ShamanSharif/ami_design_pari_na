import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class ADPNTextField extends StatefulWidget {
  final IconData icon;
  final bool isSensitive;
  final Function onChanged;
  final String hintText;
  const ADPNTextField({
    Key key,
    @required this.icon,
    @required this.isSensitive,
    @required this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  _ADPNTextFieldState createState() => _ADPNTextFieldState();
}

class _ADPNTextFieldState extends State<ADPNTextField> {
  bool isObscure;

  @override
  void initState() {
    isObscure = widget.isSensitive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        onChanged: widget.onChanged,
        obscureText: isObscure,
        cursorColor: brandColor,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: widget.isSensitive
              ? IconButton(
                  icon: isObscure
                      ? Icon(FeatherIcons.eye)
                      : Icon(FeatherIcons.eyeOff),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null,
          hintText: widget.hintText,
          icon: Icon(
            widget.icon,
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
