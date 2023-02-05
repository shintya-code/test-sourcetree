import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_read/model/myuser.dart';
import '../../utils/authentication.dart';
import '../../utils/firestore/users.dart';


class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 文言を変えるだけで編集ページと同じUIだからフレームワーク化した
        appBar: AppBar(
          title: Text("新規登録"),
        ),
        // キーボードが出てきた時にエラーが起こらないし、入力中もスクロールできる
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 30,),
                Container(
                  width: 300,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "名前"
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),              child: Container(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "メールアドレス"
                    ),
                  ),
                ),
                ),
                Container(
                  width: 300,
                  child: TextField(
                    controller: passController,
                    decoration: InputDecoration(
                        hintText: "パスワード"
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                ElevatedButton(
                  onPressed: () async{
                    if(nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        passController.text.isNotEmpty) {
                      // authenticationファイルに飛んで、アカウントを作成する
                      var result = await  Authentication.signUp(email: emailController.text, pass: passController.text);
                      //返ってきた値がUserCredential型だったらユーザ作れてる。
                      //返ってきた値がfalseの場合はbool型だからユーザ作れてない。
                      if(result is UserCredential){
                        MyUser newUser = MyUser(
                            name: nameController.text,
                            createdTime: Timestamp.now()
                        );
                        await UserFirestore.setUser(newUser,result.user!.uid);
                        if(result == true){
                          Navigator.pop(context);
                        }
                        Navigator.pop(context);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result),
                          ),
                        );
                      }
                    }
                  },
                  child: Text("アカウントを作成"),),
              ],
            ),
          ),
        )
    );
  }
}