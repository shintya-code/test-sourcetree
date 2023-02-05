import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_read/model/post.dart';

class Register{

  static Future<dynamic> GetImageFromGallery() async{
    ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  static Future<String> SetImageFromGallery(String pid,String imageNo,File image) async{
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference ref = storageInstance.ref();

    await ref.child(pid+imageNo).putFile(image);

    String downloadUrl = await storageInstance.ref(pid+imageNo).getDownloadURL();
    print("image_path: $downloadUrl");
    return downloadUrl;
  }


  static Future<String> EditImageFromGallery(String pid,String imageNo,File image) async{
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference ref = storageInstance.ref();

    DeleteImageFromGallery(pid, imageNo);
    await ref.child(pid+imageNo).putFile(image);

    String downloadUrl = await storageInstance.ref(pid+imageNo).getDownloadURL();
    print("image_path: $downloadUrl");
    return downloadUrl;
  }

  static Future<void> DeleteImageFromGallery(String pid,String imageNo) async{
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference ref = storageInstance.ref();

    ref.child(pid+imageNo).delete();
  }

    static Future<void> createPost(Post post, File? image01) async{
    final FirebaseFirestore instance = FirebaseFirestore.instance;
    final postCollection = instance.collection("qrlist");

    var addPost = await postCollection.add({
      "table_id": post.tableId,
      "table_title": post.tableTitle,
      "current_user": post.currentUser,
      "column_no": post.columnNo,
      "image_path01": post.imagePath1,
      "image_path02": post.imagePath2,
      "image_path03": post.imagePath3,
      "image_path04": post.imagePath4,
      "qr_path01": post.qrPath1,
      "qr_path02": post.qrPath2,
      "qr_path03": post.qrPath3,
      "qr_path04": post.qrPath4,
      "created_time": Timestamp.now(),
      "updated_time": Timestamp.now(),
    });

    var setImage01 = await SetImageFromGallery(addPost.id,"1",image01!);

    await postCollection.doc(addPost.id).update({
      "table_id": addPost.id,
      "image_path01": setImage01.toString(),
      "image_path02": post.imagePath2,
      "image_path03": post.imagePath3,
      "image_path04": post.imagePath4,
    });
  }

  static Future<void> createPost2(Post post, File? image01,File? image02) async{
    final FirebaseFirestore instance = FirebaseFirestore.instance;
    final postCollection = instance.collection("qrlist");

    var addPost = await postCollection.add({
      "table_id": post.tableId,
      "table_title": post.tableTitle,
      "current_user": post.currentUser,
      "column_no": post.columnNo,
      "image_path01": post.imagePath1,
      "image_path02": post.imagePath2,
      "image_path03": post.imagePath3,
      "image_path04": post.imagePath4,
      "qr_path01": post.qrPath1,
      "qr_path02": post.qrPath2,
      "qr_path03": post.qrPath3,
      "qr_path04": post.qrPath4,
      "created_time": Timestamp.now(),
      "updated_time": Timestamp.now(),
    });

    var setImage01 = await SetImageFromGallery(addPost.id,"1",image01!);
    var setImage02 = await SetImageFromGallery(addPost.id,"2",image02!);

    await postCollection.doc(addPost.id).update({
      "table_id": addPost.id,
      "image_path01": setImage01.toString(),
      "image_path02": setImage02.toString(),
      "image_path03": post.imagePath3,
      "image_path04": post.imagePath4,
    });
  }

  static Future<void> createPost3(Post post, File? image01,File? image02,File? image03) async{
    final FirebaseFirestore instance = FirebaseFirestore.instance;
    final postCollection = instance.collection("qrlist");

    var addPost = await postCollection.add({
      "table_id": post.tableId,
      "table_title": post.tableTitle,
      "current_user": post.currentUser,
      "column_no": post.columnNo,
      "image_path01": post.imagePath1,
      "image_path02": post.imagePath2,
      "image_path03": post.imagePath3,
      "image_path04": post.imagePath4,
      "qr_path01": post.qrPath1,
      "qr_path02": post.qrPath2,
      "qr_path03": post.qrPath3,
      "qr_path04": post.qrPath4,
      "created_time": Timestamp.now(),
      "updated_time": Timestamp.now(),
    });

    var setImage01 = await SetImageFromGallery(addPost.id,"1",image01!);
    var setImage02 = await SetImageFromGallery(addPost.id,"2",image02!);
    var setImage03 = await SetImageFromGallery(addPost.id,"3",image03!);

    await postCollection.doc(addPost.id).update({
      "table_id": addPost.id,
      "image_path01": setImage01.toString(),
      "image_path02": setImage02.toString(),
      "image_path03": setImage03.toString(),
      "image_path04": post.imagePath4,
    });
  }

  static Future<void> createPost4(Post post, File? image01,File? image02, File? image03,File? image04) async{
    final FirebaseFirestore instance = FirebaseFirestore.instance;
    final postCollection = instance.collection("qrlist");

    var addPost = await postCollection.add({
      "table_id": post.tableId,
      "table_title": post.tableTitle,
      "current_user": post.currentUser,
      "column_no": post.columnNo,
      "image_path01": post.imagePath1,
      "image_path02": post.imagePath2,
      "image_path03": post.imagePath3,
      "image_path04": post.imagePath4,
      "qr_path01": post.qrPath1,
      "qr_path02": post.qrPath2,
      "qr_path03": post.qrPath3,
      "qr_path04": post.qrPath4,
      "created_time": Timestamp.now(),
      "updated_time": Timestamp.now(),
    });

    var setImage01 = await SetImageFromGallery(addPost.id,"1",image01!);
    var setImage02 = await SetImageFromGallery(addPost.id,"2",image02!);
    var setImage03 = await SetImageFromGallery(addPost.id,"3",image03!);
    var setImage04 = await SetImageFromGallery(addPost.id,"4",image04!);

    await postCollection.doc(addPost.id).update({
      "table_id": addPost.id,
      "image_path01": setImage01.toString(),
      "image_path02": setImage02.toString(),
      "image_path03": setImage03.toString(),
      "image_path04": setImage04.toString(),
    });
  }

  static Future<void> editPost(Post post) async{
    final FirebaseFirestore instance = FirebaseFirestore.instance;
    final postCollection = instance.collection("qrlist");

    await postCollection.doc(post.tableId).update({
      "table_id": post.tableId,
      "table_title": post.tableTitle,
      "current_user": post.currentUser,
      "column_no": post.columnNo,
      "image_path01": post.imagePath1,
      "image_path02": post.imagePath2,
      "image_path03": post.imagePath3,
      "image_path04": post.imagePath4,
      "qr_path01": post.qrPath1,
      "qr_path02": post.qrPath2,
      "qr_path03": post.qrPath3,
      "qr_path04": post.qrPath4,
      "created_time": post.createdTime,
      "updated_time": Timestamp.now(),
    });
  }


  static Future<void> DeletePost(Post post) async{
    final FirebaseFirestore fire = FirebaseFirestore.instance;
    final doc = fire.collection("qrlist").doc(post.tableId);

    for(int i = 1; i <= int.parse(post.columnNo); i++){
      DeleteImageFromGallery(post.tableId, "$i");
    }
    await doc.delete();
  }

}