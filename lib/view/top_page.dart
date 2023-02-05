import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_read/model/post.dart';
import 'package:qr_code_read/utils/authentication.dart';

import 'QR_page/create_list/add_list_top.dart';
import 'QR_page/display/display_list01.dart';
import 'QR_page/display/display_list02.dart';
import 'QR_page/display/display_list03.dart';
import 'QR_page/display/display_list04.dart';
import 'QR_page/edit/edit_list1.dart';
import 'QR_page/edit/edit_list2.dart';
import 'QR_page/edit/edit_list3.dart';
import 'QR_page/edit/edit_list4.dart';


class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  static final firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference list = firestoreInstance.collection("qrlist");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("TOP",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: StreamBuilder<QuerySnapshot>(
          stream: list.orderBy("created_time",descending: true).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }
            if(!snapshot.hasData){
              return Center(child: Text("データがありません"));
            }
            final docs = snapshot.data!.docs;

            return Container(
              child: ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = docs[index].data() as Map<String, dynamic>;

                  if(data["current_user"] == Authentication.currentFirebaseUser!.uid){
                    final Post postList = Post(
                        currentUser: data["current_user"],
                        tableId: docs[index].id,
                        tableTitle: data["table_title"],
                        columnNo: data["column_no"],
                        imagePath1: data["image_path01"],
                        imagePath2: data["image_path02"],
                        imagePath3: data["image_path03"],
                        imagePath4: data["image_path04"],
                        qrPath1: data["qr_path01"],
                        qrPath2: data["qr_path02"],
                        qrPath3: data["qr_path03"],
                        qrPath4: data["qr_path04"],
                        createdTime: data["created_time"],
                        updatedTime: data["updated_time"]
                    );

                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          if(postList.columnNo == "1"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayList01(postList)));
                          }else if(postList.columnNo == "2"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayList02(postList)));
                          }else if(postList.columnNo == "3"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayList03(postList)));
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayList04(postList)));
                          }
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2,color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.yellow[50],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey, //色
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.qr_code_rounded),
                                          Text(postList.tableTitle,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: (){
                                                  if(postList.columnNo == "1"){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditList01(postList)));
                                                  }else if(postList.columnNo == "2"){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditList02(postList)));
                                                  }else if(postList.columnNo == "3"){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditList03(postList)));
                                                  }else{
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditList04(postList)));
                                                  }
                                                },
                                                child: Text("編集"),
                                              ),
                                              SizedBox(width: 5,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }else{
                    return Container(
                    );
                  }
                },
              ),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddListTop()));
        },
        child: Icon(Icons.add,),
      ),
    );
  }
}
