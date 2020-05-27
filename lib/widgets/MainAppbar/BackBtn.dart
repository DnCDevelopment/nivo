import 'package:flutter/material.dart';

class BackBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => {Navigator.pop(context)});
  }
}
