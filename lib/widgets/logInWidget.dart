

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teco1/Functions/signingFun.dart';
import 'package:teco1/Functions/userData_fun.dart';
import 'package:teco1/pages/HomePage.dart';
import 'package:teco1/pages/Login.dart';

class FirstPage extends StatelessWidget {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    void signInWithGoogle() async {
      try {
      User user =  await signIn();
      await userData(user, context);
        Fluttertoast.showToast(
            msg: "Signing-in",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        print("signin works");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } catch (e) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Text("Error"),
                content: Text("Unable to login"),
                elevation: 40,
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    color: Theme.of(context).primaryColor,
                    child: Text("ok"),
                  )
                ],
              );
            });
      }
    }

    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/teco_log.jpeg"),
                  height: 200.0,
                  width: 200.0),
              SizedBox(height: 30),
              Text("TecoNico",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 100),
              OutlineButton(
                splashColor: Colors.grey,
                onPressed: () {
                  signInWithGoogle();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                highlightElevation: 0,
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image: AssetImage("assets/google_logo.png"),
                          height: 35.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
