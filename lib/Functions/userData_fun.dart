



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teco1/Data.dart';
import 'package:teco1/pages/HomePage.dart';



final databaseReference = FirebaseDatabase.instance.reference();

Future userData(User user, BuildContext context) async{
  DatabaseReference ref = databaseReference.child("users");
  DatabaseReference ref2 = ref.child(user.uid).reference().child("user_details").reference();

     ref2.set({
      'name' : user.displayName,
      "email" : user.email,
      "uniqueId" : user.uid,
    });


}

void uploadData(Data user, BuildContext context){

  DatabaseReference ref = databaseReference.child("users").reference().child(user.uniqueId).reference().child("devices");
  var item = ref.push();
user.deviceList.last.add(item.key);
print(item.key);
  item.set({
    'Device Id':user.deviceList.last[0],
    'Bedroom' : user.deviceList.last[1],
    'Time Of Creation': DateTime.now().millisecondsSinceEpoch
  });
  if(user.deviceList.last[0].contains("4s")) {

    ref.child(item.key).child("Switch-list").child("S1").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("S2").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("S3").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("S4").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("Fan").set({"Fan Speed":"0"});
  }

  if(user.deviceList.last[0].contains("8s")){
    ref.child(item.key).child("Switch-list").child("S1").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("S2").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("S3").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("S4").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("S5").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("S6").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("S7").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("S8").set({"switch value":"0"});
    ref.child(item.key).child("Switch-list").child("Fan").set({"Fan Speed":"0"});
  }



  
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (context) {
      return ProfilePage(
        personData: user,
      );
    },
  ), (route) => false);

}





void deleteData(Data user, List<String> devicelist) async {
  await databaseReference.child("users").reference().child(user.uniqueId)
      .reference().child("devices").reference().child(devicelist[2]).remove();
}

void checkData(Data user,String id, BuildContext context,String bedroom) async {
  await databaseReference.child("users").reference().child(user.uniqueId)
      .reference().child("devices").reference().once().then((DataSnapshot snapshot ) async {
        if(snapshot.value!=null) {
          Map v = {};
          v = await snapshot.value;
          print(v);
          List<String> listDev = [];
          for (String k in v.keys) {
            listDev.add(v[k]['Device Id']);
          }
          print(listDev);
          bool check;
          print("sucess");
          for (int i = 0; i < listDev.length; i++) {
            if (id == listDev[i]) {
              check = false;
              break;
            }
            else{
              check = true;
            }
          }

          print(check);
          if (check == true) {
            List<String> appl = [];
            appl.add(id);
            appl.add(bedroom);
            print(user.name + " " + "huiefhid");

            user.deviceList.add(appl);
            print(user.deviceList);
            DatabaseReference ref = databaseReference.child("users").reference()
                .child(user.uniqueId).reference()
                .child("devices");
            var item = ref.push();
            user.deviceList.last.add(item.key);
            print(item.key);
            item.set({
              'Device Id': user.deviceList.last[0],
              'Bedroom': user.deviceList.last[1],
              'Time Of Creation': DateTime
                  .now()
                  .millisecondsSinceEpoch
            });
            if (user.deviceList.last[0].contains("4s")) {
              ref.child(item.key).child("Switch-list").child("S1").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("S2").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("S3").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("S4").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("Fan").set(
                  {"Fan Speed": "0"});
            }

            if (user.deviceList.last[0].contains("8s")) {
              ref.child(item.key).child("Switch-list").child("S1").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("S2").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("S3").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("S4").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("S5").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("S6").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("S7").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("S8").set(
                  {"switch value": "0"});
              ref.child(item.key).child("Switch-list").child("Fan").set(
                  {"Fan Speed": "0"});
            }


            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return ProfilePage(
                  personData: user,
                );
              },
            ), (route) => false);
          }
          else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text(
                      'SAME DEVICE ID ',
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      'The Id you are trying to add already exists in your database. Please add a different id',
                      textAlign: TextAlign.center,
                    ),
                    elevation: 40,
                  );
                });
          }
        }
        else{
          List<String> appl = [];
          appl.add(id);
          appl.add(bedroom);
          print(user.name + " " + "huiefhid");

          user.deviceList.add(appl);
          print(user.deviceList);
          DatabaseReference ref = databaseReference.child("users").reference()
              .child(user.uniqueId).reference()
              .child("devices");
          var item = ref.push();
          user.deviceList.last.add(item.key);
          print(item.key);
          item.set({
            'Device Id': user.deviceList.last[0],
            'Bedroom': user.deviceList.last[1],
            'Time Of Creation': DateTime
                .now()
                .millisecondsSinceEpoch
          });
          if (user.deviceList.last[0].contains("4s")) {
            ref.child(item.key).child("Switch-list").child("S1").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("S2").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("S3").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("S4").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("Fan").set(
                {"Fan Speed": "0"});
          }

          if (user.deviceList.last[0].contains("8s")) {
            ref.child(item.key).child("Switch-list").child("S1").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("S2").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("S3").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("S4").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("S5").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("S6").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("S7").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("S8").set(
                {"switch value": "0"});
            ref.child(item.key).child("Switch-list").child("Fan").set(
                {"Fan Speed": "0"});
          }


          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return ProfilePage(
                personData: user,
              );
            },
          ), (route) => false);
        }


  });
}



