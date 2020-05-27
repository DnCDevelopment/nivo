import 'package:flutter/material.dart';

class CartBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        });
  }
}
