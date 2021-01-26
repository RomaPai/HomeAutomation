import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

import 'package:teco1/Functions/userData_fun.dart';

import '../Data.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
  String path;
  var fileName;
  File _image;
  File localImage;

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
        print('before directory');
        print(pickedFile.path);
        //  path= getApplicationDocumentsDirectory().toString();
        path = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });

    fileName = p.basename(_image.path);

    print('filename' + fileName);
    print('image path' + _image.path);
    String folderName = widget.scanDevice;
    Directory _appDocDir = await getApplicationDocumentsDirectory();
    print(_appDocDir.path);
    Directory _appDocDirFolder = Directory('${_appDocDir.path}/$folderName');
    Directory _appDocDirNewFolder;
    if (!await _appDocDirFolder.exists()) {
      _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
    } else {
      _appDocDirNewFolder = _appDocDirFolder;
    }

    // String dir = _appDocDirNewFolder.path;
    // print('dir' + dir);
    // String newPath = p.join(_appDocDir.path,'Pictures');
    // print('newpath'+newPath);
    // String str='Pictures';
    // Directory newPath=Directory('${_appDocDir.path}/$str');
    // Directory newtemp;
    // if (!await newPath.exists()) {
    //  newtemp = await newPath.create(recursive: true);
    // } else {
    //   newtemp = newPath;
    // }
    // // newPath = path.join(newPath, folderName );
    // localImage = await File(_image.path).copy(newtemp.path);
    String dev = widget.scanDevice + '.jpg';
    String temp = p.join(_appDocDirNewFolder.path, dev);

    // localImage.renameSync(temp);
    // print('after local image'+_image.path);

    // localImage = await File(_image.path).copy('$_appDocDirNewFolder/$fileName');
    localImage = await File(_image.path).copy(temp);
    print('local image' + localImage.path);
  }

  // final appDir = await syspaths.getApplicationDocumentsDirectory();
  // final fileName = path.basename(pickedFile.path);
  // final savedImage = await imageFile.copy('${appDir.path}/$fileName');

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
                  enabled: false,
                  controller: this._inputController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Device ID',
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
                height: 24.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: _image == null
                        ? Text(
                            'Image not selected',
                            style: TextStyle(color: Colors.black45),
                          )
                        : Image.file(
                            _image,
                          ),
                  ),
                  IconButton(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      color: HexColor('4075b4'),
                      onPressed: () {
                        print('inside image fn');
                        imageFromCamera();
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 32,
                      )),
                ],
              ),
              SizedBox(
                height: 40,
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
                        // uploadImageToFirebase(_image, widget.scanDevice);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future uploadImageToFirebase(File _imageFile, String deviceId) async {
  //   StorageReference firebaseStorageRef = FirebaseStorage.instance
  //       .ref()
  //       .child(widget.user.uniqueId + '/' + widget.scanDevice + '.jpg');
  //   firebaseStorageRef.putFile(_imageFile);
  //   print('image uploaded');
  // }
}
