import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cart extends StatefulWidget {
  final String orderId;

  Cart(this.orderId);

  @override
  CartStated createState() => CartStated();
}

class CartStated extends State<Cart> {
  final Map<String, Marker> _markers = {};
  final _db = Firestore.instance;

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _getCurrentLocation(
      GeoPoint position, String status, String courierId) async {
    try {
      GoogleMapController controller = await _controller.future;
      final Marker marker = Marker(
        markerId: MarkerId("address"),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
        onTap: () {},
      );
      setState(() {
        _markers["address"] = marker;
      });
      if (status == 'deliver') {
        _db
            .collection('couriers')
            .document(courierId)
            .get()
            .then((courier) async {
          final _icon = await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(24, 24)), 'assets/marker.png');
          final Marker marker = Marker(
            markerId: MarkerId('courier'),
            icon: _icon,
            position: LatLng(
              courier.data['position'].latitude,
              courier.data['position'].longitude,
            ),
            onTap: () {},
          );
          setState(() {
            _markers["courier"] = marker;
          });
        }).catchError((err) {
          print(err);
        });
      }
      controller.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude), 15));
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: _db.collection('orders').document(widget.orderId).snapshots(),
      builder: (context, order) {
        _getCurrentLocation(
            order.data != null
                ? order.data['geolocation']
                : GeoPoint(50.448619, 30.522760),
            order.data != null ? order.data['status'] : '',
            order.data != null ? order.data['courier'] : '');
        return GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers.values.toSet(),
          mapType: MapType.terrain,
          initialCameraPosition: CameraPosition(
            target: LatLng(50.448619, 30.522760),
            zoom: 11.0,
          ),
        );
        // if (order.data != null && order.data["status"] != 'deliver') {
        //   return Center(
        //     child: Text(
        //       'Status: ' + order.data["status"],
        //       textAlign: TextAlign.center,
        //       style: TextStyle(fontSize: 24),
        //     ),
        //   );
        // } else {
        //   return StreamBuilder<DocumentSnapshot>(
        //     stream: _db
        //         .collection('couriers')
        //         .document(order.data != null && order.data['courier'] != null
        //             ? order.data['courier']
        //             : '')
        //         .snapshots(),
        //     builder: (context, courier) {
        //       return
        //     },
        //   );
        // }
      },
    ));
  }
}
