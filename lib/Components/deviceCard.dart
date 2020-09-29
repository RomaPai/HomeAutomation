import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/pages/Swtiches.dart';

import '../Data.dart';

class Cards extends StatelessWidget{

  final Data user;
  final List<String> device;
  final GlobalKey card;
  final Function handler;

  Cards({this.user, this.device,this.card, this.handler});

  @override
  Widget build(BuildContext context) {

    _title(){                           // deviceId
      return Text(
        device[0].toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.w400),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    _subtitle(){                    // bedroom
      return Text(device[1],
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(color: Colors.grey[600], fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
 _switchRoute() async{

   Navigator.push(
       context,
       MaterialPageRoute(
           builder: (context) =>
               Switches(device[0],user,device)));

 }

 _delete(){
   return IconButton(
     icon: Icon(
       Icons.delete,
       size: 30,
       color: Colors.blueGrey[600],
     ),
     onPressed: () => handler(device),
   );
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
          ListTile(
              contentPadding:
              EdgeInsets.only(top: 0, bottom: 0, right: 20, left: 40),
              title: _title(),
              subtitle: _subtitle(),
            onTap: _switchRoute,
            trailing: _delete(),


          )
        ],
      ),
    );
  }

}