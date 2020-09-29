



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teco1/Data.dart';
import 'package:teco1/pages/HomePage.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
SharedPreferences preferences;

Future userData(User user, BuildContext context) async{
  DocumentReference ref = _db.collection("users").doc(user.uid);
  DocumentSnapshot ds = await ref.get();

  if(!ds.exists){
    preferences = await SharedPreferences.getInstance();
    preferences.setBool('Display', true);
    preferences.setBool('DisplayShowcase', true);
    preferences.setBool('FirstDisplay', false);

    await ref.set({
      'name' : user.displayName,
      "email" : user.email,
      "uniqueId" : user.uid,
    },SetOptions(merge:true));
  }
  else {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool('Display', false);
    preferences.setBool('FirstDisplay', false);
  }

}

void uploadData(Data user, BuildContext context){
  CollectionReference collectionReference  = _db.collection("users").doc(user.uniqueId).collection("devices");
  DocumentReference ref = collectionReference.doc();
  user.deviceList.last.add(ref.id);
  ref.set({
    'Device Id':user.deviceList.last[0],
    'Bedroom' : user.deviceList.last[1],
    'Time Of Creation': DateTime.now().millisecondsSinceEpoch
  },SetOptions(merge: true));
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (context) {
      return ProfilePage(
        personData: user,
      );
    },
  ), (route) => false);

}


Future googleUserData(GoogleSignInAccount googleSignInAccount,
    BuildContext context, User user, bool path) async {

  await _db.collection('users').doc(user.uid).set({
    "name": googleSignInAccount.displayName,
    "email": googleSignInAccount.email,
    "uniqueId": user.uid,

  }, SetOptions(merge: true));
  if (path) {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool('Display', true);
    preferences.setBool('DisplayShowcase', true);
  }
}

void deleteData(Data user, List<String> devicelist) async{
  CollectionReference reference = _db.collection("users").doc(user.uniqueId).collection("devices");
  
  await reference.doc(devicelist[2]).collection("Switch-list").get().then((snapshot){
    for (DocumentSnapshot ds in snapshot.docs){
      ds.reference.delete();
    }
  });
  await reference.doc(devicelist[2]).delete();
}



