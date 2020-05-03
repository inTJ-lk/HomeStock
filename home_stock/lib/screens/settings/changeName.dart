import 'package:flutter/material.dart';
import 'package:home_stock/screens/shared/loading.dart';
import 'package:home_stock/services/auth.dart';
import 'package:home_stock/screens/shared/systemPadding.dart';

class ChangeName extends StatefulWidget {
  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {

  final AuthService _auth = AuthService();
  final _formKey1 = GlobalKey<FormState>();
  bool loading = false;

  String name = "";

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
                'Name Changed Successfully',
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
                'Failed To Change Name',
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
                'Change Name',
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
                      'Enter Name',
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                    validator: (val) => val.isEmpty ? 'Enter name' : null,                    
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                  ),
                  SizedBox(height: 50.0),
                ]
                ),
              ),
              RaisedButton(
                color: Colors.blue[800],
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async {
                  if(_formKey1.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.changeName(name);
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