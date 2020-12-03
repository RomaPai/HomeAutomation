import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teco1/Components/SwitchListView.dart';
import 'package:teco1/Functions/userData_fun.dart';

import '../Data.dart';

class Switches extends StatefulWidget {
  final String deviceId;
  final Data user;
  final List<String> devices;
  final Map v;
  int speed;

  Switches(this.deviceId, this.user, this.devices, this.v, this.speed);

  @override
  _SwitchesState createState() => _SwitchesState(
      deviceIdNo: deviceId, user: user, devices: devices, v: v, speed: speed);
}

class _SwitchesState extends State<Switches> {
  final String deviceIdNo;
  final List<String> devices;
  final Map v;
  final Data user;
  int speed;
  String data = "0";
  _SwitchesState(
      {this.user, this.deviceIdNo, this.devices, this.v, this.speed});

  void uploadData(String index) {
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference
        .child("users")
        .child(user.uniqueId)
        .child("devices")
        .child(devices[2])
        .child("Switch-list")
        .child("Fan")
        .set({"Fan Speed": index});
  }

  void retrieveDatat() {
    databaseReference
        .child("users")
        .child(user.uniqueId)
        .child("devices")
        .child(devices[2])
        .child("Switch-list")
        .child("Fan")
        .onValue
        .listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        data = snapshot.value['Fan Speed'];

        switch (data) {
          case "0":
            {
              speed = int.parse(data);
            }
            break;
          case "1":
            {
              speed = int.parse(data);
            }
            break;
          case "2":
            {
              speed = int.parse(data);
            }
            break;
          case "3":
            {
              speed = int.parse(data);
            }
            break;
          case "4":
            {
              speed = int.parse(data);
            }
            break;
          case "5":
            {
              speed = int.parse(data);
            }
            break;
        }
      });
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: HexColor("#1A1A1A"),
      appBar: AppBar(
        backgroundColor: HexColor("#BF0000"),
        title: Text(
          "Control Switches",
          style: TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
        ),

      ),
      body: Container(
        decoration: BoxDecoration(color: HexColor("#1A1A1A")),
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
            GetSwitchList(
              deviceId: deviceIdNo,
              user: widget.user,
              devices: widget.devices,
              v: v,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Fan Speed",
              style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
              color: Colors.white),
            ),
            SizedBox(
              height: 10.0,
            ),
            Slider(
                value: speed.toDouble(),
                min: 0,
                max: 5,
                divisions: 6,
                activeColor: Colors.green,
                inactiveColor: Colors.redAccent,
                label: '${speed.round()}',
                onChanged: (double newValue) {
                  setState(() {
                    speed = newValue.round();
                    uploadData(speed.toString());
                  });
                },
                semanticFormatterCallback: (double newValue) {
                  return '${newValue.round()}';
                }),
            Text(
              '$speed',
              style: TextStyle(fontSize: 22,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    retrieveDatat();
  }
}
