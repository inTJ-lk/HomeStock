import 'package:flutter/material.dart';
import 'package:home_stock/services/database.dart';

class UpdateStock extends StatefulWidget {

  final String title;
  final String name;
  final String uid;
  final String metric;
  final int quantity;

  UpdateStock({this.title, this.name, this.uid, this.quantity, this.metric});

  @override
  _UpdateStockState createState() => _UpdateStockState();
}

class _UpdateStockState extends State<UpdateStock> {

  final _formKey = GlobalKey<FormState>();

  int _quantity;
  String error = "";
  

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
          title: Center(child: Text(widget.title)),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 12.0),
                Text(
                  'Enter quantity (in ${widget.metric}) to ${widget.title}',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                SizedBox(height: 12.0),
                TextFormField(
                decoration: InputDecoration(
                  hintText: 'Qty',
                ),
                keyboardType: TextInputType.number,
                validator: (val) => val.isEmpty || (widget.title == 'Destock' && widget.quantity < int.parse(val)) ? 'Please enter correct Quantity' : null,
                onChanged: (val) => {setState(() => _quantity = int.parse(val))},
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ]
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () async {
                if(_formKey.currentState.validate()) {
                  if(widget.title == 'Restock'){
                    _quantity = widget.quantity + _quantity;
                  }
                  else{
                    _quantity = widget.quantity - _quantity;
                  }
                  print(_quantity);
                  print(widget.uid);
                  print(widget.name);
                  await DatabaseService(uid: widget.uid).updateStock(widget.name, _quantity);
                  Navigator.of(context).pop();
                }
              }
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