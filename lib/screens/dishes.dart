import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nivo/widgets/DishesList/DishesList.dart';
import 'package:nivo/models/Dish.dart';


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
  void didChangeDependencies() {
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
                final url = await FirebaseStorage.instance
                    .ref()
                    .child(dish.data['image'])
                    .getDownloadURL();
                IDDish good = IDDish(url, dish.data['name'], dish.data['price'],
                    dish.data['restaurant'], dish.documentID);
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

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name != null ? widget.name : 'restaurant'),
        ),
        body: SingleChildScrollView(
          child: Container(child: DishesList(dishes: dishes,)),
        ));
  }
}
