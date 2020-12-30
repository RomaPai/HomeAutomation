import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teco1/pages/Swtiches.dart';

import '../Data.dart';

class Cards extends StatelessWidget {
  final Data user;
  final List<String> device;
  final GlobalKey card;
  final Function handler;
  final String switchNo;
  Cards({this.user, this.device, this.card, this.handler, this.switchNo});
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    _title() {
      // deviceId
      return Text(
        device[1].toUpperCase(),
        style: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.w400,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }


    _subtitle() {
      // bedroom
      return Text(
        //TODO: switch number
        device[0] + " devices",
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(fontWeight: FontWeight.w300),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    _switchRoute() async {
      showDialog(
          context: context,
          builder: (context) {
            return Container(
              //  shape: RoundedRectangleBorder(
              //    borderRadius: BorderRadius.circular(8),
              //  ),
              child: SpinKitCircle(
                size: 70,
                color: Theme.of(context).indicatorColor,
              ),
              // elevation: 20,
            );
          });
      await databaseReference
          .child("users")
          .child(user.uniqueId)
          .child("devices")
          .child(device[2])
          .child("Switch-list")
          .reference()
          .once()
          .then((DataSnapshot snap) async {
        Map v = {};
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
                    Switches(device[0], user, device, v, sp)));
      });
    }

    _delete() {
      return IconButton(
        icon: Icon(
          Icons.delete_outline,
          size: 30,
          color: HexColor('#ff8080'),
        ),
        onPressed: () => handler(device),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.home,
                size: 38,
                color: HexColor('9fbbdd'),
              ),
              contentPadding:
                  EdgeInsets.only(top: 0, bottom: 0, right: 20, left: 20),
              title: Center(child: _title()),
              subtitle: Center(child: _subtitle()),
              onTap: _switchRoute,
              trailing: _delete(),
            )
          ],
        ),
      ),
    );
  }
}
