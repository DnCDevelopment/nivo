import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nivo/screens/waiting.dart';
import 'package:nivo/services/auth.dart';
import 'package:nivo/utils/getDocument.dart';
import 'package:nivo/widgets/MainAppbar/MainAppbar.dart';
import 'package:nivo/widgets/MainAppbar/MenuBtn.dart';
import 'package:nivo/widgets/MainDrawer/MainDrawer.dart';
import 'package:nivo/models/Order.dart';

class UserOrdersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserOrdersScreenState();
}

class UserOrdersScreenState extends State<UserOrdersScreen> {
  final Firestore db = Firestore.instance;
  final Auth auth = Auth();
  List<Order> orders = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getData();
  }

  void _getData() async {
    FirebaseUser user = await auth.getCurrentUser();
    QuerySnapshot orders = await db
        .collection('/orders')
        .where('user', isEqualTo: db.collection('/users').document(user.uid))
        .getDocuments();
    setState(() => this.orders = orders.documents
        .map((element) => Order(element.documentID, element.data['date'],
            element.data['restaurant'], element.data['status']))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: MainAppbar(
        leftButton: MenuBtn(),
        title: "Мои заказы",
      ),
      body: SingleChildScrollView(
          child: Container(
              child: Column(
        children: orders
            .map((e) => GestureDetector(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '№' + e.uid.substring(0, 7),
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                              stream: getDocument(e.restaurant),
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data != null
                                      ? snapshot.data['name']
                                      : '',
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                );
                              }),
                        ],
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SingleOrder(orderRef: e.uid)));
                  },
                ))
            .toList(),
      ))),
    );
  }
}
