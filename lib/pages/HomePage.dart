import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Components/DevicelistView.dart';
import 'package:teco1/Data.dart';
import 'package:teco1/Functions/signingFun.dart';
import 'package:teco1/config.dart';
import 'package:teco1/pages/addDevice.dart';
import 'package:teco1/Functions/userData_fun.dart';
import 'package:teco1/pages/example_timer.dart';
import 'package:teco1/pages/timer_page.dart';
import 'package:teco1/widgets/logInWidget.dart';
import 'package:teco1/theme_changer.dart';

class ProfilePage extends StatefulWidget {
  final Data personData;

  ProfilePage({this.personData});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<ProfilePage> {
  GlobalKey _card = GlobalKey();
  void _delete(List<String> device){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
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
                color: Theme.of(context).primaryColor,
              ),
              FlatButton(
                onPressed: () {

                  Navigator.pop(context);
                  setState(() {
                    deleteData(widget.personData, device);
                    widget.personData.deviceList.remove(device);
                  });
                },
                color: Theme.of(context).primaryColor,
                child: Text('YES'),
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
        ),
        actions: <Widget>[
          Padding(padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return AlarmManagerExampleApp();
                }));
              },
              child: Icon(
                Icons.power_settings_new,
                size: 26,
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(right: 40.0),
            child: GestureDetector(
              onDoubleTap: (){
                currentTheme.switchTheme();
              },
              child: Icon(
                Icons.mode_edit,
                size: 26,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async{
                await signOutGoogle();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return FirstPage();
                }));
              },
              child: Icon(
                Icons.power_settings_new,
                size: 26,
              ),
            ),
          )
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0x9fcad8f0)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Card(
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                elevation: 5,
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
        fillColor: Color(0XFF54B0F3),
        splashColor: Colors.lightBlueAccent,
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
        onPressed: (){
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => AddDevice(
                    user: widget.personData,
                  )));
        }
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    print("cool");
  }
}
