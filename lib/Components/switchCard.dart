import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:teco1/Data.dart';

import 'package:teco1/main.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:teco1/Functions/timer.dart';
//import 'package:sqflite/sqflite.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';

class SwitchCard extends StatefulWidget {
  final Data user;
  final String seitchNo;

  final List<String> Devices;
  final bool s;
  final int notificationID;
  //final Map allValues;

  SwitchCard(
      {this.user, this.seitchNo, this.Devices, this.s, this.notificationID});



  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  _MySwitchCardState createState() =>
      _MySwitchCardState(user, seitchNo, Devices, s, notificationID);
}

class _MySwitchCardState extends State<SwitchCard> {
 static final storage = FlutterSecureStorage();
   bool s;
  static Data user;
  String seitchno;
   List<String> Devices;
   String _switchNo;
   String stat;
   String dI;
  int notificationID;



  var selectedDateTime;
  String _alarmTimeString = ' ';
  DateTime _alarmTime;
  bool alarmSelect = false;
  String data = "0";
  String str = ' ';
  final timeController = TextEditingController();
  static Map<String, String> allValues;
 DateTime scheduleAlarmDateTime;




  _MySwitchCardState(userParam, seitChno, devices, s11, not) {
    user = userParam;
    this.seitchno = seitChno;
    this.Devices = devices;
    this.s = s11;
    this.notificationID = not;

   // allValues = all;
  }


  @override
  void initState(){
    super.initState();
    AndroidAlarmManager.initialize();
    retrieveData();
    retrieveTime();
    WidgetsFlutterBinding.ensureInitialized();
  }


   final databaseReference = FirebaseDatabase.instance.reference();


   void uploadData(String index) {
    DatabaseReference ref = databaseReference
        .child("users")
        .child(user.uniqueId)
        .child("devices")
        .child(Devices[2])
        .child("Switch-list")
        .child(_switchNo);
    ref.update({"switch value": index});
  }

  void retrieveData() {
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
      if (mounted){
        setState(() {
          data = snapshot.value['switch value'];

          if (data == "0") {
            s = false;
          } else {
            s = true;
          }
        });
    }
    });
  }

 void retrieveTime() {
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
     if(mounted) {
       setState(() {
         data = snapshot.value['Alarm Time'];
         if (data.length == 1) {
           str = data;
         } else {
           str = data.substring(11, 16);
         }
       });
     }
   });
 }



  void addNew(String alarmKey, String alarmVal) async {
    await storage.write(key: alarmKey, value: alarmVal);
  }

   void storeData(DateTime dateTime) async {
     String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
    if (Devices[2] != null) {
      await storage.write(key: "unique", value: user.uniqueId);
      await storage.write(key: "stat$seitchno $stat", value:formattedDate);
      await storage.write(key: "SwitchNo $seitchno", value: formattedDate);
      await storage.write(key: "deviceID$seitchno $dI", value: formattedDate);
      print(storage);
      print("jassi");
    }
  }

  static Future<Map> readData() async {
    allValues = await storage.readAll();
    print(allValues);
    return allValues;
  }
 void _deleteAll() async {
   await storage.deleteAll();
   readData();
 }

 void delete(String switchNo){
     allValues.removeWhere((key, value) => key.contains(switchNo));
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
              Text(str),
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
                  _switchNo = seitchno;
                  uploadData('0');
                } else {
                  _switchNo = seitchno;
                  uploadData('1');
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
                  print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
                  _switchNo = seitchno;
                  stat = s.toString();
                  dI = Devices[2];
                  storeData(scheduleAlarmDateTime);

                  await AndroidAlarmManager.oneShotAt(
                    scheduleAlarmDateTime,
                    notificationID,
                    callback,
                    exact: true,
                    wakeup: true,
                  );
                   scheduleAlarm(_alarmTime);
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
                    if(scheduleAlarmDateTime.compareTo(DateTime.now())>0) {
                      await AndroidAlarmManager.cancel(notificationID);
                      flutterLocalNotificationsPlugin.cancel(notificationID);
                    }
                    delete(seitchno);

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
       notificationID,
       'Alarm Time',
       'Please check you switch $seitchno.',
       scheduledNotificationDateTime,
       platformChannelSpecifics);
 }


 static Future<void> callback() async {
    print("alarm works");
    final databaseReference = FirebaseDatabase.instance.reference();
    DatabaseReference ref;
     String switchNo;
     String id;
     String status;
    List<List> alarmThing = [];

      await readData().then((value) async {
        allValues.forEach((k, v) {
          List noAlarm = [];
          DateTime temp = DateTime.now();
          String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(temp);


          if(formattedDate == v && k.startsWith("deviceID")){
           var arr =  k.split(" ");
           id = arr[1];
          }
          if(formattedDate == v && k.startsWith("SwitchNo")){
            var arr =  k.split(" ");
            switchNo = arr[1];
          }
          if(formattedDate == v && k.startsWith("stat")){
            var arr =  k.split(" ");
            status = arr[1];
          }
        });
        print("debug jassi");
        for(int i =0;i <alarmThing.length;i++) {
          ref = databaseReference
              .child("users")
              .child(allValues['unique'])
              .child("devices")
              .child(alarmThing[i][0])
              .child("Switch-list")
              .child(alarmThing[i][1]);
          if (alarmThing[i][2] == "false") {
            ref.update({"switch value": "1"}).then((value) =>
                print("worked alarm finally "));
          }
          if (alarmThing[i][2] == "true") {
            ref.update({"switch value": "0"}).then((value) =>
                print("worked alarm finally "));
          }
        }

      });

  }

// as() async {
//   await callback();
// }
}
//
// Future<void> calls() async {
//   //print(deviceID);
//   print("check");
//   final databaseReference = FirebaseDatabase.instance.reference();
//   DatabaseReference ref = databaseReference.child("users");
//   await ref.update({"alarm": "hello"});
// }
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
