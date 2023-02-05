import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_read/model/post.dart';
import 'package:qr_code_read/utils/authentication.dart';
import 'package:qr_code_read/utils/register.dart';
import '../../../screen.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AddListThird01 extends StatefulWidget {
  String selected;
  String titleName;
  AddListThird01(this.selected,this.titleName);

  @override
  State<AddListThird01> createState() => _AddListThird01State();
}

class _AddListThird01State extends State<AddListThird01> {
  File? image01;
  File? image02;
  File? image03;
  File? image04;
  String qr01 = "";
  String qr02 = "";
  String qr03 = "";
  String qr04 = "";

  File? localImageFile;
  static final firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference list = firestoreInstance.collection("qrlist");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("画像を設定",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Container(
                child: Center(child: Text("タイトル",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)),
              ),
              SizedBox(height: 10,),
              Container(
                child: Center(child: Text(widget.titleName,style: TextStyle(color: Colors.grey,fontSize: 25,fontWeight: FontWeight.bold),)),
              ),
              SizedBox(height: 30,),
              Container(
                child: Center(child: Text("QRコード画像を挿入",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
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
                            if(result != null){
                              setState(() {
                                // image01 = localImageFile;
                              });
                            }
                          },
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: image01 == null ? BoxDecoration(
                              color: Colors.green[400]
                            ) : BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(image01!)
                                )
                            ),
                            child: Icon(Icons.add,color: Colors.white,size: 60,),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              SizedBox(
                height: 40,
                width: 75,
                child: ElevatedButton(
                    onPressed: () async{
                      if(image01 != null){
                        Post result = await Post(
                          currentUser: Authentication.currentFirebaseUser!.uid.toString(),
                          tableId: "",
                          tableTitle: widget.titleName,
                          columnNo: widget.selected,
                          imagePath1: "",
                          qrPath1: qr01,
                          qrPath2: qr02,
                          qrPath3: qr03,
                          qrPath4: qr04,
                          createdTime: Timestamp.now(),
                        );
                        await Register.createPost(result,image01);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Screen()));
                      }
                      },
                    child: Text("完成",style: TextStyle(fontSize: 15),)
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
