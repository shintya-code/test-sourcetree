import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/myuser.dart';
import '../authentication.dart';

class UserFirestore{
//  いつものfirebseのfirestoreに接続
  static final firestoreInstance = FirebaseFirestore.instance;
  // ユーザコレクションの値を取ってこれる
  static final CollectionReference users = firestoreInstance.collection("users");

//  実際にユーザをDBに追加するメソッド
  static Future<dynamic> setUser(MyUser newUser,String uid) async{
    print("ここまで来てる");
    try{
      //newAccountのidドキュメントを作る事ができる
      await users.doc(uid).set({
        "name": newUser.name,
        "created_time": Timestamp.now(),
        "updated_time": Timestamp.now(),
      });
      print("新規ユーザ作成完了");
      return true;
    }on FirebaseException catch(e){
      print("新規ユーザ作成エラー $e");
      return false;
    }
  }

// アカウントをfirebaseから取得してくる
  // uidでどのアカウント情報を取ってくるか判別する
  static Future<dynamic> getUser(String uid) async{
    try{
      // 送られてきたuidの内容をgetするよ
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      //ドキュメント型からここでMap型に型変換してるんだけどエラー発生
      Map<String, dynamic> data = documentSnapshot.data() as Map<String,dynamic>;
      // アカウントインスタンスにアカウント情報を入れる
      MyUser myUser = MyUser(
        name: data["name"],
        createdTime: data["created_time"],
        updatedTime: data["updated_time"],
      );
      // AuthenticationのmyAccountに上で追加したアカウント情報を入れる
      Authentication.myuser = myUser;

      print("ユーザ取得完了");
      return true;
    }on FirebaseException catch(e){
      print("ユーザ取得エラー $e");
      return false;
    }
  }
//
//   // ユーザを更新するメソッド
//   // どのユーザ情報を更新するか判断するためにAccount情報を取ってくる
//   static Future<dynamic> updateUser(Account updateAccount) async{
//     try{
//       // これが更新処理
//       await users.doc(updateAccount.id).update({
//         "name":updateAccount.name,
//         "image_path":updateAccount.imagePath,
//         "user_id":updateAccount.userId,
//         "self_introduction": updateAccount.selfIntroduction,
//         "updated_time": Timestamp.now(),
//       });
//       print("ユーザ情報の更新完了");
//       return true;
//     }on FirebaseException catch(e){
//       print("ユーザ情報の更新エラー $e");
//       return false;
//     }
//   }
//
//   // 投稿してるユーザの情報を取ってくるメソッド
// //  ユーザのアカウントidを知った上でその情報をfirebaseから取ってくる
//   static Future<Map<String, Account>?> getPostUserMap(List<String> accountIds) async{
//     Map<String, Account> map = {};
//     try{
//       await Future.forEach(accountIds, (String accountId) async{
//         // アカウントidを用いて情報を順次getしていく
//         var doc = await users.doc(accountId).get();
//         // オブジェクト型からMap型に変換
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         // 現在参照中のアカウント情報をインスタンスに入れる
//         Account postAccount = Account(
//             id: accountId,
//             name: data["name"],
//             imagePath: data["image_path"],
//             selfIntroduction: data["self_introduction"],
//             userId: data["user_id"],
//             createdTime: data["created_time"],
//             updatedTime: data["updated_time"]
//         );
//         // Map型のmapに追加していく。尚、場所は「accountId」に追加
//         map[accountId] = postAccount;
//       });
//       print("投稿ユーザの情報取得完了");
//       return map;
//     }on FirebaseException catch(e){
//       print("投稿ユーザの情報取得エラー $e");
//       return null;
//     }
//   }
//
//   // firebase内のusersコレクションの中にあるaccountIdのドキュメントを削除するメソッド
//   static Future<dynamic> deleteUser(String accountId) async{
//     users.doc(accountId).delete();
//     PostFirestore.deletePosts(accountId);
//   }

}