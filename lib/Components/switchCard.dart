
import 'dart:isolate';
import 'dart:math';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teco1/Data.dart';
import 'package:intl/intl.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:teco1/Functions/timer.dart';
import 'package:teco1/main.dart';

class SwitchCard extends StatefulWidget {
  final Data user;
  final String seitchNo;

  final List<String> Devices;
  final bool s;
  final String alarmTime;

  SwitchCard({this.user, this.seitchNo, this.Devices, this.s, this.alarmTime});

  _MySwitchCardState createState() =>
      _MySwitchCardState(user, seitchNo, Devices, s, alarmTime);
}

class _MySwitchCardState extends State<SwitchCard> {
  bool s;
  String alarmTime;
  final Data user;
  final String seitchno;
  final List<String> Devices;
  var selectedDateTime;
  String _alarmTimeString = ' ';
  DateTime _alarmTime;
  bool alarmSelect = false;
  String data = "0";
 // String str = ' ';
  final timeController = TextEditingController();
  DateTime scheduleAlarmDateTime;

  _MySwitchCardState(
      this.user, this.seitchno, this.Devices, this.s, this.alarmTime);

  @override
  void initState() {
    // _alarmHelper.initializeDatabase().then((value) {
    //   print('------database intialized');
    //   loadAlarms();
    // });
    super.initState();
    retrieveDatat();
    retrieveTimeDb(alarmTime, seitchno, user, Devices);
  }

  final databaseReference = FirebaseDatabase.instance.reference();

// using android alarm manager : Kishan bhaiya.

  Future<void> uploadData(int index) {
    DatabaseReference ref = databaseReference
        .child("users")
        .child(user.uniqueId)
        .child("devices")
        .child(Devices[2])
        .child("Switch-list")
        .child(seitchno);
    ref.update({"switch value": index.toString()});
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
    retrieveTimeDb(alarmTime, seitchno, user, Devices).then((value) {
      alarmTime = value;
    });
    if (alarmTime.length == 1) {
      return alarmTime;
    } else {
      return alarmTime.substring(11, 16);
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
                  uploadData(0);
                } else {
                  uploadData(1);
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

                  if (_alarmTime.isAfter(DateTime.now()))
                    scheduleAlarmDateTime = _alarmTime;
                  else
                    scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));
                  sendTimeDb(scheduleAlarmDateTime.toString(), seitchno, user,
                      Devices);
                 // await AndroidAlarmManager.oneShotAt(scheduleAlarmDateTime,Random().nextInt(pow(2, 31)), callback(),exact: true,wakeup: true);
                  scheduleAlarm(_alarmTime);
                  print(_alarmTime);
                  print('after alarmtime');
                  // _alarmFunction();
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

  void scheduleAlarm(DateTime scheduledNotificationDateTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'logo',
      priority: Priority.High,
      importance: Importance.Max,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        // sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        Random().nextInt(pow(2, 31)),
        'Check Device',
        'Please check your device!',
        scheduledNotificationDateTime,
        platformChannelSpecifics);

    await uploadData(1);
  }

  Future printfn() {
    print('inside print');
    return null;
  }
  callback() async{
    int n;
    if(s==false){
      n =1;
    }
    else{
      n=0;
    }
    await Isolate.spawn(uploadData,n);
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
