import 'dart:collection';
import 'package:flutter/foundation.dart';

import 'package:nivo/models/Dish.dart';

class CartModel extends ChangeNotifier {
  final List<IDDish> _dishes = [];

  CartModel();

  UnmodifiableListView<IDDish> get dishes => UnmodifiableListView(_dishes);
  int get length => _dishes.length;

  CartModel add(IDDish item) {
    _dishes.add(item);
    print(this.length);
    notifyListeners();
    return this;
  }
}
