// import 'package:employee_activity_tracker/shared/loading.dart';
import 'package:flutter/material.dart';

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
  String _quantity;

  @override
  Widget build(BuildContext context) {

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
            initialValue: 'Name',
            validator: (val) => val.isEmpty ? 'Please enter a Name' : null,
            onChanged: (val) => setState(() => _name = val),
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
            value: categories[0],
            items: categories.map((item){
              return DropdownMenuItem(
                value: item,
                child: Text('$item'),
              );
            }).toList(),
            onChanged: (value) {},
          ),
          DropdownButtonFormField(
            value: metrics[0],
            items: metrics.map((item){
              return DropdownMenuItem(
                value: item,
                child: Text('$item'),
              );
            }).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 20.0),
          TextFormField(
            initialValue: 'Quantity',
            validator: (val) => val.isEmpty ? 'Please enter Quantity' : null,
            onChanged: (val) => setState(() => _quantity = val),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.blue,
            child: Text(
              'Add Item',
              style: TextStyle(color: Colors.white)
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}