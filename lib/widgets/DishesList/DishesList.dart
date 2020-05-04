import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:nivo/models/CartModel.dart';
import 'package:nivo/models/Dish.dart';


class DishesList extends StatelessWidget {

  final List<IDDish> dishes;
  DishesList({this.dishes});

  @override
  Widget build(BuildContext context) {
    if(dishes != null &&  dishes.length > 0)
      return Column(
          children: dishes
              .map((dish) => Consumer<CartModel>(
                builder: (context, cart, child) {
                    return GestureDetector(
                      onTap: () => {
                        cart.add(dish)
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 0.5 * MediaQuery.of(context).size.width,
                              height: 150,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(dish.getImage()),
                                ),
                              ),
                            ),
                            Text(
                              dish.getName(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                dish.getPrice(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
              .toList(),
        );
    else 
      return Align(
        child: Text(''),
        alignment: Alignment.center,
      );
  }
}
