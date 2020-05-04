import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomScrollView(
        slivers: <Widget>[
          //Тут будут кастомные силверы листа(пункты менюшки) и аппбара(профиль)
        ],
      )
    );
  }
}
