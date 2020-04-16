import 'package:flutter/material.dart';
import 'package:home_stock/screens/authentication/authenticate.dart';
import 'package:home_stock/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:home_stock/models/user.dart';

class Wrapper extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //return either home or authenticate widget
    if(user == null) {
      return Authenticate();
    }
    else{
      return Container(
        child: FlatButton.icon(
          onPressed: () async {
            await _auth.signOut();
          }, 
          icon: Icon(Icons.person), 
          label: Text('logout', style: TextStyle(color: Colors.white),)
        )
      );
    }
  }
}