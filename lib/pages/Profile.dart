import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teco1/Functions/signingFun.dart';
import 'package:teco1/widgets/logInWidget.dart';

import '../Data.dart';

var inputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.all(0),
  border: UnderlineInputBorder(),
);

class Profile extends StatelessWidget {
  final Data user;

  Profile({this.user});

  @override
  Widget build(BuildContext context) {
    String name = user.name;
    String email = user.emailId;
    String unique = user.uniqueId;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor('608fc7'),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // backgroundColor: Colors.grey,
                        title: Text(
                          'Do you want to log out?',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                        ),

                        elevation: 20,
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await signOutGoogle();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return FirstPage();
                                      }));
                                },
                                // color: Colors.redAccent,
                                child: Text(
                                  'YES',
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                              FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('NO',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                // color: Colors.redAccent,
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              },
              child: Icon(
                Icons.exit_to_app,
                // size: 26,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(
                  'Name',
                  style: TextStyle(
                      color: HexColor('254469'), fontWeight: FontWeight.w300),
                ),
                subtitle: TextFormField(
                  initialValue: name,
                  decoration: inputDecoration,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  readOnly: true,
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    color: HexColor('9fbbdd'),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                onTap: () {},
                title: Text(
                  'Email',
                  style: TextStyle(
                      color: HexColor('254469'), fontWeight: FontWeight.w300),
                ),
                subtitle: TextFormField(
                  initialValue: email,
                  decoration: inputDecoration,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  readOnly: true,
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.email,
                    color: HexColor('9fbbdd'),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                onTap: () {},
                title: Text(
                  'Unique-ID',
                  style: TextStyle(
                      color: HexColor('254469'), fontWeight: FontWeight.w300),
                ),
                subtitle: TextFormField(
                  initialValue: unique,
                  decoration: inputDecoration,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  readOnly: true,
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.vpn_key,
                    color: HexColor('9fbbdd'),
                  ),
                ),
              ),
            ),
            Spacer(),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  // child:Text(
                  //     "NOTE:",
                  //     style: TextStyle(
                  //         fontSize: 25,
                  //         color: Colors.red,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  child: Divider(
                    color: Colors.black38,
                  ),
                ),
                Container(
                  child: Text(
                    "Copy-paste the Unique-ID given above in the TecoNico-device to access the home automation feature from your phone ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 32,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
