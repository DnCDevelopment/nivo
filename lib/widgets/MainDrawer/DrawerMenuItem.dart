import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  DrawerMenuItem({this.icon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
          children: <Widget>[
            Container(
              child: Icon(this.icon),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            Text(
              this.title,
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        onTap: this.onTap);
  }
}
