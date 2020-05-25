import 'dart:collection';
import 'package:flutter/foundation.dart';

import 'package:nivo/models/Dish.dart';

class CartModel extends ChangeNotifier {
  final List<IDDish> _dishes = [];

  CartModel();

  UnmodifiableListView<IDDish> get dishes => UnmodifiableListView(_dishes);
  int get length => _dishes.length;

  void clear() => _dishes.clear();

  CartModel remove(int id) {
    _dishes.removeAt(id);
    notifyListeners();
    return this;
  }

  CartModel add(IDDish item) {
    _dishes.add(item);
    print(this.length);
    notifyListeners();
    return this;
  }

  int get totalPrice {
    int price = 0;
    _dishes.forEach((element) {
      price += int.parse(element.getPrice().split(" ")[0]);
    });
    return price;
  }
}
