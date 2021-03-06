import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:home_stock/models/item.dart';
import 'package:home_stock/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference itemCollection = Firestore.instance.collection('items');

  Future updateUserData(String name, String email) async {
    return await userCollection.document(email).setData({
      'name': name,
      'items': email,
      'email': email,
      'shared': [],
    });
  }

  Future createItemCollection(String email) async {
    return await itemCollection.document(email).setData({
      'Test Item': {'name':'Test Item', 'category': 'Fresh Food', 'metric': 'Kilograms', 'quantity': 1, 'inShoppingList': 0}
    });
  }

  // Item snapshot is converted into a list of item objects 
  // For each used instead of map as map did not work 
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
    try{
      return userCollection.document(uid).snapshots().map((item){
        return UserData(name: item.data['name'], uid: uid, items: item.data['items'], email: item.data['email'], shared: item.data['shared']);
      });
    }catch(e){
      return null;
    }
    
  }

  // Stream to get item data of a user from items collection
  Stream <List<Item>> get itemData{
    try{
      return itemCollection.document(uid).snapshots().map(_itemDataFromSnapshot);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Function to add and update item data
  Future updateItemData(String name, String category, int quantity, String metric, int inShoppingList) async{
    try{
      return await itemCollection.document(uid).updateData({
        name: {'name': name, 'category': category, 'metric': metric, 'quantity': quantity, 'inShoppingList': inShoppingList}
      });
    }catch(e){
      if(e.toString().contains('No document to update')){
        return await itemCollection.document(uid).setData({
          name: {'name': name, 'category': category, 'metric': metric, 'quantity': quantity, 'inShoppingList': inShoppingList}
        });
      }
    }
    
  }

  // Function to delete an item from a document
  Future deleteItem(String name) async{
    try{
      bool result = await DataConnectionChecker().hasConnection;
      if(result != true) {
        return 'Connection failed';
      } 
      return await itemCollection.document(uid).updateData({
        name: FieldValue.delete()
      });
    }catch(e){
      print(e.toString());
    }
  }

  // Add or Remove item from shopping list
  Future addOrRemoveFromShoppingList(String name, int val) async{
    try{
      bool result = await DataConnectionChecker().hasConnection;
      if(result != true) {
        return 'Connection failed';
      } 

      return await itemCollection.document(uid).updateData({
        '$name.inShoppingList': val
      });

    }catch(e){
      print(e.toString());
    }
    
  }

  // Function to update stock
  Future updateStock(String name, int quantity) async{

    try{
      
      bool result = await DataConnectionChecker().hasConnection;
      if(result != true) {
        return 'Connection failed';
      } 

      return await itemCollection.document(uid).updateData({
        '$name.quantity': quantity
      });

    }catch(e){
      print(e.toString());
    }
    
  }

  // Delete Inventory data
  Future deleteInventory() async {
    try{

      bool result = await DataConnectionChecker().hasConnection;
      if(result != true) {
        return 'Connection failed';
      } 

      return await itemCollection.document(uid).delete();

    }catch(e){
      print(e.toString());
    }
    
  }

  // Function to update user email
  Future updateEmail(String email) async{
    return await userCollection.document(uid).updateData({
      'email' : email
    });
  }

  // Function to update user name
  Future updateName(String name) async{
    return await userCollection.document(uid).updateData({
      'name' : name
    });
  }

  // Function to share inventory 
  // Shared field is updated in both the accounts
  // items list is updated in the account to be shared
  Future shareInventory(String email) async{
    
    try{

      bool result = await DataConnectionChecker().hasConnection;
      if(result != true) {
        return 'Connection failed';
      } 

      var receiverName =  await userCollection.document(email).get().then((document) {
                        return document.data['name'];
                  });

      var requesterName =  await userCollection.document(uid).get().then((document) {
                        return document.data['name'];
                  });            

      await userCollection.document(email).updateData({
        'shared' : FieldValue.arrayUnion([{'uid' : uid,'name' : requesterName,'status' : 'request'}])
      });

      return await userCollection.document(uid).updateData({
        'shared' : FieldValue.arrayUnion([{'uid' : email,'name' : receiverName, 'status' : 'pending'}])
      });
    }catch(e){
      // print(e.toString());
      return 'Exception';
    }
  }

  Future removeFromSharingInventory(String email, String name, String status) async{
    try{

      bool result = await DataConnectionChecker().hasConnection;
      if(result != true) {
        return 'Connection failed';
      } 

      var requesterName =  await userCollection.document(uid).get().then((document) {
                        return document.data['name'];
                  });

      var requesterStatus = status == 'pending' ? 'request' : 'accepted';

      await userCollection.document(email).updateData({
        'items' : email,
        'shared' : FieldValue.arrayRemove([{'uid' : uid,'name' : requesterName, 'status': requesterStatus}])
      });

      return await userCollection.document(uid).updateData({
        'items' : uid,
        'shared' : FieldValue.arrayRemove([{'uid' : email,'name' : name, 'status': status}])
      });

    }catch(e){
      print(e.toString());
      return 'Exception';
    }
  }

  Future acceptShareRequest(String email, String name) async{
    try{

      bool result = await DataConnectionChecker().hasConnection;
      if(result != true) {
        return 'Connection failed';
      } 

      var requesterName =  await userCollection.document(uid).get().then((document) {
                        return document.data['name'];
                  });
      
      await userCollection.document(email).updateData({
        'shared' : FieldValue.arrayRemove([{'uid' : uid,'name' : requesterName, 'status': 'pending'}])
      });

      await userCollection.document(email).updateData({
        'shared' : FieldValue.arrayUnion([{'uid' : uid,'name' : requesterName, 'status': 'accepted'}])
      });

      await userCollection.document(uid).updateData({
        'shared' : FieldValue.arrayRemove([{'uid' : email,'name' : name, 'status': 'request'}])
      });

      await userCollection.document(uid).updateData({
        'items' : email,
        'shared' : FieldValue.arrayUnion([{'uid' : email,'name' : name, 'status': 'accepted'}])
      });

    }catch(e){
      print(e);
      return 'Exception';
    }
  }

  Future rejectShareRequest(String email, String name) async{
    try{

      bool result = await DataConnectionChecker().hasConnection;
      if(result != true) {
        return 'Connection failed';
      } 

      var requesterName =  await userCollection.document(uid).get().then((document) {
                        return document.data['name'];
                  });
      
      await userCollection.document(email).updateData({
        'shared' : FieldValue.arrayRemove([{'uid' : uid,'name' : requesterName, 'status': 'pending'}])
      });

      await userCollection.document(uid).updateData({
        'shared' : FieldValue.arrayRemove([{'uid' : email,'name' : name, 'status': 'request'}])
      });

    }catch(e){
      print(e);
      return 'Exception';
    }
  }

}