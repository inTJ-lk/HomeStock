import 'package:flutter/material.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/services/auth.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final listForUser = Provider.of<UserData>(context);

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
              subtitle: Text(user.email),
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
                  onTap: (){print('fuck');},
                ),
                Divider(color: Colors.black),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Change Password'),
                ),
                Divider(color: Colors.black),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Clear Data'),
                ),
                Divider(color: Colors.black),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share Inventory')
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