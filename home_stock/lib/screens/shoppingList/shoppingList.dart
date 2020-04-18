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
  @override
  Widget build(BuildContext context) {

    final listForUser = Provider.of<UserData>(context);

    List<Item> items = Provider.of<List<Item>>(context) ?? [];
    List<Item> processedItems = items.where((i) => i.inShoppingList == 1).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 8.0, 50.0, 8.0),
                  child: TextFormField(
                    onChanged: null,
                    decoration: InputDecoration(
                      hintText: 'Search'
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: processedItems.length,
                    itemBuilder: (context, index) {
                      return StreamProvider<UserData>.value(
                        value: DatabaseService(uid: listForUser.uid).userData,
                        child: ItemTile(item: processedItems[index]));
                    },
                  ),
                ),
              ],
            ),
    );
  }
}