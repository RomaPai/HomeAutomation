
import 'package:flutter/cupertino.dart';

import '../Data.dart';

class Switches extends StatefulWidget{
  final String deviceId;
  final Data user;

  Switches(this.deviceId,this.user);

  @override
  _SwitchesState createState() => _SwitchesState(deviceIdNo:deviceId,user:user);
}

class _SwitchesState extends State<Switches>{
  final String deviceIdNo;
  _SwitchesState( {Data user, this.deviceIdNo});

  @override
  Widget build(BuildContext context) {

  }
}