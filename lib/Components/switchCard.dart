import 'dart:async';
import 'dart:isolate';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teco1/Data.dart';
import 'package:teco1/pages/timer_page.dart';
import 'package:teco1/widgets/timer_builder.dart';

class SwitchCard extends StatefulWidget {
  final Data user;
  final String seitchNo;
  final List<String> Devices;
  bool s;

  SwitchCard({this.user, this.seitchNo, this.Devices, this.s});

  _MySwitchCardState createState() =>
      _MySwitchCardState(user, seitchNo, Devices, s);
}

class _MySwitchCardState extends State<SwitchCard> {
  bool s;
  final Data user;
  final String seitchno;
  final List<String> Devices;
  int time;
  String data = "0";
  _MySwitchCardState(this.user, this.seitchno, this.Devices, this.s);

  final databaseReference = FirebaseDatabase.instance.reference();
  final int helloAlarmID = 0;
// using android alarm manager : Kishan bhaiya.
  void printHello() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.periodic(
        const Duration(seconds: 5), helloAlarmID, p);
  }

  void p(){
    final DateTime now = DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    print("[$now] Hello, world! isolate= ${isolateId} function='$printHello'");
  }


  void uploadData(String index) {
    DatabaseReference ref = databaseReference
        .child("users")
        .child(user.uniqueId)
        .child("devices")
        .child(Devices[2])
        .child("Switch-list")
        .child(seitchno);
    ref.set({"switch value": index});
  }

  void retrieveDatat() {
    databaseReference
        .child("users")
        .child(user.uniqueId)
        .child("devices")
        .child(Devices[2])
        .child("Switch-list")
        .child(seitchno)
        .onValue
        .listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        data = snapshot.value['switch value'];

        if (data == "0") {
          s = false;
        } else {
          s = true;
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    retrieveDatat();
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(top: 0, bottom: 0, right: 20, left: 40),
                  title: Text(widget.seitchNo),
                ),
              ),
              SizedBox(
                width: 50.0,
              ),
              RaisedButton(
                onPressed: () async {
                 await printHello();
                 print("PARAM");
                },
                child: Text("SET"),
              ),
              SizedBox(
                width: 50.0,
              ),
              Expanded(
                  child: Switch(
                value: s,
                onChanged: (bool value) {
                  setState(() {
                    s = value;
                    if (value == false) {
                      uploadData('0');
                      Fluttertoast.showToast(
                          msg: "$seitchno is  Off",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      uploadData('1');
                      Fluttertoast.showToast(
                          msg: "$seitchno is  On",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  });
                },
              ))
            ],
          ),
        ],
      ),
    );
  }
}
/*void startTimer(int t) {
    Timer timer = new Timer.periodic(new Duration(seconds: t), (time) {

      Fluttertoast.showToast(
          msg: "TIMER WORKS",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      databaseReference
          .child("users")
          .child(user.uniqueId)
          .child("devices")
          .child(Devices[2])
          .child("Switch-list")
          .child(seitchno)
          .onValue
          .listen((event) {
        var snapshot = event.snapshot;
        setState(() {
          data = snapshot.value['switch value'];

          if (data == "0") {
            s = true;
            uploadData("1");
          } else {
            s = false;
            uploadData("0");
          }
        });
        time.cancel();
      });

    });
  } */