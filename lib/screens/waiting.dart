import 'package:flutter/material.dart';
import 'package:nivo/models/CartModel.dart';
import 'package:nivo/widgets/OrderList/OrderList.dart';
import 'package:provider/provider.dart';


class WaitingTabs extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Orders'),
                Tab(text: 'Map'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Consumer<CartModel>
              (
                builder: (context, cart, child) => OrderList(cart: cart,hasRemoveFunction: false),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
