import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nivo/models/CartModel.dart';
import 'package:nivo/widgets/DishesList/DishesList.dart';
import 'package:nivo/models/Dish.dart';
import 'package:nivo/widgets/MainAppbar/MainAppbar.dart';
import 'package:nivo/widgets/MainAppbar/BackBtn.dart';
import 'package:provider/provider.dart';

class Dishes extends StatefulWidget {
  String id;
  String name;

  Dishes({@required this.id, @required this.name});

  @override
  _DishesStated createState() => _DishesStated();
}

class _DishesStated extends State<Dishes> {
  final db = Firestore.instance;
  bool dialogExisting = false;
  List<IDDish> dishes;

  openDialog() {
    setState(() => dialogExisting = true);
  }

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

  Future<bool> notEmptyCartDialog(BuildContext context) {
    openDialog();
    final dialog = AlertDialog(
      title: Text("Не пустая корзина"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Ая-яй, как грустно выходит!'),
            Text(
                'Вы одновременно можете заказывать блюда из только одного ресторана'),
            Text('Хотите сменить ресторан?'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            child: Text('Йес'),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        FlatButton(
            child: Text('Ноу'),
            onPressed: () {
              Navigator.pop(context, false);
            }),
      ],
    );
    return showDialog(
        context: context, barrierDismissible: false, builder: (_) => dialog);
  }

  @override
  Widget build(BuildContext mainContext) {
    return Scaffold(
        appBar: MainAppbar(
          title: widget.name != null ? widget.name : 'Restaraunt',
          leftButton: BackBtn(),
        ),
        body: Consumer<CartModel>(builder: (context, cart, child) {
          if (!dialogExisting && cart.length != 0 && cart.dishes[0].getRestaurant() != widget.id) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              notEmptyCartDialog(mainContext).then((value) {
                if (!value)
                  Navigator.of(context).pop();
                else
                  cart.clear();
              });
            });
          }
          return SingleChildScrollView(
            child: Container(
                child: DishesList(
              dishes: dishes,
            )),
          );
        }));
  }
}
