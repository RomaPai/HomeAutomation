import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Functions/signingFun.dart';
import 'package:teco1/pages/HomePage.dart';
import 'package:teco1/widgets/logInWidget.dart';

import '../Data.dart';
import 'Splash.dart';

final databaseReference = FirebaseDatabase.instance.reference();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _navigateToLoginPage() async {
    try {
      await Firebase.initializeApp(
        name: 'TeconicoHA',
        options: FirebaseOptions(
          messagingSenderId: '658559433254',
          projectId: 'teconicoha',
          apiKey: 'AIzaSyAd-ofzlsN_mabD75bsru55cD6A0T1-FIg',
          appId: '1:658559433254:android:cba4b993a1af32f06804e7',
        ),
      );
      _loginAction();
    } catch (e) {
      _loginAction();
    }
  }

  void _loginAction() async {
    if (Firebase.apps.isNotEmpty) {
      try {
        User user = FirebaseAuth.instance.currentUser;
        Data personalData;
        await databaseReference
            .child("users")
            .reference()
            .child(user.uid)
            .reference()
            .child("user_details")
            .reference()
            .once()
            .then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
             print(snapshot);
             print(snapshot.value );

            personalData = Data(
              name: snapshot.value["name"],
              emailId: snapshot.value["email"],
              deviceList: [],
              uniqueId: user.uid,
            );
          } else {
            signOutGoogle().then((value) {
              _navigateToLogin();
            });
          }
        }).then(
          (value)  {
            databaseReference
                .child("users")
                .reference()
                .child(user.uid)
                .reference()
                .child("devices")
                .once()
                .then((DataSnapshot snapshot) {
              if (snapshot.value != null) {
                var keys = snapshot.value.keys;
                var data = snapshot.value;
                for (var key in keys) {
                  List<String> dev = [];
                  dev.add(data[key]['Device Id']);
                  dev.add(data[key]['Bedroom']);
                  dev.add(key);
                  personalData.deviceList.add(dev);
                }
              }
            }).then(
              (value) {
                if (personalData != null) _navigateToProfile(personalData);
              },
            );
          },
        );
      } catch (e) {
        print('LoginPage');
        _navigateToLogin();
      }
    } else {
      _navigateToLogin();
    }
  }

  @override
  void initState() {
    super.initState();
    _navigateToLoginPage();
  }

  _navigateToProfile(Data personalData) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(personData: personalData),
      ),
    );
  }

  _navigateToLogin() {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return FirstPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Splash();
  }
}
