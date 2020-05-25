import 'package:flutter/material.dart';
import 'package:nivo/models/CartModel.dart';
import 'package:nivo/models/Dish.dart';
import 'package:nivo/widgets/OrderList/Order.dart';

class OrderList extends StatelessWidget {
  final CartModel _cart;
  final bool hasRemoveFunction;
  OrderList({CartModel cart, this.hasRemoveFunction = true}):this._cart = cart;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ..._cart.dishes.asMap().entries.map((e) {
        int idx = e.key;
        IDDish dish = e.value;
        return Order(
            dish: dish,
            removeFunction: hasRemoveFunction?() {
              _cart.remove(idx);
            }:null);
      }),
      Container(
          margin: EdgeInsets.all(15), child: Text("${_cart.totalPrice} грн.")),
    ]);
  }
}
