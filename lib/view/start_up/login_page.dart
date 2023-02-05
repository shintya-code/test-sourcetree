import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../utils/authentication.dart';
import '../../utils/firestore/users.dart';
import '../screen.dart';
import 'create_account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text("QReader",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              Padding(
                //symmetricをつけると要素の上下に余白をつけることができる。
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
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
              SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: "アカウントを作成していない方は"),
                      TextSpan(text: "こちら",style: TextStyle(color: Colors.blue),
                          // こちらをタップできる状態にし、タップした時の処理を書ける
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage()));
                          }
                      ),
                    ]
                ),
              ),
              SizedBox(height: 70,),
              ElevatedButton(
                onPressed: () async{
                  // 入力されているメールとパスのコントローラーを使ってアカウント認証
                  var result = await Authentication.emailSignIn(email: emailController.text, pass: passController.text);
                  // UserCredentialであればアカウントの作成はできてると判断できる
                  if(result is UserCredential){
                    var _result =  await UserFirestore.getUser(result.user!.uid);
                    if(_result == true){
                      // pushReplacementを使う事で動作後はこのページに戻れなくしている
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Screen()));
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(result),
                      ),
                    );
                  }
                },
                child: Text("Emailでログイン"),)
            ],
          ),
        ),
      ),
    );
  }
}