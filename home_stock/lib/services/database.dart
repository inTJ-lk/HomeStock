import 'package:home_stock/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String name) async {
    return await userCollection.document(uid).setData({
      'name': name,
    });
  }

}