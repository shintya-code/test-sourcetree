import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_read/model/post.dart';
import 'package:qr_code_read/view/camera_page/read_nfc.dart';
import 'package:qr_code_read/view/test_qr.dart';
import 'package:qr_code_read/view/write_nfc.dart';

class DisplayList01 extends StatefulWidget {
  final Post post;

  const DisplayList01(this.post);

  @override
  State<DisplayList01> createState() => _DisplayList01State();
}

class _DisplayList01State extends State<DisplayList01> {
  int selectedIndex = 0;

  List<Widget> selectedList = [
    TestQr(),
    ReadNfc(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.post.tableTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                child: Center(
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.post.imagePath1))),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 300,
                child: Center(
                  child: TextButton(
                    onLongPress: (){

                    },
                    onPressed: () {

                    },
                    child: Text(widget.post.qrPath1,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.speaker_phone_outlined,
              color: Colors.red,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tap_and_play_outlined,
              color: Colors.red,
            ),
            label: "",
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => selectedList[index]));
        },
      ),
    );
  }
}
