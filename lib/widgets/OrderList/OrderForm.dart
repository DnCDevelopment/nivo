import 'package:flutter/material.dart';

class OrderForm extends StatelessWidget {
  final Function changeNumber;
  final Function changePayment;
  final String currentPayment;
  final TextEditingController phoneController = TextEditingController();
  OrderForm({this.changeNumber, this.changePayment, this.currentPayment});

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Phone",
                ),
                onChanged: (val) {
                  changeNumber(val);
                },
              )),
          Column(
            children: <Widget>[
              RadioListTile(
                  title: Text("Cash"),
                  value: "Cash",
                  groupValue: currentPayment,
                  onChanged: (value) => changePayment(value)),
              RadioListTile(
                  title: Text("Card"),
                  value: "Card",
                  groupValue: currentPayment,
                  onChanged: (value) => changePayment(value))
            ],
          )
        ]);
  }
}
