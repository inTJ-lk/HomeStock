import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_stock/models/item.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/screens/home/addItem.dart';
import 'package:home_stock/screens/home/itemList.dart';
import 'package:home_stock/screens/settings/settings.dart';
import 'package:home_stock/screens/shared/loading.dart';
import 'package:home_stock/screens/shoppingList/shoppingList.dart';
import 'package:home_stock/services/database.dart';
import 'package:home_stock/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  // type stores the category of the item selected to sort 
  // initial value is 'All' where all categories are shown
  String _type;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // Maps the user with the assigned list 
    // Auth user is not used as there can be many users mapped to the same item list
    final listForUser = Provider.of<UserData>(context);

    // Gets the new share requests to generate the badge count
    var notifications = listForUser != null ? listForUser.shared.where((i) => i['status'] == 'request'): 0;

    // When built is called repeatedly if type is not set(initial load) type is set to All
    _type = _type ?? 'All';

    // Add item panel to add a new item to the list of items
    // Bottom sheet modal is used to display the form
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

    return listForUser != null ? StreamProvider<List<Item>>.value(
      value: DatabaseService(uid: listForUser.items).itemData,
      child: new GestureDetector(
        onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[800],
            title: Text('HomeStock'),
            centerTitle: true,
            elevation: 0.0,
            // leading: PopupMenuButton<Choice>(
            //   // gets the index of the selected category to highlight the category
            //   initialValue: choices[choices.indexWhere((item) => item.title == _type)],
            //   onSelected: (value) {setState(() {
            //     _type = value.title;
            //   });},
            //   itemBuilder: (BuildContext context) {
            //     return choices.map((Choice choice) {
            //       return PopupMenuItem<Choice>(
            //         value: choice,
            //         child: Text(choice.title),
            //       );
            //     }).toList();
            //   }
            // ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
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
                icon: notifications.length != 0 ? Badge(
                  badgeContent: Text(notifications.length.toString()),
                  child: Icon(Icons.settings),
                ) : Icon(Icons.settings),
                tooltip: 'Settings',
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => 
                      StreamProvider<UserData>.value(
                        value: DatabaseService(uid: listForUser.uid).userData,
                        child: Settings()
                      )
                    ),
                  );
                },
              ),
            ],
          ),
          // Type is passed to the item list to get the relavant category 
          body: ItemList(type: _type),
          drawer: Drawer(
            child: ListView.builder(
              itemCount: choices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.blue[800],
                    backgroundImage: AssetImage('assets/${choices[index].title.split(" ")[0]}.png'),
                  ),
                  title: Text(choices[index].title, style: TextStyle(fontSize: 17.0, fontWeight: choices[index].title == _type ? FontWeight.bold : null),),
                  subtitle: Text("  "),
                  selected: choices[index].title == _type ? true : false,
                  onTap: (){
                    setState(() {
                    _type = choices[index].title;
                    });
                    Navigator.pop(context);
                  },
                  
                );
              }
            )
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showAddItemPanel();
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue[800],
          ), 
        ),
      ),
    ) : Loading();
  }
}

class Choice {
  const Choice({this.title});

  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'All'),
  const Choice(title: 'Fresh Food'),
  const Choice(title: 'Dry Food'),
  const Choice(title: 'Grocery'),
  const Choice(title: 'Household'),
  const Choice(title: 'Other'),
];