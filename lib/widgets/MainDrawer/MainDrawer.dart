import 'package:flutter/material.dart';
import 'package:nivo/widgets/MainDrawer/DrawerMenuItem.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
            child: Column(
      children: <Widget>[
        DrawerMenuItem(
            icon: Icons.home,
            title: "На главную",
            onTap: () => Navigator.pushNamed(context, '/restaurants')),
        DrawerMenuItem(
            icon: Icons.shopping_basket,
            title: "Мои заказы",
            onTap: () => Navigator.pushNamed(context, '/orders')),
        DrawerMenuItem(
            icon: Icons.exit_to_app,
            title: "Выйти из аккаунта",
            onTap: () => Navigator.pushNamed(context, '/restaurants')),
      ],
    )));
  }
}
