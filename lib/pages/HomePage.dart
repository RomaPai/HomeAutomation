import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teco1/Components/DevicelistView.dart';
import 'package:teco1/Data.dart';
import 'package:teco1/Functions/signingFun.dart';
import 'package:teco1/pages/Profile.dart';

import 'package:teco1/pages/addDevice.dart';
import 'package:teco1/Functions/userData_fun.dart';
import 'package:teco1/widgets/logInWidget.dart';

class ProfilePage extends StatefulWidget {
  final Data personData;

  ProfilePage({this.personData});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<ProfilePage> {
  GlobalKey _card = GlobalKey();

  void _delete(List<String> device) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.grey,
            title: Text(
              'Do you want to delete this appliance?',
              textAlign: TextAlign.center,
            ),
            content: Text(
              'All information will be permanently lost',
              textAlign: TextAlign.center,
            ),
            elevation: 40,
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('NO'),
                color: Colors.redAccent,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);

                  setState(() {
                    deleteData(widget.personData, device);
                    widget.personData.deviceList.remove(device);
                  });
                },
                color: Colors.redAccent,
                child: Text('YES'),
              )
            ],
          );
        });
  }

  ListTile _profileHead(BuildContext context) {
    return ListTile(
      focusColor: HexColor("#1A1A1A"),
      hoverColor: HexColor("#1A1A1A"),
      title: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          "Name: " + widget.personData.name.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          "Email: " + widget.personData.emailId,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#1A1A1A"),
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Loading'),
                            SpinKitCircle(
                              size: 25,
                              color: Theme.of(context).indicatorColor,
                            ),
                          ],
                        ),
                        elevation: 40,
                      );
                    });
                await signOutGoogle();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return FirstPage();
                }));
              },
              child: Icon(
                Icons.power_settings_new,
                size: 26,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Loading'),
                            SpinKitCircle(
                              size: 25,
                              color: Theme.of(context).indicatorColor,
                            ),
                          ],
                        ),
                        elevation: 40,
                      );
                    });
                await Navigator.maybePop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Profile(widget.personData,user: widget.personData);
                }));
              },
              child: Icon(
                Icons.people,
                size: 26,
              ),
            ),
          )
        ],
        backgroundColor: HexColor("#BF0000"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: HexColor("#1A1A1A"),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Card(
                color: Colors.redAccent,
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                elevation: 5,
                child: _profileHead(context),
              ),
            ),
            GetListView(
              devices: widget.personData.deviceList,
              user: widget.personData,
              card: _card,
              handler: _delete,
            ),
          ],
        ),
      ),
      floatingActionButton: RawMaterialButton(
          fillColor: HexColor("#BF0000"),
          splashColor: Colors.redAccent,
          shape: StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Device",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddDevice(
                          user: widget.personData,
                        )));
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    print("cool");
  }
}
