import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import './screens/login.dart';
import './screens/primary.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isLogged() async {
    try {
      final FirebaseUser user = await _firebaseAuth.currentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    final Auth _auth = Auth();
    final bool isLogged = await _auth.isLogged();
    final MyApp myApp = MyApp(
      initialRoute: isLogged ? '/restaurants' : '/',
    );
    runApp(myApp);
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // потом удалим
      title: 'Nivo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: initialRoute,
      routes: {
        '/restaurants': (context) => PrimaryPage(),
        '/': (context) => SignInTabs(),
      },
    );
  }
}
