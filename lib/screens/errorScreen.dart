import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String _title;

  ErrorScreen({String title}) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Container(
        child: Center(
            child: Text(
          _title,
          style: TextStyle(color: Colors.white, fontSize: 25),
        )),
      ),
    );
  }
}
