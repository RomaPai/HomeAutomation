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


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const String countKey = 'count';
const String isolateName = 'isolate';
final ReceivePort port = ReceivePort();

//io.flutter.app.FlutterApplication
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );


  var initializationSettingsAndroid = AndroidInitializationSettings('logo');
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  print('before initialise');
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  print('after initialise');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: appTheme(),
      home: LoginPage(),
    );
  }
}
