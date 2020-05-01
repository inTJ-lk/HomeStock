import 'package:flutter/material.dart';
import 'package:home_stock/models/item.dart';
import 'package:home_stock/models/notification.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/screens/home/itemTile.dart';
import 'package:home_stock/screens/settings/shareInventory.dart';
import 'package:home_stock/services/database.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final listForUser = Provider.of<UserData>(context);


    //List<Item> items = Provider.of<List<Item>>(context) ?? [];
    List<FirestoreNotification>notifications = [
      FirestoreNotification(timestamp: 'timestamp', title: 'title', message: 'message'),
      FirestoreNotification(timestamp: 'timestamp', title: 'Share Request', message: 'message')


    return new GestureDetector(
      onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(notifications[index].title),
                      subtitle: notifications[index].title == 'Share Request' ? Text(notifications[index].message) : Text('Tis a request'),
                      onTap: notifications[index].title == 'Share Request' ? () async{
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => 
                        StreamProvider<List<Item>>.value(
                          value: DatabaseService(uid: listForUser.items).itemData,
                          child: StreamProvider<UserData>.value(
                            value: DatabaseService(uid: listForUser.email).userData,
                            child: ShareInventory()
                          )
                        )
                      ),
                    );
                  } : () {print('notification clicked');},
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}