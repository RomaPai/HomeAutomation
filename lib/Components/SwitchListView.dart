import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Components/switchCard.dart';

import '../Data.dart';

class GetSwitchList extends StatelessWidget {
  final Data user;
  final String deviceId;
  final List<String> devices;
 final Map v;
  GetSwitchList({this.user, this.deviceId, this.devices,this.v});
  final List<String> switchNumber4 = <String>['S1', 'S2', 'S3', 'S4'];
  final List<String> switchNumber8 = <String>[
    'S1',
    'S2',
    'S3',
    'S4',
    'S5',
    'S6',
    'S7',
    'S8'
  ];

  bool lol =false;





  @override
  Widget build(BuildContext context) {

 /*   void retrieveData(String s) async {
      await databaseReference
          .child("users")
          .child(user.uniqueId)
          .child("devices")
          .child(devices[2])
          .child("Switch-list")
          .child(s)
          .reference()
          .once()
          .then((DataSnapshot snap) async {
        if (snap.value != null) {
          v = await snap.value['switch value'];
          print(v + " " + s);
          if (v == '0') {
            lol = false;
            print(lol);
          } else if (v == '1') {
            lol = true;

          }
          print(lol);
          print(s);
        }
      });
    } */
    if (deviceId.contains("4s")){

      return Expanded(
        child: Scrollbar(
          controller: ScrollController(),
          child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              controller: ScrollController(),
              itemCount: switchNumber4.length,
              itemBuilder: (BuildContext context, int index) {

                if(v.length!=null) {
                  String val = v[switchNumber4[index]]['switch value'];
                  if (val == '0') {
                    lol = false;
                  }
                  if (val == '1') {
                    lol = true;
                  }
                }

                return SwitchCard(
                  user: user,
                  seitchNo: '${switchNumber4[index]}',
                  Devices: devices,
                  s: lol,
                );
              }),
        ),
      );
    }
    if (deviceId.contains("8s")) {
      return Expanded(
        child: Scrollbar(
          controller: ScrollController(),
          child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              controller: ScrollController(),
              itemCount: switchNumber8.length,
              itemBuilder: (BuildContext context, int index) {


                if(v.length!=null) {
                  String val = v[switchNumber8[index]]['switch value'];
                  if (val == '0') {
                    lol = false;
                  }
                  if (val == '1') {
                    lol = true;
                  }
                }


                return SwitchCard(
                  user: user,
                  seitchNo: '${switchNumber8[index]}',
                  Devices: devices,
                  s: lol,
                );
              }),
        ),
      );
    } else {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text("ALERT"),
        content: Text("Please add a device Id which is 4s or 8s"),
      );
    }
  }
}
