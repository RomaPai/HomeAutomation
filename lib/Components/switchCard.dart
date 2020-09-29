import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teco1/Data.dart';

class SwitchCard extends StatefulWidget {
  final Data user;
  final String seitchNo;
  final List<String> Devices;

  SwitchCard({this.user, this.seitchNo, this.Devices});

  _MySwitchCardState createState() => _MySwitchCardState(user, seitchNo,Devices);
}

  class _MySwitchCardState extends State<SwitchCard> {
    bool _lights = false;
    final Data user;
    final String seitchno;
    final List<String> Devices;

    _MySwitchCardState(this.user, this.seitchno, this.Devices);

    @override
    Widget build(BuildContext context) {
      final FirebaseFirestore _db = FirebaseFirestore.instance;

      void uploadData(int onOff) async {
        DocumentReference ref = _db.collection("users").doc(user.uniqueId)
            .collection("devices").doc(Devices[2]).collection("Switch-list")
            .doc('$seitchno');
        await ref.set({
          'value': onOff,
        });
      }

      return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.only(top: 0, bottom: 0, right: 20, left: 40),
                    title: Text(widget.seitchNo),
                  ),

                ),
                SizedBox(
                  width: 100.0,
                ),
                Expanded(child: Switch(
                  value: _lights,
                  onChanged: (bool value) {

                    setState(() {
                      _lights = value;
                      if(value ==false){
                        uploadData(0);
                        Fluttertoast.showToast(msg: "$seitchno is  Off",toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      else{
                        uploadData(1);
                        Fluttertoast.showToast(msg: "$seitchno is  On",toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  ))
              ],
            ),
          ],
        ),
      );
    }
  }
