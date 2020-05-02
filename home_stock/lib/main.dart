import 'package:flutter/material.dart';

import 'package:home_stock/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: Wrapper(),
      ),
    );
  }
}