import 'dart:collection';

import 'package:geolocator/geolocator.dart';
import 'package:nivo/models/CartModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nivo/models/Dish.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nivo/screens/waiting.dart';
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
  String _address = "";
  void changePhoneNumber(String phoneNumber) {
    setState(() => this._phoneNumber = phoneNumber);
  }

  void changeAddress(String address) {
    setState(() => this._address = address);
  }

  void changePaymentType(String paymentType) {
    setState(() => this._paymentType = paymentType);
  }

  Future<DocumentReference> sendData(
      UnmodifiableListView<IDDish> dishes) async {
    Position currentPostition = await Geolocator().getCurrentPosition();

    DateTime date = DateTime.now();
    Auth auth = new Auth();
    FirebaseUser user = await auth.getCurrentUser();
    DocumentReference userRef =
        Firestore.instance.collection('users').document(user.uid);
    String restarauntId = dishes[0].getRestaurant();
    DocumentReference restarauntRef =
        Firestore.instance.collection('restaurants').document(restarauntId);
    List<DocumentReference> dishesRef = dishes
        .map((e) => Firestore.instance.collection('dishes').document(e.getId()))
        .toList();
    try {
      DocumentReference orderRef =
          await Firestore.instance.collection('orders').add({
        'date': date.toString(),
        'dishes': dishesRef,
        'restaurant': restarauntRef,
        'number': '',
        'status': 'waiting',
        'user': userRef,
        'geolocation': GeoPoint(currentPostition.latitude, currentPostition.longitude),
        'address': _address,
      });
      Firestore.instance
          .collection('orders')
          .document(orderRef.documentID)
          .setData({'number': orderRef.documentID}, merge: true);

      return orderRef;
    } catch (err) {
      print(err.toString());
      print("Failed");
      return null;
    }
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
                  changeAddress: changeAddress,
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
                  sendData(cart.dishes).then((document) {
                    if (document != null)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SingleOrder(orderRef: document.documentID)));
                  }).catchError((err) => print(err));
                }),
          ]);
        }));
  }
}
