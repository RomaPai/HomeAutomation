import 'package:flutter/material.dart';
import 'package:teco1/pages/Login.dart';
import 'package:teco1/widgets/themes.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: appTheme(),
      home: LoginPage(),
    );
  }
}
