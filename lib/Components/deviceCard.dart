
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teco1/pages/Swtiches.dart';

import '../Data.dart';

class Cards extends StatelessWidget{

  final Data user;
  final List<String> device;
  final GlobalKey card;
  final Function handler;

  Cards({this.user, this.device,this.card, this.handler});
  final databaseReference = FirebaseDatabase.instance.reference();


  @override
  Widget build(BuildContext context) {

    _title(){                           // deviceId
      return Text(
        device[1].toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.w400,color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    _subtitle(){                    // bedroom
      return Text(device[0],
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

 _switchRoute() async{

   showDialog(
       context: context,
       builder: (context) {
         return AlertDialog(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15),
           ),
           title: Row(
             mainAxisAlignment:
             MainAxisAlignment.spaceBetween,
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
  await databaseReference
      .child("users")
      .child(user.uniqueId)
      .child("devices")
      .child(device[2])
      .child("Switch-list")
      .reference()
      .once().then((DataSnapshot snap) async {
        Map v ={} ;
        String speed;
        int sp;
    if (snap.value != null) {
       v = await snap.value;
      speed = await snap.value['Fan']['Fan Speed'];
      sp = int.parse(speed);

    }
   await Navigator.maybePop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Switches(device[0],user,device,v,sp)));
  });


 }

 _delete(){
   return IconButton(
     icon: Icon(
       Icons.delete,
       size: 30,
       color: Colors.redAccent,
     ),
     onPressed: () => handler(device),
   );
 }


    return Card(
      color: HexColor("#1A1A1A"),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 3),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 10),
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              contentPadding:
              EdgeInsets.only(top: 0, bottom: 0, right: 20, left: 20),
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