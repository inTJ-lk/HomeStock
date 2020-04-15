import 'package:flutter/material.dart';
import 'package:home_stock/models/item.dart';

class ItemTile extends StatelessWidget {

  final Item item;

  ItemTile({this.item});

  @override
  Widget build(BuildContext context) {

    void _showEditItemPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Text('Edit Item'),
        );
      });
    } 

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 0.0),
        child: ListTile(
          title: Text('${item.name} - ${item.quantity}${item.metric}'),
          trailing: PopupMenuButton<Choice>(
                      onSelected: (value) {_showEditItemPanel();},
                      itemBuilder: (BuildContext context) {
                        return choices.map((Choice choice) {
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
  const Choice(title: 'Edit'),
  const Choice(title: 'Remove'),
];
