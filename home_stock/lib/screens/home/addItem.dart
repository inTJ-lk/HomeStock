// import 'package:employee_activity_tracker/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/services/database.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  final _formKey = GlobalKey<FormState>();
  final List<String> categories = ['Fresh Food', 'Dry Food', 'Grocery', 'Household', 'Other'];
  final List<String> metrics = ['Grams', 'Kilograms', 'Milliliters', 'Liters', 'Packets', 'Tins', 'Other'];

  String _name;
  String _category;
  String _metric;
  int _quantity;

  @override
  Widget build(BuildContext context) {

    // Authprovider is not used so that once a user is directed to someone elses item list(Family)
    // User can update the directed document rather than the document under uders own id
    // Stream provider is used to wrap the addItem widget under home widget
    final listForUser = Provider.of<UserData>(context);

    _category = _category ?? categories[0];
    _metric = _metric ?? metrics[0];

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Add Item',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(hintText: 'Item Name'),
            validator: (val) => val.isEmpty ? 'Please enter a Name' : null,
            onChanged: (val) => setState(() => _name = val),
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
            value: _category ?? categories[0],
            items: categories.map((item){
              return DropdownMenuItem(
                value: item,
                child: Text('$item'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _category = val),
          ),
          DropdownButtonFormField(
            value: _metric ?? metrics[0],
            items: metrics.map((item){
              return DropdownMenuItem(
                value: item,
                child: Text('$item'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _metric = val),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(hintText: 'Quantity'),
            keyboardType: TextInputType.number,
            validator: (val) => val.isEmpty ? 'Please enter Quantity' : null,
            onChanged: (val) => setState(() => _quantity = int.parse(val)),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.blue,
            child: Text(
              'Add Item',
              style: TextStyle(color: Colors.white)
            ),
            onPressed: () async {
              if(_formKey.currentState.validate()){
                await DatabaseService(uid: listForUser.uid).updateItemData(_name, _category, _quantity, _metric, 0);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}