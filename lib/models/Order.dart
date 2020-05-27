import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String _uid;
  final String _date;
  final DocumentReference _restaurant;
  final String _status;

  Order(this._uid, this._date, this._restaurant, this._status);

  String get uid => _uid;
  String get date => _date;
  DocumentReference get restaurant => _restaurant;
  String get status => _status;
  String get shortDate {
    return date.split(" ")[0];
  }
}
