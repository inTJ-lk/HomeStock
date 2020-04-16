import 'package:flutter/material.dart';
import 'package:home_stock/screens/home/addItem.dart';
import 'package:home_stock/screens/home/itemList.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    void _showAddItemPanel(){
      showModalBottomSheet(context: context,isScrollControlled: true, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AddItem(),
            ],
          ),
        );
        
      });
    }    

    return Scaffold(
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
              onPressed: () {},
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