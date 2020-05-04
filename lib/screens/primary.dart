import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:nivo/widgets/MainAppbar/MainAppbar.dart';
import 'package:nivo/widgets/MainDrawer/MainDrawer.dart';
import 'package:nivo/widgets/RestaurantsList/RestaurantsList.dart';

import 'package:nivo/models/Restaurant.dart';


class PrimaryPage extends StatefulWidget {
  @override
  _PrimaryPageStated createState() => _PrimaryPageStated();
}

class _PrimaryPageStated extends State<PrimaryPage> {
  final db = Firestore.instance;
  List<IDRestaurant> restaurants;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getData();
  }

  void _getData() async {
    db
        .collection('restaurants')
        .getDocuments()
        .then((QuerySnapshot snapshot) => {
              snapshot.documents.forEach((restaurant) async {
                final url = await FirebaseStorage.instance
                    .ref()
                    .child(restaurant.data['image'])
                    .getDownloadURL();
                IDRestaurant rest = IDRestaurant(
                    url, restaurant.data['name'], restaurant.documentID);
                setState(() {
                  if (restaurants != null && restaurants.length > 0) {
                    restaurants = [...restaurants, rest];
                  } else {
                    restaurants = [rest];
                  }
                });
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),      
        appBar: MainAppbar(title: "Nivo",),
        body: SingleChildScrollView(
          child: Container(child: RestarauntList(restaurants: restaurants,)),
        ));
  }
}
