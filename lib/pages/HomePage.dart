import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Components/listView.dart';
import 'package:teco1/Data.dart';
import 'package:teco1/pages/addDevice.dart';

class ProfilePage extends StatefulWidget {
  final Data personData;

  ProfilePage({this.personData});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile page",
          style: TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0x9fcad8f0)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Card(
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                elevation: 5,
              ),
            ),
            GetListView(
              devices: widget.personData.deviceList,
              user: widget.personData,
            ),
          ],
        ),
      ),
      floatingActionButton: RawMaterialButton(
        fillColor: Color(0XFF54B0F3),
        splashColor: Colors.lightBlueAccent,
        shape: StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Device",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        onPressed: (){
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => AddDevice(
                    user: widget.personData,
                  )));
        }
      ),
    );
  }
}
