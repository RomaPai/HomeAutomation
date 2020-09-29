import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Functions/signingFun.dart';
import 'package:teco1/Functions/userData_fun.dart';
import 'package:teco1/pages/HomePage.dart';
import 'package:teco1/widgets/logInWidget.dart';

import '../Data.dart';
import 'Splash.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
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
  void _loginAction() {
    if (Firebase.apps.isNotEmpty) {
      try {
        User user = FirebaseAuth.instance.currentUser;
        Data personalData;
        _db
            .collection("users")
            .doc(user.uid)
            .get()
            .then((value) {
          if (value.exists) {
            personalData = Data(
              name: value.data()["name"],
              emailId: value.data()["email"],
              deviceList: [],
              uniqueId: user.uid,
            );
          } else {
            signOutGoogle().then((value) {
              _navigateToLogin();
            });
          }
        }).then(
              (value) {
            _db
                .collection("users")
                .doc(user.uid)
                .collection("devices")
                .orderBy('Time Of Creation')
                .get()
                .then((querySnapshot) {
              querySnapshot.docs.forEach((result) {
                if (result.exists) {
                  List<String> appl = [];
                  appl.add(result.data()["Device Id"]);
                  appl.add(result.data()["Bedroom"]);
                  appl.add(result.id);
                  personalData.deviceList.add(appl);
                  print(personalData.deviceList);
                }
              });
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