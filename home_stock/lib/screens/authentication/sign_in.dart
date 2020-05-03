import 'package:flutter/material.dart';
import 'package:home_stock/screens/authentication/forgotPassword.dart';
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

    void _showResetPasswordPanel(){
      showModalBottomSheet(context: context, isScrollControlled: true ,builder: (context){
        return ForgotPassword();
      });
    }

    return  loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0.0,
        title: Text('HomeStock'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Image(image: AssetImage('assets/homestockLogo.png')),
              Form(
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
                        _showResetPasswordPanel();
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
                      color: Colors.blue[800],
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
            ],
          ),
        ),
      ),
    );
  }
}