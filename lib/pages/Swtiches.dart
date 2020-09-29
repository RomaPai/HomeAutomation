import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Components/SwitchListView.dart';

import '../Data.dart';

class Switches extends StatefulWidget {
  final String deviceId;
  final Data user;
  final List<String> devices;

  Switches(this.deviceId, this.user, this.devices);

  @override
  _SwitchesState createState() =>
      _SwitchesState(deviceIdNo: deviceId, user: user,devices: devices);
}

class _SwitchesState extends State<Switches> {
  final String deviceIdNo;
  final List<String> devices;
  _SwitchesState({Data user, this.deviceIdNo,this.devices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         "Control Switches",
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
            GetSwitchList(
              deviceId: deviceIdNo,
              user: widget.user,
              devices: widget.devices,
            )

          ],
        ),
      ),
    );
  }
}
