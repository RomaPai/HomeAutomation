import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

import 'package:teco1/Functions/userData_fun.dart';

import '../Data.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class AddDevice extends StatefulWidget {
  final Data user;

  AddDevice({this.user});

  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  TextEditingController _inputController;

  String _dropdownValue = 'Hall';

  String deviceId = "";

  String bedroom = "";

  var _room = [
    "Hall",
    "Dining Area",
    "Bedroom 1",
    "Bedroom 2",
    "Kitchen",
    "Bathroom 1",
    "Bathroom 2"
  ];

  @override
  Widget build(BuildContext context) {
    this._inputController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('608fc7'),
        centerTitle: true,
        title: Text("Add Device"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 32.0,
              ),
              ListTile(
                title: TextField(
                  // style: TextStyle(color: Colors.white),
                  controller: this._inputController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Scan QR-Code to add Device',
                    // labelStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.only(left: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white)),
                    fillColor: Colors.white38,
                    hoverColor: Colors.white,
                  ),
                ),
                // focusColor: Colors.white38,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Center(
                child: Container(
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text("Scan QR-Code", style: TextStyle(fontSize: 20)),
                    color: HexColor('4075b4'),
                    textColor: Colors.white,
                    onPressed: () async {
                      _scan();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
              // ListTile(
              //   title: TextFormField(
              //     // style: TextStyle(color: Colors.white),
              //     initialValue: bedroom,
              //     onChanged: (value) {
              //       bedroom = value;
              //     },
              //     validator: (value) {
              //       if (value.isEmpty) {
              //         return 'This field is required';
              //       }
              //       return null;
              //     },
              //     decoration: InputDecoration(
              //       labelText: 'Room',
              //       // labelStyle: TextStyle(color: Colors.white),
              //       contentPadding: EdgeInsets.only(left: 20),
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(15)),
              //           // borderSide: BorderSide(color: Colors.white)
              //           ),
              //     ),
              //   ),
              // ),
              Container(
                height: 62,
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: InputDecorator(
                  expands: false,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                        focusColor: HexColor("37659b"),
                        hint: Text('Select the room'),
                        value: _dropdownValue,
                        isDense: true,
                        onChanged: (value) {
                          bedroom = value;
                          setState(() {
                            _dropdownValue = value;
                            _inputController.value =
                                new TextEditingController.fromValue(
                                        new TextEditingValue(text: "My String"))
                                    .value;
                            print(_inputController.value);
                          });
                        },
                        items: _room.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Container(
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text("Save Device",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)),
                      color: HexColor('4075b4'),
                      textColor: Colors.white,
                      onPressed: () {
                        checkData(widget.user, deviceId, context, bedroom);

                        //1
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    deviceId = await scanner.scan();
    print(deviceId + "  success");
    this._inputController.text = deviceId;
  }
}
