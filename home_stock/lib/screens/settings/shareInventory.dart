import 'package:flutter/material.dart';

class ShareInventory extends StatefulWidget {
  @override
  _ShareInventoryState createState() => _ShareInventoryState();
}

class _ShareInventoryState extends State<ShareInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Share Inventory')),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          // SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(7.0, 7.0, 7.0, 0),
            child: Text(
              'Share your inventory with Family/Friends. They will be able to add and modify items and will receive notifications when the item quantity is nil.',
              style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(7.0, 7.0, 7.0, 0),
            child: Text(
              'Enter the email address of the person to share the inventory with. Make sure they have installed HomeStock and registered to the system. Inventory will be shared once they accept the invitation.',
              style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left
            ),
          ),
          Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 8.0, 50.0, 8.0),
            child: TextFormField(
              autofocus: false,
              // onChanged: (value){setState(() {
              //   _searchString = value;
              // });},
              decoration: InputDecoration(
                hintText: 'Enter Email',
              ),
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
              // if(_formKey.currentState.validate()){
              //   await DatabaseService(uid: listForUser.items).updateItemData(_name, _category, _quantity, _metric, 0);
              //   Navigator.pop(context);
              // }
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