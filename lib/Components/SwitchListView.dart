import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Components/switchCard.dart';

import '../Data.dart';

class GetSwitchList extends StatelessWidget {
  final Data user;
  final String deviceId;
  final List<String> devices;
  final Map v;

  GetSwitchList({this.user, this.deviceId, this.devices, this.v});
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
  // Map<String,String> s1={};
  // Map<String,String> s2={};
  // Map<String,String> s3={};
  // Map<String,String> s4={};
  // Map<String,String> s5={};
  // Map<String,String> s6={};
  // Map<String,String> s7={};
  // Map<String,String> s8={};

  bool lol;



  @override
  Widget build(BuildContext context) {
   // List<Map<String,String>> lst= <Map<String,String>>[s1,s2,s3,s4,s5,s6,s7,s8 ];
    if (deviceId.contains("4s")) {
      return Expanded(
        child: Scrollbar(
          controller: ScrollController(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
                gridDelegate:
                new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                shrinkWrap: true,
                itemCount: switchNumber4.length,
                padding: EdgeInsets.symmetric(horizontal:16,vertical: 16),
                itemBuilder: (BuildContext context, int index) {
                    String val = v[switchNumber4[index]]['switch value'];

                    if (val == '0') {
                       lol = false;
                    }
                    if (val == '1') {
                      lol = true;
                    }

                  return SwitchCard(
                    user: user,
                    seitchNo: '${switchNumber4[index]}',
                    Devices: devices,
                    s: lol,
                    notificationID: index,
                   // allValues: lst[index],
                  );
                }),
          ),
        ),
      );
    }


    if (deviceId.contains("8s")) {
      return Expanded(
        child: Scrollbar(
          controller: ScrollController(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(

                gridDelegate:
                new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                // itemCount: lists.length,
                shrinkWrap: true,
                itemCount: switchNumber8.length,
                padding: EdgeInsets.symmetric(horizontal:16,vertical: 16),
                itemBuilder: (BuildContext context, int index) {
                  String time = v[switchNumber8[index]]['Alarm Time'];
                    String val = v[switchNumber8[index]]['switch value'];
                    // print(time);
                    // print(switchNumber8[index]);
                    if (val == '0') {
                      lol = false;
                    }
                    if (val == '1') {
                      lol = true;
                    }

                  return SwitchCard(
                    user: user,
                    seitchNo: '${switchNumber8[index]}',
                    Devices: devices,
                    s: lol,
                    notificationID: index,
                    //allValues: lst[index],
                  );
                }),
          ),
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
/* if (deviceId.contains("4s")) {
      return Expanded(
        child: Scrollbar(
          controller: ScrollController(),
          child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              controller: ScrollController(),
              itemCount: switchNumber4.length,
              itemBuilder: (BuildContext context, int index) {
                if (v.length != null) {
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
    } */