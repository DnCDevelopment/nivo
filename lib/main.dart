import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:nivo/screens/my-orders.dart';
import 'package:nivo/screens/waiting.dart';
import 'package:provider/provider.dart';

import 'package:nivo/screens/login.dart';
import 'package:nivo/screens/primary.dart';
import 'package:nivo/screens/orders.dart';
import 'package:nivo/screens/errorScreen.dart';

import 'package:nivo/services/auth.dart';

import 'package:nivo/models/CartModel.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Auth _auth = Auth();
  final bool isLogged = await _auth.isLogged();
  final Geolocator geolocator = new Geolocator();
  final Position position = await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);
  final List<Address> currentAddress = await Geocoder.local
      .findAddressesFromCoordinates(
          Coordinates(position.latitude, position.longitude));
  final String subAdminArea = currentAddress.first.subAdminArea;
  final MyApp myApp = MyApp(
    isLogged: isLogged,
    area: subAdminArea,
  );

  runApp(myApp);
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  final String area;
  final routes = {
    '/orders': (context) => UserOrdersScreen(),
    '/restaurants': (context) => PrimaryPage(),
    '/cart': (context) => OrdersPage(),
    '/cityError': (context) => errorScreen(title: "Сори мы только в Киеве"),
    '/': (context) => SignInTabs(),
  };
  MyApp({this.isLogged, this.area});

  @override
  Widget build(BuildContext context) {
    print(area);
    final initialRoute = (area != "Kyiv City") 
                          ? "/cityError" 
                          :  isLogged 
                            ? "/restaurants" 
                            : "/";
    
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child:MaterialApp(
          debugShowCheckedModeBanner: false, // потом удалим
          title: 'Nivo',
          theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: initialRoute,
          routes: routes
        )
      );
  }
}
