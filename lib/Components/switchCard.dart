import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teco1/Data.dart';
import 'package:intl/intl.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:teco1/Functions/timer.dart';
import 'package:teco1/Functions/userData_fun.dart';
import 'package:teco1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teco1/pages/Login.dart';
import 'package:teco1/widgets/themes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

String unique = "";
String deviceID = "";
String switchNo = "";
bool selectedSwitch = false;

class SwitchCard extends StatefulWidget {
  final Data user;
  final String seitchNo;

  final List<String> Devices;
  final bool s;

  SwitchCard({this.user, this.seitchNo, this.Devices, this.s});

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  _MySwitchCardState createState() =>
      _MySwitchCardState(user, seitchNo, Devices, s);


}

class _MySwitchCardState extends State<SwitchCard> {

  bool s;
  Data user ;
  String seitchno ;
  List<String> Devices ;
  var selectedDateTime;
  String _alarmTimeString = ' ';
  DateTime _alarmTime;
  bool alarmSelect = false;
  String data = "0";
  String str = ' ';
  final timeController = TextEditingController();




  _MySwitchCardState(
     user,
    this.seitchno,
    this.Devices,
    this.s,
  );

  @override
  void initState() {
    super.initState();
  print(user);
  print("works" + user.uniqueId);
    AndroidAlarmManager.initialize();
  }

  static final databaseReference = FirebaseDatabase.instance.reference();

  void uploadData(String index) {
    DatabaseReference ref = databaseReference
        .child("users")
        .child(user.uniqueId)
        .child("devices")
        .child(Devices[2])
        .child("Switch-list")
        .child(seitchno);
    ref.update({"switch value": index});
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

  String _getTime() {
    retrieveTimeDb(str, seitchno, user, Devices).then((value) {
      str = value;
    });
    if (str.length == 1) {
      return str;
    } else {
      return str.substring(11, 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 24, right: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.seitchNo,
                style: TextStyle(fontSize: 18),
              ),
              Text(_getTime()),
            ],
          ),
          CupertinoSwitch(
            activeColor: HexColor('4075b4'),
            trackColor: HexColor('dee7f3'),
            value: s,
            onChanged: (bool value) {
              setState(() {
                s = value;
                if (value == false) {
                  uploadData('0');
                } else {
                  uploadData('1');
                  print(retrieveDatat);

                  deviceID = Devices[2];

                  print(user.uniqueId);
                  print(Devices[2]);
                  print(seitchno);
                  AndroidAlarmManager.oneShot(
                    const Duration(seconds: 10),
                    Random().nextInt(pow(2, 31)),
                    callback,
                    exact: true,
                    wakeup: true,
                  );
                }
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: alarmSelect
                    ? Icon(
                        Icons.alarm_on,
                        size: 18,
                        color: HexColor('9fbbdd'),
                      )
                    : Icon(
                        Icons.add_alarm,
                        size: 18,
                        color: HexColor('4075b4'),
                      ),
                onTap: () async {
                  var time = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  timeController.text = time.format(context);
                  if (time != null) {
                    final now = DateTime.now();
                    selectedDateTime = DateTime(
                        now.year, now.month, now.day, time.hour, time.minute);
                    _alarmTime = selectedDateTime;
                    setState(() {
                      _alarmTimeString =
                          selectedDateTime.toString().substring(11, 16);
                      alarmSelect = true;
                    });
                  }
                  DateTime scheduleAlarmDateTime;
                  if (_alarmTime.isAfter(DateTime.now()))
                    scheduleAlarmDateTime = _alarmTime;
                  else
                    scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));
                  sendTimeDb(scheduleAlarmDateTime.toString(), seitchno, user,
                      Devices);
                  print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
                  await AndroidAlarmManager.oneShotAt(
                    scheduleAlarmDateTime,
                    Random().nextInt(pow(2, 31)),
                    callback,
                    exact: true,
                    wakeup: true,
                  );

                  print(_alarmTime);
                  // ignore: await_only_futures
                  await print('after alarmtime');
                },
              ),
              InkWell(
                  child: alarmSelect
                      ? Icon(
                          Icons.alarm_off,
                          size: 18,
                          color: HexColor('4075b4'),
                        )
                      : Icon(
                          Icons.alarm_off,
                          size: 18,
                          color: HexColor('9fbbdd'),
                        ),
                  onTap: () async {
                    setState(() {
                      _alarmTimeString = ' ';
                      alarmSelect = false;
                      sendTimeDb(_alarmTimeString, seitchno, user, Devices);
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }

  // static Future<void> scheduleAlarm() async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'alarm_notif',
  //     'alarm_notif',
  //     'Channel for Alarm notification',
  //     icon: 'logo',
  //     playSound: true,
  //     largeIcon: DrawableResourceAndroidBitmap('logo'),
  //   );
  //
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //
  //   var platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.schedule(0, DateTime.now().toString(),
  //       'Please check your device!', DateTime.now(), platformChannelSpecifics);
  //   // ignore: await_only_futures
  //   await print(DateTime.now().toString()+ 'after notification');
  //   // uploadData('1');
  // }
  static Future<void> callback() async {
    print("alarm works");
    DatabaseReference ref;
    ref = databaseReference
        .child("users")
        .child(user.uniqueId)
        .child("devices")
        .child(Devices[2])
        .child("Switch-list")
        .child(seitchno);

    await ref.update({"switch value": '1'});

    return true;
  }

  // as() async {
  //   await callback();
  // }
}

Future<void> calls() async {
  print(deviceID);
  print("check");
  final databaseReference = FirebaseDatabase.instance.reference();
  DatabaseReference ref = databaseReference.child("users");
  await ref.update({"alarm": "hello"});
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
  }

  void p(DateTime now) {
    print(now);
    print("Fuck engineering");
  }

  functionCall() async {
    print('YO1');
    DateTime n = DateTime.now();
    await Isolate.spawn(p, n);
  }*/
