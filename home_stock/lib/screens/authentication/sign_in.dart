import 'package:flutter/material.dart';
import 'package:home_stock/screens/shared/loading.dart';
import 'package:home_stock/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //text field state
  String email = "";
  String password = "";

  String error = "";

  @override
  Widget build(BuildContext context) {

    void _showResetPasswordDialog(){
      showDialog(context: context, barrierDismissible: true, builder: (context){
        return ResetPassword();       
      });
    }

    return  loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('HomeStock'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
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
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a password at least 6 charcters long' : null,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                InkWell(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 14.0,
                      decoration: TextDecoration.underline
                    ),
                  ),
                  onTap: () {
                    _showResetPasswordDialog();
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPasswors(email, password);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Error Signing In';
                        });
                      }
                    }
                  },
                  color: Colors.blue[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                SizedBox(height: 20.0),
                InkWell(
                  child: Text(
                    'Don\'t have an account? Register',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 16.0,
                      decoration: TextDecoration.underline
                    ),
                  ),
                  onTap: () {
                    widget.toggleView();
                  },
                )
              ],
              ),
          ),
        ),
      ),
    );
  }
}

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final AuthService _auth = AuthService();
  final _formKey1 = GlobalKey<FormState>();

  String email = "";
  String text = "";

  @override
  Widget build(BuildContext context) {

    void _showResetPasswordSuccess(){
      showDialog(context: context, barrierDismissible: true, builder: (context){
        return AlertDialog(
          title: Center(child: Text('Reset Password')),
          content: Text(
            'Password reset email sent. Use the link in the email to reset password',
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    }

    return AlertDialog(
          title: Center(child: Text('Reset Password')),
          content: Form(
            key: _formKey1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 12.0),
                Text(
                  'Enter email to reset password',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
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
          actions: <Widget>[
            FlatButton(
              child: Text('Reset'),
              onPressed: () async {
                if(_formKey1.currentState.validate()) {
                  dynamic result = await _auth.resetPassword(email);
                  print(result);
                  if(result == null) {
                    Navigator.of(context).pop();
                    _showResetPasswordSuccess();
                  }
                  else {
                    setState(() {
                        text = 'Error Resetting Password';
                    });
                  }
                }
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }
}