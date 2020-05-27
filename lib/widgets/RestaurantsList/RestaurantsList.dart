import 'package:flutter/material.dart';
import 'package:nivo/screens/dishes.dart';
import 'package:nivo/models/Restaurant.dart';

class RestarauntList extends StatelessWidget {
  final List<IDRestaurant> restaurants;

  RestarauntList({this.restaurants});

  @override
  Widget build(BuildContext context) {
    if (restaurants != null && restaurants.length > 0) {
      return Column(
          children: restaurants
              .map(
                (restaurant) => GestureDetector(
                  child: Container(
                    child: Text(
                      restaurant.getName().toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    height: 200,
                    padding: EdgeInsets.only(top: 90),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.grey, spreadRadius: 1),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(restaurant.getImage()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Dishes(
                            id: restaurant.getId(), name: restaurant.getName()),
                      ),
                    );
                  },
                ),
              )
              .toList());
    } else {
      return Align(
        child: Text(''),
        alignment: Alignment.center,
      );
    }
  }
}
