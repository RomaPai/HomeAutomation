import 'package:flutter/material.dart';
import 'package:teco1/pages/Login.dart';
import 'config.dart';




void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  MyAppState createState() => MyAppState();
}
class MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme.currentTheme(),
      home: LoginPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() { setState(() {
      print("Theme change");
    });
    });
  }
}