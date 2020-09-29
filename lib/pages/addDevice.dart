import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Functions/userData_fun.dart';

import '../Data.dart';

class AddDevice extends StatelessWidget{
  final Data user;

  AddDevice({this.user});




  String deviceId ="";
  String bedroom ="";
  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(title: Text("Add Device"),),
  body: Container(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          title: TextFormField(
            initialValue: deviceId,
            onChanged: (value) {
              deviceId = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
              decoration: InputDecoration(
                labelText:  "DEVICE ID",
                // hintText: label,
                contentPadding: EdgeInsets.only(left: 20),
                fillColor: Colors.blue[300],
                border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(50))),
              ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ListTile(
          title: TextFormField(
            initialValue: bedroom,
            onChanged: (value) {
              bedroom = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'BEDROOM',
              // hintText: label,
              contentPadding: EdgeInsets.only(left: 20),
              fillColor: Colors.blue[300],
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(50))),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Container(
              child: RaisedButton(
                child: Text("Save Device",style: TextStyle(fontSize: 20)),
                color: Color(0XFF54B0F3),
                textColor: Colors.white,
                onPressed: (){
                  List<String> appl =[];
                  appl.add(deviceId);
                  appl.add(bedroom);
                  print(user.name + " " + "huiefhid");

                  user.deviceList.add(appl);
                  print(user.deviceList);
                  uploadData(user, context);//1
                },
              ),
            ),
          ),
        )
      ],
    ),
  ),
);
  }

}