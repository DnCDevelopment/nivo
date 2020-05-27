import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nivo/models/Dish.dart';
import 'package:nivo/widgets/MainAppbar/BackBtn.dart';
import 'package:nivo/widgets/MainAppbar/CheckBtn.dart';
import 'package:nivo/widgets/MainAppbar/MainAppbar.dart';

import 'package:nivo/widgets/OrderList/OrderList.dart';

class SingleOrder extends StatefulWidget {
  final String orderRef;
  SingleOrder({this.orderRef});

  @override
  State<SingleOrder> createState() => _SingleOrder(orderRef);
}

class _SingleOrder extends State<SingleOrder> {
  final String orderRef;
  final db = Firestore.instance;
  List<IDDish> dishes = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getData();
  }

  void _getData() async {
    DocumentSnapshot orderSnapshot =
        await db.collection('orders').document(orderRef).get();
    orderSnapshot.data['dishes'].toList().forEach((e) async {
      DocumentSnapshot dish =
          await db.collection('dishes').document(e.documentID).get();
      final url = await FirebaseStorage.instance
          .ref()
          .child(dish.data['image'])
          .getDownloadURL();
      setState(() => dishes = [
            ...dishes,
            IDDish(url, dish.data['name'], dish.data['price'],
                dish.data['restaraunt'], dish.documentID)
          ]);

    });
  }

  _SingleOrder(String orderRef) : this.orderRef = orderRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: MainAppbar(
            leftButton: BackBtn(),
            title: 'Ваш заказ',
            rightButton: CheckBtn(dishes: dishes,order: orderRef,),
            bottom: TabBar(tabs: [
              Tab(text: 'Log in'),
              Tab(text: 'Registration'),
            ]),

          ),
          body: TabBarView(
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream:
                      db.collection('/orders').document(orderRef).snapshots(),
                  builder: (context, snapshot) {
                    return OrderList.fromDishes(
                      dishes: this.dishes,
                    );
                  }),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
