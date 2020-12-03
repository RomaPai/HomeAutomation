import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teco1/Data.dart';

class SwitchCard extends StatefulWidget {
  final Data user;
  final String seitchNo;
  final List<String> Devices;
  final bool s;

  SwitchCard({this.user, this.seitchNo, this.Devices, this.s});

  _MySwitchCardState createState() =>
      _MySwitchCardState(user, seitchNo, Devices, s);
}

class _MySwitchCardState extends State<SwitchCard> {
  bool s;
  final Data user;
  final String seitchno;
  final List<String> Devices;

  String data = "0";

  _MySwitchCardState(
    this.user,
    this.seitchno,
    this.Devices,
    this.s,
  );

  final databaseReference = FirebaseDatabase.instance.reference();

// using android alarm manager : Kishan bhaiya.

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

    return Card(
      color: HexColor("#1A1A1A"),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 3),
        borderRadius: BorderRadius.circular(5),

      ),
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListTile(
              contentPadding:
                  EdgeInsets.only(top: 0, bottom: 0, right: 20, left: 40),
              title: Text(widget.seitchNo,style: TextStyle(color: Colors.white),),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: Switch(
            activeColor: Colors.green,
            inactiveTrackColor: Colors.redAccent,
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
          )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    retrieveDatat();
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
