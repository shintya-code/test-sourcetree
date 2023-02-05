import 'package:flutter/material.dart';
import 'create_page/add_list_third01.dart';
import 'create_page/add_list_third02.dart';
import 'create_page/add_list_third03.dart';
import 'create_page/add_list_third04.dart';

class AddListSecond extends StatelessWidget {
  TextEditingController titleController = TextEditingController();

  String selected;
  AddListSecond(this.selected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("タイトル設定",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 50,),
                Center(child: Text("タイトルを入力",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)),
                SizedBox(height: 30,),
                Container(
                  width: 300,
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                    hintText: "(例)LINE"
                  ),
                  ),
                ),
                SizedBox(height: 50,),
                SizedBox(
                  height: 40,
                  width: 75,
                  child: ElevatedButton(
                      onPressed: () {
                        if(titleController.text.isNotEmpty){
                          if(selected == "1"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddListThird01(selected,titleController.text)));
                          }else if(selected == "2"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddListThird02(selected,titleController.text)));
                          }else if(selected == "3"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddListThird03(selected,titleController.text)));
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddListThird04(selected,titleController.text)));
                          }
                        }
                      },
                      child: Text("次へ",style: TextStyle(fontSize: 15),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
