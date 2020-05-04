import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:nivo/screens/dishes.dart';
import 'package:nivo/widgets/MainAppbar/MainAppbar.dart';

import 'package:nivo/services/restaurant.dart';

class PrimaryPage extends StatefulWidget {

  @override
  _PrimaryPageStated createState() => _PrimaryPageStated();
}

class _PrimaryPageStated extends State<PrimaryPage> {
  final db = Firestore.instance;
  List<IDRestaurant> restaurants;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
     _getData();
  }
        
  void _getData() async {
    db
    .collection('restaurants')
    .getDocuments()
    .then((QuerySnapshot snapshot) => {
      snapshot.documents.forEach((restaurant) async {
        final url = await FirebaseStorage.instance.ref().child(restaurant.data['image']).getDownloadURL();
        IDRestaurant rest = IDRestaurant(url, restaurant.data['name'], restaurant.documentID);
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

  Widget _getRestaurants(List<IDRestaurant> restaurants) {
    if (restaurants != null && restaurants.length > 0) {
      return Column(children: restaurants.map((restaurant) => GestureDetector(
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
                builder: (context) =>
                  Dishes(id: restaurant.getId(), name: restaurant.getName()),
              ),
            );
          },
      ),).toList());
    } else {
      return Align(child: Text(''), alignment: Alignment.center,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Welcome'),
              onTap: () => {},
            ),
          ],
        ),
      ),
      appBar: MainAppbar(),
      body: SingleChildScrollView(
        child: Container(
          child: _getRestaurants(restaurants)
        ),
      )
    );
  }
}
