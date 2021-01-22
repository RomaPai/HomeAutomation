import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teco1/pages/Swtiches.dart';

import '../Data.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:cached_network_image/cached_network_image.dart';

class Cards extends StatelessWidget {
  final Data user;
  final List<String> device;
  final GlobalKey card;
  final Function handler;
  final String switchNo;
  Cards({this.user, this.device, this.card, this.handler, this.switchNo});
  final databaseReference = FirebaseDatabase.instance.reference();

  String url = '';

  @override
  Widget build(BuildContext context) {
    _title() {
      // deviceId
      if (device[1] != null) {
        return Text(
          device[1],
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w400,
              ),
          maxLines: 1,
          overflow: TextOverflow.clip,
          softWrap: true,
        );
      }
    }

    _subtitle() {
      return Text(
        //TODO: switch number
        device[0] + " devices",

        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(fontWeight: FontWeight.w300),
        maxLines: 2,
        overflow: TextOverflow.clip,
        softWrap: true,
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

    return InkWell(
      onTap: _switchRoute,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // ListTile(
              //   leading: Icon(
              //     Icons.home,
              //     size: 38,
              //     color: HexColor('9fbbdd'),
              //   ),
              //   contentPadding:
              //       EdgeInsets.only(top: 0, bottom: 0, right: 20, left: 20),
              //   title: Center(child: _title()),
              //   subtitle: Center(child: _subtitle()),
              //   onTap: _switchRoute,
              //   trailing: _delete(),
              // )

              showImage(),

              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(child: _title()),
                ],
              ),
              SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(child: _subtitle()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child(user.uniqueId + '/' + device[0] + '.jpg');
    url = await firebaseStorageRef.getDownloadURL();
    print('image received');
    url = await firebaseStorageRef.getDownloadURL();
  }

  Widget showImage() {
    return FutureBuilder(
      future: getImage(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && url != '')
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: CachedNetworkImage(
              imageUrl: url,
              useOldImageOnUrlChange: true,
              // child: Image.network(
              //   url,
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 2.5,
              fit: BoxFit.fill,
              // ),
            ),
          );

        if (snapshot.connectionState == ConnectionState.done && url == '')
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: Image.asset(
              'assets/room.jpg',
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 2.5,
              fit: BoxFit.fill,
            ),
          );

        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();

        return Text('error');
      },
    );
  }
}
