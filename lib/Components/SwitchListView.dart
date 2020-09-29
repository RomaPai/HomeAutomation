import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Components/switchCard.dart';

import '../Data.dart';

class GetSwitchList extends StatelessWidget{
  final Data user;
  final String deviceId;
  final List<String> devices;

  GetSwitchList({this.user, this.deviceId,this.devices});
  final List<String> switchNumber4 = <String>['S1', 'S2', 'S3','S4'];
  final List<String> switchNumber8 = <String>['S1', 'S2', 'S3','S4','S5','S6','S7','S8'];


  @override
  Widget build(BuildContext context) {
  if(deviceId == "4s"){
    return Expanded(
      child: Scrollbar(
        controller: ScrollController() ,
       child: ListView.builder(
           shrinkWrap: true,
           padding: const EdgeInsets.all(12),
           controller: ScrollController(),
           itemCount: switchNumber4.length ,
           itemBuilder: (BuildContext context, int index){
             return SwitchCard(
               user: user,
               seitchNo: '${switchNumber4[index]}',
               Devices: devices,
             );
           }),
      ),
    );
  }
  if(deviceId == "8s"){
    return Expanded(
      child: Scrollbar(
        controller: ScrollController() ,
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(12),
            controller: ScrollController(),
            itemCount: switchNumber8.length ,
            itemBuilder: (BuildContext context, int index){
              return SwitchCard(
                user: user,
                seitchNo: '${switchNumber8[index]}',
              );
            }),
      ),
    );
  }
  else{
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),

      ),
      title: Text("ALERT"),
      content: Text("Please add a correct device Id"),
    );
  }
  }

}