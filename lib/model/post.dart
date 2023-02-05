import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  String currentUser;
  String tableId;
  String tableTitle;
  String columnNo;
  String imagePath1;
  String? imagePath2;
  String? imagePath3;
  String? imagePath4;
  String qrPath1;
  String? qrPath2;
  String? qrPath3;
  String? qrPath4;
  Timestamp createdTime;
  Timestamp? updatedTime;

  Post({
    required this.currentUser,
    required this.tableId,
    required this.tableTitle,
    required this.columnNo,
    required this.imagePath1,
    this.imagePath2,
    this.imagePath3,
    this.imagePath4,
    required this.qrPath1,
    this.qrPath2,
    this.qrPath3,
    this.qrPath4,
    required this.createdTime,
    this.updatedTime
  });

}