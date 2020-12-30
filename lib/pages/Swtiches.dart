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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor('608fc7'),
        title: Text(
          devices[1],
          style: TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: Icon(Icons.wifi, size: 20),
                onTap: () {
                  resetWifi();
                },
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
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
            "Fan Speed:" + ' $speed',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Slider(
              value: speed.toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              activeColor: HexColor('4075b4'),
              inactiveColor: HexColor('dee7f3'),
              // activeColor: Colors.green,
              // inactiveColor: Colors.redAccent,
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
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    retrieveDatat();
  }

  void resetWifi() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text(
              'Do you want to reset the wifi?',
              textAlign: TextAlign.center,
            ),
            content: Text(
              'Are you sure?',
              textAlign: TextAlign.center,
            ),
            elevation: 20,
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('NO',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
              ),
              FlatButton(
                onPressed: () {
                  databaseReference
                      .child("users")
                      .child(user.uniqueId)
                      .child("devices")
                      .child(devices[2])
                      .child("Switch-list")
                      .child("ResetWifi")
                      .set({"value": "1"});

                  Navigator.pop(context);
                },
                child: Text(
                  'YES',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              )
            ],
          );
        });
  }

}
