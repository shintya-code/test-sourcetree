import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../model/post.dart';
import '../../../utils/register.dart';
import '../../screen.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditList03 extends StatefulWidget {
  final Post post;

  const EditList03(
      this.post
      );

  @override
  State<EditList03> createState() => _EditList03State();
}

class _EditList03State extends State<EditList03> {
  File? image01;
  File? image02;
  File? image03;
  File? image04;
  String qr01 = "";
  String qr02 = "";
  String qr03 = "";
  String qr04 = "";
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QRリスト編集",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                width: 300,
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "New name",
                      hintText: widget.post.tableTitle
                  ),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Center(child: Text("画像をタップして変更",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: GestureDetector(
                        onTap: () async{
                          var result = await Register.GetImageFromGallery();
                          await _cropImage(File(result.path),1);
                        },
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: image01 == null ? BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.post.imagePath1)
                              )
                          ) : BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(image01!)
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: GestureDetector(
                        onTap: () async{
                          var result = await Register.GetImageFromGallery();
                          await _cropImage(File(result.path),2);
                        },
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: image02 == null ? BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.post.imagePath2!)
                              )
                          ) : BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(image02!)
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: GestureDetector(
                        onTap: () async{
                          var result = await Register.GetImageFromGallery();
                          await _cropImage(File(result.path),3);
                        },
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: image03 == null ? BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.post.imagePath3!)
                              )
                          ) : BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(image03!)
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 75,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => CupertinoAlertDialog(
                              title: Text("QRリスト削除"),
                              content: Text("本当にこのQRリストを削除しますか"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text("戻る"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                CupertinoDialogAction(
                                  child: Text("削除"),
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Register.DeletePost(widget.post);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Screen()));
                                  },
                                ),
                              ],
                            ),
                          ),
                          child: Text("削除",
                            style: TextStyle(fontSize: 15),)
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 75,
                      child: ElevatedButton(
                          onPressed: () async{
                            if(titleController.text.isNotEmpty){
                              widget.post.tableTitle = titleController.text;
                              if(image01 != null){
                                var editImage01 = await Register.EditImageFromGallery(widget.post.tableId,"1",image01!);
                                widget.post.imagePath1 = editImage01.toString();
                              }
                              if(image02 != null){
                                var editImage02 = await Register.EditImageFromGallery(widget.post.tableId,"2",image02!);
                                widget.post.imagePath2 = editImage02.toString();
                              }
                              if(image03 != null){
                                var editImage03 = await Register.EditImageFromGallery(widget.post.tableId,"3",image03!);
                                widget.post.imagePath3 = editImage03.toString();
                              }
                              widget.post.updatedTime = Timestamp.now();
                              widget.post.qrPath1 = qr01;
                              widget.post.qrPath2 = qr02;
                              widget.post.qrPath3 = qr03;
                              widget.post.qrPath4 = qr04;
                              Register.editPost(widget.post);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Screen()));
                            }
                          },
                          child: Text("変更",style: TextStyle(fontSize: 15),)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _cropImage(File? imageFile,int i) async {

    bool isLoading = false;
    File? keepImageFile = imageFile;

    void startLoading() {
      setState(() {
        isLoading = true;
      });
    }

    void endLoading() {
      setState(() {
        isLoading = false;
      });
    }

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      compressQuality: 15,
      aspectRatio: CropAspectRatio(ratioX: 10, ratioY: 10),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '表示部分を切り取り',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: '表示部分を切り取り',
          // キャンセル時の警告
          showCancelConfirmationDialog: false,
          // 完了時のシェアボタン
          showActivitySheetOnDone: false,
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
          doneButtonTitle: "完了",
          cancelButtonTitle: "戻る",
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      File image = File(croppedFile.path);
      imageFile = image;
    }

    //--------------ここから-----------------

    startLoading();
    //file -> base64
    List<int> imageBytes = imageFile!.readAsBytesSync();
    String base64Image = await base64Encode(imageBytes);
    Uri url = Uri.parse('http://157.7.215.192:10/qrcode');
    String body = json.encode({
      'post_img': base64Image,
    });

    //send to backend
    Response response = await http.post(url, body: body);

    //base64 -> file
    // final data = json.decode(response.body);
    var data= await json.decode(json.encode(response.body));
    // List<String> qrUrl = [];

    // print("ここdata: $data");

    endLoading();

    //--------------ここまで追加-----------------

    setState(() {
      if(i == 1){
        image01 = imageFile;
        qr01 = data;
      }else if(i == 2){
        image02 = imageFile;
        qr02 = data;
      }else if(i == 3){
        image03 = imageFile;
        qr03 = data;
      }else{
        image04 = imageFile;
        qr04 = data;
      }
    });
  }


}
