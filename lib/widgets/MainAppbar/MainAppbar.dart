import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  final Function onPressed;
  final Function onTitleTapped;
  final Widget leftButton;
  final bool withOrdersBtn;

  @override
  final Size preferredSize;
  MainAppbar(
      {this.title,
      this.child,
      this.onPressed,
      this.onTitleTapped,
      this.withOrdersBtn = true,
      this.leftButton})
      : preferredSize = Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.redAccent,
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 15.0,
            spreadRadius: 5.0,
            offset: new Offset(0.0, 0.0),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            leftButton,
            Expanded(
                child: Text(title,
                    style: TextStyle(fontSize: 20, color: Colors.white))),
                  IconButton(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {
                          Navigator.pushNamed(context, '/orders');
                      })
          ]),
    ));
  }
}
