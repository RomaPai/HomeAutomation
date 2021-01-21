import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

import 'package:teco1/Functions/userData_fun.dart';

import '../Data.dart';

import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddDevice extends StatefulWidget {
  final Data user;
  final String scanDevice;
  AddDevice({this.user, this.scanDevice});

  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  TextEditingController _inputController;

  String bedroom = "";

  File _image;
  final picker = ImagePicker();

  Future imageFromCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 120,
        maxWidth: 100);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imageFromGallery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 120,
        maxWidth: 100);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    this._inputController = TextEditingController(text: widget.scanDevice);
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
                  controller: this._inputController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.scanDevice,
                    contentPadding: EdgeInsets.only(left: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white)),
                    fillColor: Colors.white38,
                    hoverColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),

              const SizedBox(
                height: 60.0,
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
                    if (value.length > 11) {
                      return 'Length must be less than 11 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Room',
                    contentPadding: EdgeInsets.only(left: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white)),
                    fillColor: Colors.white38,
                    hoverColor: Colors.white,
                  ),
                ),
              ),
              // Container(
              //   height: 62,
              //   padding: EdgeInsets.symmetric(horizontal: 12),
              //   child: InputDecorator(
              //     expands: false,
              //     decoration: InputDecoration(
              //         errorStyle: TextStyle(
              //           color: Colors.redAccent,
              //         ),
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(30.0))),
              //     child: DropdownButtonHideUnderline(
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //         child: DropdownButton<String>(
              //           focusColor: HexColor("37659b"),
              //           hint: Text('Select the room'),
              //           value: _dropdownValue,
              //           isDense: true,
              //           onChanged: (value) {
              //             bedroom = value;
              //             setState(() {
              //               _dropdownValue = value;
              //               _inputController.value =
              //                   new TextEditingController.fromValue(
              //                           new TextEditingValue(text: "My String"))
              //                       .value;
              //               print(_inputController.value);
              //             });
              //           },
              //           items: _room.map((String value) {
              //             return DropdownMenuItem<String>(
              //               value: value,
              //               child: Text(value),
              //             );
              //           }).toList(),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
                        checkData(
                            widget.user, widget.scanDevice, context, bedroom);
                        uploadImageToFirebase(_image, widget.scanDevice);
                      },
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text("image", style: TextStyle(fontSize: 20)),
                      color: HexColor('4075b4'),
                      textColor: Colors.white,
                      onPressed: () {
                        print('inside image fn');
                        imageFromCamera();
                      },
                    ),
                  ),
                  Container(
                    height: 110,
                    width: 110,
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(
                            _image,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future uploadImageToFirebase(File _imageFile, String deviceId) async {
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child(widget.user.uniqueId + '/' + widget.scanDevice + '.jpg');
    firebaseStorageRef.putFile(_imageFile);
    print('image uploaded');
  }
}
