import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:flutter/material.dart';

class ADPNButton extends StatelessWidget {
  final String title;
  const ADPNButton({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {print("Hello")},
      child: ColoredBox(
        color: Colors.deepPurple,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 50,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: buttonColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
