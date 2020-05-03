import 'package:flutter/material.dart';
import 'package:home_stock/screens/shared/loading.dart';
import 'package:home_stock/services/database.dart';
import 'package:home_stock/screens/shared/systemPadding.dart';

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

  bool loading = false;

  int _quantity;  

  @override
  Widget build(BuildContext context) {

    void _showFailedPanel(){
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Failed Modify Stock',
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

    return loading ? Loading() :SystemPadding(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Form(
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
                    hintText: 'Quantity',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (val) => val.isEmpty || (widget.title == 'Destock' && widget.quantity < int.parse(val)) ? 'Please enter correct Quantity' : null,
                  onChanged: (val) => {setState(() => _quantity = int.parse(val))},
                ),
                SizedBox(height: 12.0),
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
                if(_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  if(widget.title == 'Restock'){
                    _quantity = widget.quantity + _quantity;
                  }
                  else{
                    _quantity = widget.quantity - _quantity;
                  }
                  dynamic result = await DatabaseService(uid: widget.uid).updateStock(widget.name, _quantity);
                  if(result == null){
                    setState(() {
                      loading = false;
                    });
                    Navigator.of(context).pop();
                  }
                  else{
                    setState(() {
                      loading = false;
                    });
                    Navigator.of(context).pop();
                    _showFailedPanel();
                    //action for when the db function fails
                  }
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}