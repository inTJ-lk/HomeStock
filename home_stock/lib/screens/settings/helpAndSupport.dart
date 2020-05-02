import 'package:flutter/material.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/screens/shared/loading.dart';
import 'package:home_stock/services/database.dart';
import 'package:provider/provider.dart';

class HelpAndSupport extends StatefulWidget {
  @override
  _HelpAndSupportState createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title:Text('Help and Support'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 30.0),
            // SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(7.0, 0, 7.0, 0),
              child: Text(
                'HomeStock will help you manage and keep track of your home supplies',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(7.0, 0, 7.0, 0),
              child: Text(
                '',
                style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(height: 10.0),
          ],
        ),
        
      );
  }
}