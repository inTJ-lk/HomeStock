class FirestoreNotification{
  
  final String timestamp;
  final String title;
  final String message;

  FirestoreNotification({this.timestamp, this.title, this.message});


  // factory FirestoreNotification.fromJson(Map<String, dynamic> parsedJson){
  //   return FirestoreNotification(
  //     timestamp: parsedJson['timestamp'],
  //     title: parsedJson['title'],
  //     message: parsedJson['message'],
  //   );
  // }

}