import 'package:flutter/material.dart';

import '../widgets/signIn/Registation.dart';
import '../widgets/signIn/signIn.dart';

class SignInTabs extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Log in'),
                Tab(text: 'Registration'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SignIn(),
              Registration()
            ],
          ),
        ),
      ),
    );
  }
}
