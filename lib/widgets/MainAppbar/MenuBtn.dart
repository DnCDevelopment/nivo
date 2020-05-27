import 'package:flutter/material.dart';

class MenuBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () => {Scaffold.of(context).openDrawer()});
  }
}
