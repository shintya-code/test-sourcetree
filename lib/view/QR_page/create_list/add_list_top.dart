import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'add_list_second.dart';

class AddListTop extends StatefulWidget {
  const AddListTop({Key? key}) : super(key: key);

  @override
  State<AddListTop> createState() => _AddListTopState();
}

class _AddListTopState extends State<AddListTop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QRリスト設定",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Center(child: Text("パターンを選択",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                    child: GestureDetector(
                      onTap: () async{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddListSecond("1")));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2,color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("１つ表示",style: TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddListSecond("2")));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2,color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("２つ表示",style: TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddListSecond("3")));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2,color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("３つ表示",style: TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddListSecond("4")));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2,color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("４つ表示",style: TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
