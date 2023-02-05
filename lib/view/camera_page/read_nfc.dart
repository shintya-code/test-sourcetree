
import 'package:flutter/material.dart';

class ReadNfc extends StatefulWidget {
  const ReadNfc({Key? key}) : super(key: key);

  @override
  State<ReadNfc> createState() => _ReadNfcState();
}

class _ReadNfcState extends State<ReadNfc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NFC",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Container(),
    );
  }
}
