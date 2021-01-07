import 'package:firebase_database/firebase_database.dart';

import '../Data.dart';

final databaseReference = FirebaseDatabase.instance.reference();

void sendTimeDb(String alarmTime, String switchNo,Data user,List<String> devices){
  DatabaseReference ref = databaseReference.child("users").child(user.uniqueId).child("devices").child(devices[2]).child("Switch-list").child(switchNo);
  ref.update({"Alarm Time": alarmTime});
}

Future<String> retrieveTimeDb(String alarmTime, String switchNo,Data user,List<String> device) async{
  await databaseReference
      .child("users")
      .child(user.uniqueId)
      .child("devices")
      .child(device[2])
      .child("Switch-list").child(switchNo).reference()
      .once().then((DataSnapshot snap) async{
    alarmTime = snap.value['Alarm Time'];
  });
  return alarmTime;
}

void deleteTime(String switchNo,Data user,List<String> device) async{
  await databaseReference
      .child("users")
      .reference()
      .child(user.uniqueId)
      .reference()
      .child("devices").child(device[2]).child(switchNo).child("Alarm Time").remove();
}
