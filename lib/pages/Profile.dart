import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Data.dart';

var inputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.all(0),
  border: UnderlineInputBorder(),
);

class Profile extends StatelessWidget {
  final Data user;

   Profile(Data personData, {this.user});

  @override
  Widget build(BuildContext context) {
    String name = user.name;
    String email = user.emailId;
    String unique = user.uniqueId;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal,color: HexColor("#BF0000"),),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: HexColor("#1A1A1A"),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: ListTile(
                title: Text(
                  'Name',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: TextFormField(
                  initialValue: name,
                  decoration: inputDecoration,
                  style: TextStyle(fontSize: 25),
                  enabled: false,
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: ListTile(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "You can't change your email",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
                title: Text(
                  'Email',
                  style: TextStyle(color: Colors.grey),
                ),
                subtitle: TextFormField(
                  initialValue: email,
                  decoration: inputDecoration,
                  style: TextStyle(fontSize: 25),
                  enabled: false,
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.email),
                ),
              ),
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: ListTile(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "You can't change your Unique-ID",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
                title: Text(
                  'Unique-ID',
                  style: TextStyle(color: Colors.grey),
                ),
                subtitle: TextFormField(
                  initialValue: unique,
                  decoration: inputDecoration,
                  style: TextStyle(fontSize: 25),
                  enabled: false,
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.perm_identity),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
