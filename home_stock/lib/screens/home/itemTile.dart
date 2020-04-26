import 'package:flutter/material.dart';
import 'package:home_stock/models/item.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/screens/home/editItem.dart';
import 'package:home_stock/screens/home/updateStock.dart';
import 'package:home_stock/services/database.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {

  final Item item;


  ItemTile({this.item});

  @override
  Widget build(BuildContext context) {

    final listForUser = Provider.of<UserData>(context);

    void _showStockingPanel(String title, String uid){
      showModalBottomSheet(context: context, isScrollControlled: true ,builder: (context){
        return UpdateStock(title: title, name: item.name, quantity: item.quantity, uid: uid, metric: item.metric,);
      });
    }

    void _showEditItemPanel(value){
      showModalBottomSheet(context: context, isScrollControlled: true ,builder: (context){
        if(value.title == 'Edit'){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                StreamProvider<UserData>.value(
                  value: DatabaseService(uid: listForUser.items).userData,
                  child: EditItem(item: item)
                ),
              ],
            ),
          );
        }else if(value.title == 'Add to Shopping List'){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Add Item to Shopping List?',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    int val = item.inShoppingList == 1 ? 0 : 1;
                    await DatabaseService(uid: listForUser.items).addOrRemoveFromShoppingList(item.name, val);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }else if(value.title == 'Remove from Shopping List'){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Remove Item from Shopping List?',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.red,
                  child: Text(
                    'Remove',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    int val = item.inShoppingList == 1 ? 0 : 1;
                    await DatabaseService(uid: listForUser.items).addOrRemoveFromShoppingList(item.name, val);
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
                  'Delete Item?',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.red,
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    await DatabaseService(uid: listForUser.items).deleteItem(item.name);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
        
      });
    } 

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 0.0),
        child: ListTile(
          title: Center(
            child: Text(
              '${item.name} - ${item.quantity} ${item.metric}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              FlatButton.icon(
                onPressed: () {_showStockingPanel('Restock',listForUser.items);}, 
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green[400],
                  size: 30,
                ), 
                label: Text('Restock')
              ),
              FlatButton.icon(
                onPressed: () {_showStockingPanel('Destock',listForUser.items);}, 
                icon: Icon(
                  Icons.do_not_disturb_on,
                  color: Colors.red[400],
                  size: 30,
                ), 
                label: Text('Destock')
              ),
            ],
          ),
          trailing: PopupMenuButton<Choice>(
            onSelected: (value) {_showEditItemPanel(value);},
            itemBuilder: item.inShoppingList == 0 ? (BuildContext context) {
              return choices.where((i) => i.title != 'Remove from Shopping List').toList().map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            } : (BuildContext context) {
              return choices.where((i) => i.title != 'Add to Shopping List').toList().map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            }
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title});

  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Add to Shopping List'),
  const Choice(title: 'Remove from Shopping List'),
  const Choice(title: 'Edit'),
  const Choice(title: 'Delete'),
];
