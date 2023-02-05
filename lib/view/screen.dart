import 'package:flutter/material.dart';
import 'package:qr_code_read/view/conf_page/conf.dart';
import 'package:qr_code_read/view/top_page.dart';

import 'camera_page/select_nfc_camera.dart';


//test_ここ変更入れた

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;
  List<Widget> selectedList = [
    TopPage(),
    SelectNfcCamera(),
    Conf(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,color: Colors.blue,),
              label: "",
              activeIcon: Icon(Icons.home,color: Colors.blue,),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_outlined,color: Colors.blue,),
              label: "",
            activeIcon: Icon(Icons.qr_code_2,color: Colors.blue,),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.room_preferences_outlined,color: Colors.blue,),
              label: "",
            activeIcon: Icon(Icons.room_preferences_rounded,color: Colors.blue,),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIconTheme:IconThemeData(
            size: 33
          ),
        unselectedIconTheme: IconThemeData(
          size: 25
        ),
      ),
    );
  }
}
