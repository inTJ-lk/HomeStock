import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_stock/models/item.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/screens/home/addItem.dart';
import 'package:home_stock/screens/home/itemList.dart';
import 'package:home_stock/screens/shoppingList/shoppingList.dart';
import 'package:home_stock/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final listForUser = Provider.of<UserData>(context);

    void _showAddItemPanel(){
      showModalBottomSheet(context: context,isScrollControlled: true, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              StreamProvider<UserData>.value(
                value: DatabaseService(uid: listForUser.uid).userData,
                child: AddItem()
              ),
            ],
          ),
        );
        
      });
    }    

    return StreamProvider<List<Item>>.value(
      value: DatabaseService(uid: listForUser.items).itemData,
      child: Scaffold(
        appBar: AppBar(
          title: Text('HomeStock'),
          centerTitle: true,
          elevation: 0.0,
          leading: PopupMenuButton<Choice>(
            onSelected: null,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            }
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_basket),
              tooltip: 'Shopping List',
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => 
                    StreamProvider<List<Item>>.value(
                      value: DatabaseService(uid: listForUser.items).itemData,
                      child: StreamProvider<UserData>.value(
                        value: DatabaseService(uid: listForUser.items).userData,
                        child: ShoppingList()
                      )
                    )
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {},
            ),
          ],
        ),
        body: ItemList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddItemPanel();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
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
  const Choice(title: 'Fresh Food'),
  const Choice(title: 'Dry Food'),
  const Choice(title: 'Grocery'),
  const Choice(title: 'Household'),
  const Choice(title: 'Other'),
  // const Choice(title: 'Walk', icon: Icons.directions_walk),
];