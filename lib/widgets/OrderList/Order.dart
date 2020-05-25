import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nivo/models/Dish.dart';

class Order extends StatelessWidget {
  final Dish dish;
  final Function removeFunction;
  Order({this.dish, this.removeFunction});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 0.12 * MediaQuery.of(context).size.width,
          height: 0.12 * MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(dish.getImage()),
            ),
          ),
        ),
        Expanded(child: Text(dish.getName())),
        if(removeFunction != null)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: removeFunction,
        )
      ],
    );
  }
}
