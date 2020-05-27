import 'package:flutter/material.dart';
import 'package:nivo/models/CartModel.dart';
import 'package:nivo/models/Dish.dart';
import 'package:nivo/widgets/OrderList/Order.dart';

class OrderList extends StatelessWidget {
  final CartModel _cart;
  final bool hasRemoveFunction;
  final List<IDDish> dishes;
  OrderList({CartModel cart, this.hasRemoveFunction = true})
      : this._cart = cart,
        dishes = null;
  OrderList.fromDishes({this.dishes})
      : _cart = null,
        this.hasRemoveFunction = false;

  @override
  Widget build(BuildContext context) {
    if (_cart != null)
      return Column(children: <Widget>[
        ..._cart.dishes.asMap().entries.map((e) {
          int idx = e.key;
          IDDish dish = e.value;
          return Order(
              dish: dish,
              removeFunction: hasRemoveFunction
                  ? () {
                      _cart.remove(idx);
                    }
                  : null);
        }),
        /* Container(
          margin: EdgeInsets.all(15), child: Text("${_cart.totalPrice} грн.")), */
      ]);
    else
      return Column(children: <Widget>[
        ...dishes.asMap().entries.map((e) {
          int idx = e.key;
          IDDish dish = e.value;
          return Order(
              dish: dish,
              removeFunction: hasRemoveFunction
                  ? () {
                      _cart.remove(idx);
                    }
                  : null);
        }),
        /* Container(
          margin: EdgeInsets.all(15), child: Text("${_cart.totalPrice} грн.")), */
      ]);
  }
}
