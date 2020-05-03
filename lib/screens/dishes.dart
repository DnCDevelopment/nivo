import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:nivo/services/dish.dart';


class Dishes extends StatefulWidget {
  String id;
  String name;

  Dishes({@required this.id, @required this.name});

  @override
  _DishesStated createState() => _DishesStated();
}


class _DishesStated extends State<Dishes> {
  final db = Firestore.instance;
  List<IDDish> dishes;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _getData();
  }
        
  void _getData() async {
    db
    .collection('dishes')
    .where('restaurant', isEqualTo: widget.id)
    .getDocuments()
    .then((QuerySnapshot snapshot) => {
      snapshot.documents.forEach((dish) async {
        final url = await FirebaseStorage.instance.ref().child(dish.data['image']).getDownloadURL();
        IDDish good = IDDish(url, dish.data['name'], dish.data['price'], dish.data['restaurant'], dish.documentID);
        setState(() {
          if (dishes != null && dishes.length > 0) {
            dishes = [...dishes, good];
          } else {
            dishes = [good];
          }
        });
      })
    });
  }

Widget _getDishes(List<IDDish> dishes) {
  if (dishes != null && dishes.length > 0) {
    return Column(children: dishes.map((dish) => GestureDetector(
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
        )
      ).toList(),
    );
  }
  return Align(child: Text(''), alignment: Alignment.center,);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name != null ? widget.name : 'restaurant'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _getDishes(dishes)
        ),
      )
    );
  }
}