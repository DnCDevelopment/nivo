import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../services/auth.dart';

class Registration extends StatefulWidget {

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _email, _error, _name, _password;
  final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();

  final BaseAuth auth = Auth();

  Future<void> _signUp() async {
    setState(() {
      _error = '';
    });
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult result = await auth.signUp(_email, _password);
        final String uid = result.user.uid;
        Firestore.instance.collection('users').document(uid).setData(
          {'name': _name, 'orders': ''}
        );
      } on PlatformException catch(err) {
        setState(() {
          _error = err.message;
        });
      } catch (err) {
          _error = err.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            TextFormField(
              validator: (value) => value.isEmpty ? 'Please type your name' : null,
              onSaved: (value) => _name = value,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              validator: (value) => value.isEmpty ? 'Please type your email' : null,
              onSaved: (value) => _email = value,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              validator: (value) => value.length < 6 ? 'Your password needs to be atleast 6 characters' : null,
              onSaved: (value) => _password = value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
             Text(
              _error != null && _error != '' ? _error : '',
              style: TextStyle(color: Colors.red), 
            ),
            RaisedButton(
              onPressed: _signUp,
              child: Text('Sign up'),
            )
          ],
        )
      ),
    );
  }
}
