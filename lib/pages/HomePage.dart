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
              borderRadius: BorderRadius.circular(8),
            ),
            // backgroundColor: Colors.grey,
            title: Text(
              'Do you want to delete this device?',
              textAlign: TextAlign.center,
            ),
            content: Text(
              'All information will be permanently lost.',
              textAlign: TextAlign.center,
            ),
            elevation: 20,
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);

                      setState(() {
                        deleteData(widget.personData, device);
                        widget.personData.deviceList.remove(device);
                      });
                    },
                    // color: Colors.redAccent,
                    child: Text(
                      'YES',
                      style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('NO',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 16)),
                    // color: Colors.redAccent,
                  ),
                ],
              ),
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
      // backgroundColor: HexColor("#1A1A1A"),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        child: SpinKitCircle(
                          size: 70,
                          color: Theme.of(context).indicatorColor,
                        ),
                      );
                    });
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Profile(
                    user: widget.personData,
                  );
                }));
              },
              child: Icon(
                Icons.person,
                size: 26,
              ),
            ),
          )
        ],
        backgroundColor: HexColor('608fc7'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child:
          Column(
            children:<Widget>[
              SizedBox(
                height: 20.0,
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
          fillColor: HexColor("4075b4"),
          splashColor: HexColor("37659b"),
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
