import 'package:flutter/material.dart';
import 'package:home_stock/models/user.dart';
import 'package:provider/provider.dart';

class ShareInventory extends StatefulWidget {
  @override
  _ShareInventoryState createState() => _ShareInventoryState();
}

class _ShareInventoryState extends State<ShareInventory> {

  String _email;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final listForUser = Provider.of<UserData>(context);

    _email = _email ?? "";

    bool validateEmail(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (regex.hasMatch(value))
        return true;
      else
        return false;
    }

    void _showConfirmationPanel(email){
      showModalBottomSheet(context: context, isScrollControlled: true ,builder: (context){
        if(validateEmail(email) == true){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Share Inventory with $email?',
                  style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Share',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    // await DatabaseService(uid: listForUser.items).deleteInventory();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }else{
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Invalid email address $email, Make sure the email is registered with the system',
                  style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Dismiss',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    // await DatabaseService(uid: listForUser.items).deleteInventory();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
        
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Share Inventory')),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          // SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(7.0, 0, 7.0, 0),
            child: Text(
              'Share your inventory with Family/Friends to let them modify & receive notifications when quantity is nil.',
              style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(7.0, 0, 7.0, 0),
            child: Text(
              'Enter the email address of the person to request to share the inventory. Make sure they have installed HomeStock and registered to the system.',
              style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left
            ),
          ),
          Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 8.0),
            child: TextFormField(
              autofocus: false,
              onChanged: (value){setState(() {
                _email = value;
              });},
              decoration: InputDecoration(
                hintText: 'Enter Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.blue,
            child: Text(
              'Share',
              style: TextStyle(color: Colors.white)
            ),
            onPressed: () async {
              _showConfirmationPanel(_email);
            },
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage('assets/user.png'),
                    ),
                    title: Text('Tharinda Dilshan'),
                    subtitle: Text('tharindad7@gmail.com'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){},
                    ),
                  ),
                ),
              ]
            )
          ),
        ],
      ),
      
    );
  }
}