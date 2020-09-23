import 'package:flutter/cupertino.dart';

class Data {
  final String name;
  final String emailId;
  final String uniqueId;
  final List<List<String>> deviceList;

  Data(
  {@required this.name,
  @required this.emailId,
  @required this.deviceList,
  @required this.uniqueId,});
}