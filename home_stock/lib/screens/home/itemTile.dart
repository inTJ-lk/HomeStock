import 'package:flutter/material.dart';
import 'package:home_stock/models/item.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/screens/home/editItem.dart';
import 'package:home_stock/services/database.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {

  final Item item;

  ItemTile({this.item});

  @override
  Widget build(BuildContext context) {

    final listForUser = Provider.of<UserData>(context);

    void _showEditItemPanel(value){
      showModalBottomSheet(context: context, isScrollControlled: true ,builder: (context){
        if(value.title == 'Edit'){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                StreamProvider<UserData>.value(
                  value: DatabaseService(uid: listForUser.uid).userData,
                  child: EditItem(item: item)
                ),
              ],
            ),
          );
        }else if(value.title == 'Add to Shopping List'){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Text('Add to Shopping List'),
          );
        }else{
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Text('Remove'),
          );
        }
        
      });
    } 

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 0.0),
        child: ListTile(
          title: Text('${item.name} - ${item.quantity} ${item.metric}'),
          trailing: PopupMenuButton<Choice>(
                      onSelected: (value) {_showEditItemPanel(value);},
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
