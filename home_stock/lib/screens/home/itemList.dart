import 'package:flutter/material.dart';
import 'package:home_stock/models/item.dart';
import 'itemTile.dart';

List items = [
  Item(name: 'Beans', category : 'Fresh Food', metric: 'Kg', quantity: 1),
  Item(name: 'Carrots', category : 'Fresh Food', metric: 'Kg', quantity: 2),
];

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    
    return Column(
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
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemTile(item: items[index]);
            },
          ),
        ),
      ],
    );
  }
}