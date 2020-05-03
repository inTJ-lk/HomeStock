import 'package:flutter/material.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/screens/shared/loading.dart';
import 'package:home_stock/services/database.dart';
import 'package:provider/provider.dart';

class ShareInventory extends StatefulWidget {
  @override
  _ShareInventoryState createState() => _ShareInventoryState();
}

class _ShareInventoryState extends State<ShareInventory> {

  String _email;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final listForUser = Provider.of<UserData>(context);

    _email = _email ?? "";

    bool validateEmail(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);

      var alreadyShared = listForUser.shared.where((i) => i['uid'] == value);

      if (regex.hasMatch(value) && alreadyShared.length == 0 && value != user.email)
        return true;
      else
        return false;
    }

    void _showDeleteConfirmationPanel(email, name, status){
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Are you sure you want to remove $email?',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  'Remove',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  dynamic i = await DatabaseService(uid: listForUser.email).removeFromSharingInventory(email, name, status);
                  setState(() {
                    _email = "";
                  });
                  Navigator.pop(context);
                  if(i.toString() == "Exception"){
                    showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Action Failed. Please try again.',
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.0),
                            RaisedButton(
                              color: Colors.blue[800],
                              child: Text(
                                'Dismiss',
                                style: TextStyle(color: Colors.white)
                              ),
                              onPressed: () async{
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    });
                  }
                  if(i.toString() == "Connection failed"){
                    showDialog(context: context, barrierDismissible: true, builder: (context){
                      return AlertDialog(
                          content: Container(
                            child: Text('Action Failed. Make sure you have an active internet connection'),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Dismiss'),
                              onPressed: () {
                                setState(() {
                                  _email = "";
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                      );
                    });
                  }
                },
              ),
            ],
          ),
        );
      });
    }

    void _showConfirmationPanel(email){
      showModalBottomSheet(context: context, isScrollControlled: true ,builder: (context){
        if(validateEmail(email) == true){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Share Inventory with $email?',
                  style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.blue[800],
                  child: Text(
                    'Share',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    // await DatabaseService(uid: listForUser.items).deleteInventory();
                    dynamic i = await DatabaseService(uid: listForUser.items).shareInventory(email);
                    Navigator.pop(context);
                    if(i.toString() == "Exception"){
                      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Invalid email address $email, Make sure the email is registered with the system.',
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20.0),
                              RaisedButton(
                                color: Colors.blue[800],
                                child: Text(
                                  'Dismiss',
                                  style: TextStyle(color: Colors.white)
                                ),
                                onPressed: () async{
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                    }else if(i.toString() == "Connection failed"){
                      showDialog(context: context, barrierDismissible: true, builder: (context){
                        return AlertDialog(
                            content: Container(
                              child: Text('Action Failed. Make sure you have an active internet connection'),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Dismiss'),
                                onPressed: () {
                                  setState(() {
                                    _email = "";
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                        );
                      });
                    }else{
                      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Invitation sent successfully. Inventory will be shared once $email accepts your request.',
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20.0),
                              RaisedButton(
                                color: Colors.blue[800],
                                child: Text(
                                  'Dismiss',
                                  style: TextStyle(color: Colors.white)
                                ),
                                onPressed: () async{
                                  setState(() {
                                    _email = "";
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          );
        }else{
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Invalid email address $email, Please try again.',
                  style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.blue[800],
                  child: Text(
                    'Dismiss',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
        
      });
    }

    void _showAcceptShareRequestPanel(email, name){
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Are you sure you want to accept share request from $email? \n',
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              Text(
                'Once you accept you will no longer have access to your inventory. Inventory of $email will be shared with you until you stop sharing or $email removes your account from sharing list.',
                textAlign: TextAlign.center,
              ),
              Text(
                '\nRefer Help and Support for more information',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.green,
                child: Text(
                  'Accept',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  dynamic i = await DatabaseService(uid: listForUser.email).acceptShareRequest(email, name);
                  setState(() {
                    _email = "";
                  });
                  Navigator.pop(context);
                  if(i.toString() == "Exception"){
                    showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Action Failed. Please try again.',
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.0),
                            RaisedButton(
                              color: Colors.blue[800],
                              child: Text(
                                'Dismiss',
                                style: TextStyle(color: Colors.white)
                              ),
                              onPressed: () async{
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    });
                  }
                  if(i.toString() == "Connection failed"){
                    showDialog(context: context, barrierDismissible: true, builder: (context){
                      return AlertDialog(
                          content: Container(
                            child: Text('Action Failed. Make sure you have an active internet connection'),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Dismiss'),
                              onPressed: () {
                                setState(() {
                                  _email = "";
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                      );
                    });
                  }
                },
              ),
            ],
          ),
        );
      });
    }

    void _showRejectShareRequestPanel(email, name, status){
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Are you sure you want to reject share request from $email? \n',
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  'Reject',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  dynamic i = await DatabaseService(uid: listForUser.email).rejectShareRequest(email, name);
                  setState(() {
                    _email = "";
                  });
                  Navigator.pop(context);
                  if(i.toString() == "Exception"){
                    showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Action Failed. Please try again.',
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.0),
                            RaisedButton(
                              color: Colors.blue[800],
                              child: Text(
                                'Dismiss',
                                style: TextStyle(color: Colors.white)
                              ),
                              onPressed: () async{
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    });
                  }
                },
              ),
            ],
          ),
        );
      });
    }

    void _showCannotShareError(){
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'You cannot share your inventory as you are already sharing the inventory of ${listForUser.items}. You will be able to share again once you stop sharing with ${listForUser.items}',
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Dismiss',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  setState(() {
                    _email = "";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
    }

    void _showCannotAcceptError(){
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'You cannot accept new requests as you are already sharing the inventory of ${listForUser.items}. You will be able to accept once you stop sharing with ${listForUser.items}',
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Dismiss',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  setState(() {
                    _email = "";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
    }

    return listForUser != null ? new GestureDetector(
      onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title:Text('Share Inventory'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            // SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
              child: Text(
                'Share your inventory with Family/Friends to let them add and modify items.',
                style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
              child: Text(
                'Enter the email address of the person to request to share the inventory. Make sure they have installed HomeStock and registered to the system.',
                style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left
              ),
            ),
            Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 10.0),
              child: TextFormField(
                // autofocus: false,
                onChanged: (value){setState(() {
                  _email = value;
                });},
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              color: Colors.blue[800],
              child: Text(
                'Share',
                style: TextStyle(color: Colors.white)
              ),
              onPressed: () async {
                if(listForUser.items != listForUser.email){
                  _showCannotShareError();
                }else{
                  _showConfirmationPanel(_email);
                }
                
                // await DatabaseService(uid: listForUser.items).getUserName(_email);
              },
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: listForUser.shared.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: AssetImage('assets/user.png'),
                      ),
                      title: Text(listForUser.shared[listForUser.shared.length - index -1]['name']),
                      subtitle: Text(listForUser.shared[listForUser.shared.length - index -1]['uid']),
                      trailing: listForUser.shared[listForUser.shared.length - index -1]['status'] == 'request' ? FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.check_circle, color: Colors.green, size: 35.0),
                              onPressed: () async{

                                var shared =  await listForUser.shared.where((i) => i['status'] == 'accepted');

                                if(listForUser.email != listForUser.items || shared.lenght != 0){
                                  _showCannotAcceptError();
                                }else{
                                  _showAcceptShareRequestPanel(listForUser.shared[listForUser.shared.length - index -1]['uid'], listForUser.shared[listForUser.shared.length - index -1]['name']);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.cancel, color: Colors.red, size: 35.0),
                              onPressed: () async{
                                _showRejectShareRequestPanel(listForUser.shared[listForUser.shared.length - index -1]['uid'], listForUser.shared[listForUser.shared.length - index -1]['name'], listForUser.shared[listForUser.shared.length - index -1]['status']);
                              },
                            ),
                          ],
                        ),
                      )
                       : IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async{
                          _showDeleteConfirmationPanel(listForUser.shared[listForUser.shared.length - index -1]['uid'], listForUser.shared[listForUser.shared.length - index -1]['name'], listForUser.shared[listForUser.shared.length - index -1]['status']);
                        },
                      ) 
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        
      ),
    ) : Loading();
  }
}