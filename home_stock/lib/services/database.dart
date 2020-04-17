import 'package:home_stock/models/item.dart';
import 'package:home_stock/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference itemCollection = Firestore.instance.collection('items');

  Future updateUserData(String name) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'items': uid
    });
  }

  Future createItemCollection() async {
    return await itemCollection.document(uid).setData({
      'Test Item': {'name':'Test Item', 'category': 'Fresh Food', 'metric': 'Kilograms', 'quantity': 2, 'inShoppingList': 0}
    });
  }

  List<Item> _itemDataFromSnapshot(DocumentSnapshot snapshot){
    try{
      Map<String, dynamic> myMap = new Map<String, dynamic>.from(snapshot.data);

      List<Item> li = new List<Item>();
      myMap.forEach((k,v) => {
        li.add(Item(name: v['name'], category: v['category'], quantity: v['quantity'], metric: v['metric'], inShoppingList: v['inShoppingList'])),
      });

      return li;
      // return null;
    }catch(e){
      print('pops ${e.toString()}');
      return null;
    }
    
    
  }

  // Stream to get user data from users collection
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots().map((item){
      return UserData(name: item.data['name'], uid: uid, items: item.data['items']);
    });
  }

  // Stream to get item data of a user from items collection
  Stream <List<Item>> get itemData{
    return itemCollection.document(uid).snapshots().map(_itemDataFromSnapshot);
  }

  Future updateItemData(String name, String category, int quantity, String metric, int inShoppingList) async{
    return await itemCollection.document(uid).updateData({
      name: {'name': name, 'category': category, 'metric': metric, 'quantity': quantity, 'inShoppingList': 0}
    });
  }

}