import 'package:flutter/material.dart';
import 'package:home_stock/models/user.dart';
import 'package:home_stock/screens/shared/loading.dart';
import 'package:home_stock/services/database.dart';
import 'package:provider/provider.dart';

class HelpAndSupport extends StatefulWidget {
  @override
  _HelpAndSupportState createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title:Text('Help and Support'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // SizedBox(height: 30.0),
                // Text(
                //   'HomeStock will help you manage and keep track of your home supplies',
                //   style: TextStyle(fontSize: 18.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                //   textAlign: TextAlign.center
                // ),
                // SizedBox(height: 10.0),
                // Divider(color: Colors.black),
                SizedBox(height: 10.0),
                Text(
                  'Manage Stock',
                  style: TextStyle(fontSize: 18.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left
                ),
                SizedBox(height: 10.0),
                Divider(color: Colors.black),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text (
                    'Add Item',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the add button in the home page to add new items to the inventory.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.filter),
                  title: Text (
                    'Filter Items',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Items can be filtered based on item category. Press the menu icon in the app-bar to select categories.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text (
                    'Search Items',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Type the item name in the search field to search items in each category.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.add_circle),
                  title: Text (
                    'Re-stock',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the restock button in the item and insert quantity to restock.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.remove_circle),
                  title: Text (
                    'De-stock',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the destock button in the item and insert quantity to destock.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text (
                    'Edit Item',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the more button on the item and select \'Edit\' to edit item details. NOTE: Item name cannnot be changed.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text (
                    'Delete Item',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the more button on the item and select \'Delete\' to delete item from inventory',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.add_shopping_cart),
                  title: Text (
                    'Add to Shopping List',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the more button on the item and select \'Add to Shopping List\' to add item to shopping list.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text (
                    'Shopping List',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the shopping cart icon in the app-bar to view and search items in the shopping list.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.remove_shopping_cart),
                  title: Text (
                    'Remove from Shopping List',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the shopping cart icon in the app-bar to navigate to shopping list. Press the more button on the item and select \'Remove from Shopping List\'',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.delete_forever),
                  title: Text (
                    'Delete Inventory',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the settings button in the app-bar to navigate to settings and select \'Clear Data\' to remove all the items from the inventory. NOTE: This will delete all the items for all the users sharing the inventory.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'NOTE: A user can manage only one inventory.',
                  style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left
                ),
                SizedBox(height: 30.0),
                Text(
                  'Shared Inventories',
                  style: TextStyle(fontSize: 18.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left
                ),
                SizedBox(height: 10.0),
                Divider(color: Colors.black),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text (
                    'Share Inventory',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the settings button in the app-bar to navigate to settings and select \'Share Inventory\' to share current inventory with another user. Insert the email address of the user and press \'Share\'.  NOTE: You can share your inventory with multiple users but you can only share your own inventory. You cannot share an inventory another user else is sharing with you.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.verified_user),
                  title: Text (
                    'Accept or Reject Shared Inventory',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the settings button in the app-bar to navigate to settings and select \'Share Inventory\'. Press the accept button to accept or reject button to reject the shared inventory. NOTE: You cannot accept requests if you are already sharing an inventory or if you have pending requests for your inventory. Make sure to remove all other shares before accepting.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text (
                    'Shared Users',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the settings button in the app-bar to navigate to settings and select \'Share Inventory\' to view the users sharing the inventory. Users who have not accepted your request will be shown as pending',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.leak_remove),
                  title: Text (
                    'Remove Shared Users (For Inventory Owners)',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the settings button in the app-bar to navigate to settings and select \'Share Inventory\'. Press the delete icon in the user to remove shared users of the inventory. The owner of the inventory can remove shared users. NOTE: This action requires you to be the owner of the inventory.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text (
                    'Delete Shared Inventory (For Shared Users)',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the settings button in the app-bar to navigate to settings and select \'Share Inventory\'. Press the delete icon to delete the current shared inventory and switch to local inventory. NOTE: This action requires you to be using an inventory shared by a different user.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'NOTE: Please make sure to have a stable internet connection for stock management and inventory sharing.',
                  style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center
                ),
                SizedBox(height: 30.0),
                Text(
                  'Account Settings',
                  style: TextStyle(fontSize: 18.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left
                ),
                SizedBox(height: 10.0),
                Divider(color: Colors.black),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.text_format),
                  title: Text (
                    'Change Name',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the settings button in the app-bar to navigate to settings and select \'Change Name\'. Enter the new name.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),                   
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text (
                    'Change Password',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text (
                    'Press the settings button in the app-bar to navigate to settings and select \'Change Password\'. Enter the current password and the new password to change the password.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),                   
                  ),
                ),
                SizedBox(height: 50.0),
                Text(
                  'Developed by { inTJ }', 
                  style: TextStyle(fontSize: 12.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500,),
                  textAlign: TextAlign.center
                ),
                Text(
                  'intj.lk97@gmail.com', 
                  style: TextStyle(fontSize: 12.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500,),
                  textAlign: TextAlign.center
                ),
              ],
            ),
          ),
        ),
      );
  }
}