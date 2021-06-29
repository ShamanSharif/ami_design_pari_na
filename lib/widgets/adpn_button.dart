import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:flutter/material.dart';

// this is a button widget created for this project with the
// project brand color suitable for using on various places
class ADPNButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const ADPNButton({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        // this ClipRRect is use for give our button a border radius
        borderRadius: BorderRadius.circular(5),
        child: ColoredBox(
          color: brandColor,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 50,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: buttonTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
