import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_read/utils/authentication.dart';

import 'read_nfc.dart';
import 'details.dart';
import 'add_camera.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 右上に表示される"debug"ラベルを消す
      debugShowCheckedModeBanner: false,
      // リスト一覧画面を表示
      home: SelectNfcCamera(),
    );
  }
}

// リスト一覧画面用Widget
class SelectNfcCamera extends StatefulWidget {
  @override
  _SelectNfcCameraState createState() => _SelectNfcCameraState();
}

class _SelectNfcCameraState extends State<SelectNfcCamera> {
  String? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("QR読み込み",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 175,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2,color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellow[50],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey, //色
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(context: context, builder: (context){
                                return SafeArea(
                                    child: Container(
                                      width: double.infinity,
                                      height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReadNfc()));
                                                  },
                                                  child: Center(child: Text("QRを渡す",style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  ),)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReadNfc()));
                                                  },
                                                  child: Center(child: Text("QRを受け取る",style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  ),)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              });
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNfc()));
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2,color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue[300],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black, //色
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: IconButton(
                                          iconSize: 75,
                                          color: Colors.white,
                                          onPressed: () {
                                            // ここに完成したNFCのURLを設定。
                                              showModalBottomSheet(context: context, builder: (context){
                                                return SafeArea(
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 100,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReadNfc()));
                                                                  },
                                                                  child: Center(child: Text("データを渡す",style: TextStyle(
                                                                    fontWeight: FontWeight.bold
                                                                  ),)),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReadNfc()));
                                                                  },
                                                                  child: Center(child: Text("データを受け取る",style: TextStyle(
                                                                    fontWeight: FontWeight.bold
                                                                  ),)),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                              });
                                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNfc()));
                                          },
                                          icon: Icon(Icons.nfc),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text("タッチ接続",style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),         //Icon(Icons.connect_without_contact)
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => QRAddPage()));
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2,color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue[300],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black, //色
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: IconButton(
                                          iconSize: 75,
                                          color: Colors.white,
                                          onPressed: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => QRAddPage()));
                                          },
                                          icon: Icon(Icons.qr_code_scanner_rounded)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text("カメラで読み取る",style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                color: Colors.redAccent,
                child: Center(child: Text("読み込み履歴",style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                ),)),
              ),
              Flexible(
                child: Container(
                  color: Colors.red[50],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('QR').orderBy("created_day",descending: true).snapshots(),
                      builder: (
                          BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(!snapshot.hasData){
                          return Container();
                        }else{
                          return ListView(
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              if(document.get("current_user") == Authentication.currentFirebaseUser!.uid){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 20),
                                        child: Container(
                                          child: Text(DateFormat("yyyy/M/d    H:m").format(document.get("created_day").toDate())),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: Icon(Icons.add_link_outlined),
                                          title: Text(document.get('text')),
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(document.get('text'))),);
                                          },
                                          trailing: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                            onPressed: () async{
                                              await FirebaseFirestore.instance
                                                  .collection('QR')
                                                  .doc(document.id)
                                                  .delete();
                                            },
                                            child: Text("削除"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }else{
                                return Container();
                              }
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
