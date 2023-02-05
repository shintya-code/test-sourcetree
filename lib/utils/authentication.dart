import 'package:firebase_auth/firebase_auth.dart';

import '../model/myuser.dart';

class Authentication{
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // 現在ログイン中のユーザ
  static User? currentFirebaseUser;
  static MyUser? myuser;

  // サインアップするアカウントを作る処理
  // サインアップする時はメアドとパスをもらう
  static Future<dynamic> signUp({required String email,required String pass}) async{
    try{
      // サインアップの処理
      //createUserWithEmailAndPasswordはパスとメールを使ってアカウントを作成
      //createUserで「今作られているアカウントはこうゆうユーザですよ」と情報を取れる
      UserCredential newUser = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      print("auth登録完了");
      //今作ったユーザ情報を返す
      return newUser;
    }on FirebaseAuthException catch(e){
      print("auth登録エラー $e");
      if(e.code == "email-already-in-use") {
        return "指定されたメールアドレスは登録済みです。";
      }else if(e.code == "invalid-email") {
        return "メールアドレスの形式が正しくありません。";
      }else if(e.code == "operation-not-allowed") {
        return "指定したメールアドレス・パスワードは現在使用できません。";
      }else if(e.code == "weak-password") {
        return "パスワードは６文字以上に設定してください。";
      }
      return false;
    }
  }


//  サインインする処理
  static Future<dynamic> emailSignIn({required String email,required String pass}) async{
    try{
      //サインインの処理
      //signInWithEmailAndPasswordはメールとパスを使ってfirebase内のアカウント認証をする
      final UserCredential _result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass
      );

      // カレントユーザーをログインしたユーザに変更する
      currentFirebaseUser = _result.user;
      print("authサインイン完了");
      return _result;

    }on FirebaseAuthException catch(e){
      print("authサインインエラー $e");
      if(e.code == "invalid-email") {
        return "メールアドレスの形式が正しくありません。";
      }else if(e.code == "user-disabled") {
        return "現在指定したメールアドレスは使用できません。";
      }else if(e.code == "user-not-found") {
        return "指定したメールアドレスは登録されていません。";
      }else if(e.code == "wrong-password") {
        return "パスワードが間違っています。";
      }
      return false;
    }

  }

  // サインアウトのメソッド
  static Future<void> signOut() async{
    await firebaseAuth.signOut();
  }

  //アカウント削除のメソッド
  static Future<void> deleteAuth() async{
    // これでログイン中のユーザを削除できる
    currentFirebaseUser!.delete();
  }

}