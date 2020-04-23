import 'package:flutter/material.dart';


class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;  
  final Widget child;  
  final Function onPressed;  
  final Function onTitleTapped;  
 
  @override 
  final Size preferredSize;   
  MainAppbar({this.title, 
    this.child, 
    this.onPressed, 
    this.onTitleTapped})
    : preferredSize = Size.fromHeight(80.0);
  
  @override 
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
      decoration: BoxDecoration(
           color: Colors.redAccent,
           boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 15.0,
              spreadRadius: 5.0,
              offset: new Offset(0.0, 0.0),
            )
          ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child:Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            ), 
          onPressed: () => {
            Scaffold.of(context).openDrawer()
          }
        ),
        Expanded(
          child: Text("Nivo",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
        ))),
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          onPressed:()=> {
            
          }
        )
        ]
      ),
      
      ));
  }
}
