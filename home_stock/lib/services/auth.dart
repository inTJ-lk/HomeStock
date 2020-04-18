import 'package:home_stock/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_stock/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }

  //sign in with email and password
  Future signInWithEmailAndPasswors(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    } 
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPasswors(String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      
      //create new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData(name);

      await DatabaseService(uid: user.uid).createItemCollection();
      
      return _userFromFirebaseUser(user);

    } 
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } 
    catch (e) {
      print(e.toString());
      return null;
    }
  }
}