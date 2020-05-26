import 'package:flutter/material.dart';

class OrderForm extends StatelessWidget {
  final Function changeNumber;
  final Function changeAddress;
  final Function changePayment;
  final String currentPayment;
  final TextEditingController phoneController = TextEditingController();
  OrderForm({this.changeNumber, this.changePayment, this.currentPayment, this.changeAddress});

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
                  labelText: "Адресс",
                ),
                onChanged: (val) {
                  changeAddress(val);
                },
              )),
          Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Номер телефона",
                ),
                onChanged: (val) {
                  changeNumber(val);
                },
              )),
          Column(
            children: <Widget>[
              RadioListTile(
                  title: Text("Наличный расчет"),
                  value: "Cash",
                  groupValue: currentPayment,
                  onChanged: (value) => changePayment(value)),
              RadioListTile(
                  title: Text("Безналичный расчиет"),
                  value: "Card",
                  groupValue: currentPayment,
                  onChanged: (value) => changePayment(value))
            ],
          )
        ]);
  }
}
