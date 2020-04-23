import 'package:flutter/material.dart';
import 'package:nivo/widgets/MainAppbar/MainAppbar.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PrimaryPage extends StatefulWidget {

  @override
  _PrimaryPageStated createState() => _PrimaryPageStated();
}

class _PrimaryPageStated extends State<PrimaryPage> {

  @override
  void initState(){
    super.initState();
     _getUrl();
  }

  void _getUrl() async {
    final url = await FirebaseStorage.instance.ref().child("a625bp7ockiajcbsl7uj.png").getDownloadURL();
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Welcome'),
              onTap: () => {},
            ),
          ],
        ),
      ),
      appBar: MainAppbar(),
      body: Center(
        child: Text('Primary page'),
      ),
    );
  }
}
