import 'package:flutter/material.dart';
import 'package:home_stock/screens/shared/loading.dart';
import 'package:home_stock/services/auth.dart';
import 'package:home_stock/screens/shared/systemPadding.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final AuthService _auth = AuthService();
  final _formKey1 = GlobalKey<FormState>();
  bool loading = false;

  String email = "";

  @override
  Widget build(BuildContext context) {

    void _showSuccessPanel(){
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Password reset email sent. Use the link in the email to reset password',
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue[800],
                child: Text(
                  'Dismiss',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
    }

    void _showFailedPanel(){
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Failed To send password reset email. Please enter a valid email address registered on HomeStock and make sure you have a stable internet connection.',
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue[800],
                child: Text(
                  'Dismiss',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
    }

    return  loading ? Loading() : SystemPadding(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Form(
                    key: _formKey1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 12.0),
                      Text(
                        'Enter your account email to reset password',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.0),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height: 12.0),
                      ]
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue[800],
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white)
                    ),
                    onPressed: () async {
                      if(_formKey1.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.resetPassword(email);
                        if(result == null) {
                          setState(() {
                            loading = false;
                          });
                          Navigator.of(context).pop();
                          _showSuccessPanel();
                        }
                        else {
                          setState(() {
                            loading = false;
                          });
                          Navigator.of(context).pop();
                          _showFailedPanel();
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