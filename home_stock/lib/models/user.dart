class User {
  
  final String uid;
  final String email;

  User({this.uid, this.email});

}

class UserData {

  final String uid;
  final String name;
  final String items;
  final String email;
  final dynamic shared;

  UserData({this.uid, this.name, this.items, this.email, this.shared});
  
}