import 'package:flutter/material.dart';
import 'package:home_stock/screens/shared/loading.dart';
import 'package:home_stock/services/auth.dart';
import 'package:home_stock/screens/shared/systemPadding.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final AuthService _auth = AuthService();
  final _formKey1 = GlobalKey<FormState>();
  bool loading = false;

  String currentPassword = "";
  String newPassword = "";
  String text = "";

  @override
  Widget build(BuildContext context) {
    return  loading ? Loading() : SystemPadding(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Change Password',
                    style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Form(
                    key: _formKey1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Text(
                          'Enter Current Password',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Current Password',
                        ),
                        obscureText: true,
                        validator: (val) => val.length < 6 ? 'Enter a password at least 6 charcters long' : null,
                        onChanged: (val) {
                          setState(() {
                            currentPassword = val;
                            text = "";
                          });
                        },
                      ),
                      SizedBox(height: 50.0),
                        Text(
                          'Enter New Password',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                        decoration: InputDecoration(
                          hintText: 'New Password',
                        ),
                        obscureText: true,
                        validator: (val) => val.length < 6 ? 'Enter a password at least 6 charcters long' : null,
                        onChanged: (val) {
                          setState(() {
                            newPassword = val;
                            text = "";
                          });
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        text,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ]
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white)
                    ),
                    onPressed: () async {
                      if(_formKey1.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.changePassword(currentPassword,newPassword);
                        if(result == null) {
                          setState(() {
                            loading = false;
                          });
                          Navigator.of(context).pop();
                        }
                        else {
                          setState(() {
                            loading = false;
                          });
                          print('error');
                          setState(() {
                              text = 'Error Resetting Password';
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
        );
  }
}