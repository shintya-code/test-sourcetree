import 'package:flutter/material.dart';
import 'package:qr_code_read/model/post.dart';

class WriteNfc extends StatefulWidget {
  String url1 = "";
  String url2 = "";
  String url3 = "";
  String url4 = "";


  @override
  State<WriteNfc> createState() => _WriteNfcState();
}

class _WriteNfcState extends State<WriteNfc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NFC書き込み"),
      ),
    );
  }
}
