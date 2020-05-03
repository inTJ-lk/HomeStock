import 'package:flutter/material.dart';
import 'package:home_stock/models/item.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/screens/home/itemTile.dart';
import 'package:home_stock/services/database.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  String _searchString;

  @override
  Widget build(BuildContext context) {

    final listForUser = Provider.of<UserData>(context);

    List<Item> items = Provider.of<List<Item>>(context) ?? [];
    List<Item> processedItems = items.isNotEmpty ? items.where((i) => i.inShoppingList == 1).toList() : 0;

    _searchString = _searchString ?? null;

    if(_searchString != null && processedItems.isNotEmpty){
      processedItems = processedItems.where((item) => item.name.toLowerCase().contains(_searchString.toLowerCase())).toList();
    }

    return new GestureDetector(
      onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: Text('Shopping List'),
        ),
        body: processedItems.length != 0 ? Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 8.0, 50.0, 8.0),
                    child: TextFormField(
                      onChanged: (value){
                        setState(() {
                          _searchString = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search'
                      ),
                    )
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: processedItems.length,
                      itemBuilder: (context, index) {
                        return StreamProvider<UserData>.value(
                          value: DatabaseService(uid: listForUser.items).userData,
                          child: ItemTile(item: processedItems[index]));
                      },
                    ),
                  ),
                ],
              ) : Container(
                child: Center(child: Text('No items in Shopping List')),
              )
      ),
    );
  }
}