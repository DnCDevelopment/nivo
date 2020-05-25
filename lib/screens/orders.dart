import 'dart:collection';

import 'package:nivo/models/CartModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nivo/models/Dish.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nivo/widgets/MainAppbar/MainAppbar.dart';
import 'package:nivo/widgets/MainAppbar/BackBtn.dart';
import 'package:nivo/widgets/OrderList/OrderList.dart';
import 'package:nivo/widgets/OrderList/OrderForm.dart';
import 'package:nivo/services/auth.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrdersPage> {
  String _phoneNumber;
  String _paymentType = "Cash";
  void changePhoneNumber(String phoneNumber) {
    setState(() => this._phoneNumber = phoneNumber);
  }

  void changePaymentType(String paymentType) {
    setState(() => this._paymentType = paymentType);
  }

  Future<bool> sendData(UnmodifiableListView<IDDish> dishes) async {
    DateTime date = DateTime.now();
    Auth auth = new Auth();
    FirebaseUser user = await auth.getCurrentUser();
    String restarauntId = dishes[0].getRestaurant();
    List<String> dishesNames =
        dishes.map((e) => "/dishes/" + e.getId()).toList();
    try {
      await Firestore.instance.collection('orders').add({
        'date': "${date.day}.${date.month}.${date.year}",
        'dishes': dishesNames,
        'number':
            "${date.day}${date.month}${date.year}${date.hour}${date.second}",
        'restaurant': '/restaurants/' + restarauntId,
        'status': 'prepare',
        'user': '/users/' + user.uid,
      });
    } catch (err) {
      return false;
    }
    return true;
  }

  Future<void> emptyCartDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: Text("Пустая корзина"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Добавьте блюда в корзину'),
                    Text('Или умрете от голода :)'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    child: Text('Оке'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppbar(
          title: 'Orders',
          leftButton: BackBtn(),
          withOrdersBtn: false,
        ),
        body: Consumer<CartModel>(builder: (consumerContext, cart, child) {
          if (cart.length == 0)
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                emptyCartDialog(consumerContext)
                    .then((value) => Navigator.of(context).pop()));
          return Column(children: <Widget>[
            Expanded(
                child: ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text("Dishes"),
                  children: [
                    OrderList(
                      cart: cart,
                    ),
                  ],
                ),
                OrderForm(
                  changeNumber: changePhoneNumber,
                  changePayment: changePaymentType,
                  currentPayment: _paymentType,
                )
              ],
            )),
            MaterialButton(
                minWidth: double.infinity,
                color: Colors.redAccent,
                textColor: Colors.white,
                height: 60,
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  sendData(cart.dishes).then((sended) => {
                    if(sended) Navigator.pushNamed(context, "/waiting")
                  });
                }),
          ]);
        }));
  }
}
