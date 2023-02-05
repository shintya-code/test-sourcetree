import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{
  String name;
  Timestamp createdTime;
  Timestamp? updatedTime;

  MyUser({
    required this.name,
    this.updatedTime,
    required this.createdTime
  });
}