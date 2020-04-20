import 'package:flutter/material.dart';
import 'package:home_stock/models/item.dart';
import 'package:provider/provider.dart';
import 'itemTile.dart';

List items = [
  Item(name: 'Beans', category : 'Fresh Food', metric: 'Kilograms', quantity: 1, inShoppingList: 0),
  Item(name: 'Carrots', category : 'Fresh Food', metric: 'Kilograms', quantity: 2, inShoppingList: 0),
];

class ItemList extends StatefulWidget{

  final String type;

  ItemList({this.type});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList>{

  @override
  Widget build(BuildContext context){

    // DocumentSnapshot i = Provider.of<DocumentSnapshot>(context) ?? [];
    // Item list is retrieved from the provider
    List<Item> i = Provider.of<List<Item>>(context) ?? [];

    // if the passed type to the item list is not equal to All
    // item list is filtered according to the selected category 
    // else the list is not filtered hence items from all the categories will be displayed
    if(widget.type != 'All' ){
      i = i.where((item) => item.category == widget.type).toList();
    }

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
            itemCount: i.length,
            itemBuilder: (context, index) {
              return ItemTile(item: i[index]);
            },
          ),
        ),
      ],
    );
  }
}