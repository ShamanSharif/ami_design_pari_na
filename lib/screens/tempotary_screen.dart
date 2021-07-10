import 'package:flutter/material.dart';

class TempotaryScreen extends StatefulWidget {
  static const String id = "tempotary_screen";
  const TempotaryScreen({Key key}) : super(key: key);

  @override
  _TempotaryScreenState createState() => _TempotaryScreenState();
}

class _TempotaryScreenState extends State<TempotaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tempotary Screen"),
      ),
      body: SafeArea(
        child: Center(
          child: Text("Hello"),
        ),
      ),
    );
  }
}
