import 'package:flutter/material.dart';
import 'package:nivo/widgets/MainAppbar/CartBtn.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  final Widget bottom;
  final Function onPressed;
  final Function onTitleTapped;
  final Widget leftButton;
  final bool withOrdersBtn;
  final Widget rightButton;

  @override
  final Size preferredSize;
  MainAppbar(
      {this.title,
      this.child,
      this.onPressed,
      this.onTitleTapped,
      this.rightButton,
      this.withOrdersBtn = true,
      this.leftButton,
      this.bottom})
      : preferredSize = Size.fromHeight(bottom != null ? 106 : 80);

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
      child: Column(children: [
        Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              leftButton,
              Expanded(
                  child: Text(title,
                      style: TextStyle(fontSize: 20, color: Colors.white))),
              if(rightButton == null && withOrdersBtn) CartBtn(),
              if(rightButton != null ) rightButton,
            ]),

        if (bottom != null) bottom
      ]),
    ));
  }
}
