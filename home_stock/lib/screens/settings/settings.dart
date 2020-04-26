import 'package:flutter/material.dart';
import 'package:home_stock/models/item.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/screens/settings/shareInventory.dart';
import 'package:home_stock/screens/shared/systemPadding.dart';
import 'package:home_stock/services/auth.dart';
import 'package:home_stock/services/database.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final AuthService _auth = AuthService();
  final _formKey1 = GlobalKey<FormState>();

  String currentPassword = "";
  String newPassword = "";
  String text = "";
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final listForUser = Provider.of<UserData>(context);

    // Delete the whole inventory
    void _showClearItemPanel(){
      showModalBottomSheet(context: context, isScrollControlled: true ,builder: (context){
        return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Inventory data will be Permanently removed',
                  style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.red,
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    await DatabaseService(uid: listForUser.items).deleteInventory();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
      });
    }

    void _showChangePasswordPanel(){
      showModalBottomSheet(context: context, isScrollControlled: true ,builder: (context){
        return SystemPadding(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Column(
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
                        dynamic result = await _auth.changePassword(currentPassword,newPassword);
                        if(result == null) {
                          Navigator.of(context).pop();
                        }
                        else {
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
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Settings')),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pop(context);
            },
            label: Text('logout'),
          ),
      ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage('assets/user.png'),
              ),
              title: Text(listForUser.name.toUpperCase()),
              subtitle: Text(listForUser.email),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Account Settings',
            style: TextStyle(fontSize: 18.0),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Change Email'),
                  onTap: (){},
                ),
                Divider(color: Colors.black),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Change Password'),
                  onTap: (){_showChangePasswordPanel();}
                ),
                Divider(color: Colors.black),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Clear Data'),
                  onTap: (){_showClearItemPanel();},
                ),
                Divider(color: Colors.black),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share Inventory'),
                  onTap: () async{
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => 
                        StreamProvider<List<Item>>.value(
                          value: DatabaseService(uid: listForUser.items).itemData,
                          child: StreamProvider<UserData>.value(
                            value: DatabaseService(uid: listForUser.items).userData,
                            child: ShareInventory()
                          )
                        )
                      ),
                    );
                  },
                ),
                Divider(color: Colors.black),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help and Support')
                ),
              ],
            ),
          ),
          Text('Developed by inTJ Solutions'),
        ],
      ),
    );
  }
}