import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:qr_code_read/utils/authentication.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRAddPage extends StatefulWidget {
  @override
  _QRAddPageState createState() => _QRAddPageState();
}

class _QRAddPageState extends State<QRAddPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String _text = '';
  final myController = TextEditingController();
  final upDateController = TextEditingController();

  // データを元に表示するWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            // 入力されたテキストを表示
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Text("読み込んだURL：",
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ),
                ),
                Container(
                    child: Flexible(
                      child: Text(_text,
                          style: TextStyle(color: Colors.blue, fontSize: 20)),
                    ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(flex: 4, child: _buildQrView(context)),
            const SizedBox(height: 10),
            const Text(
              '枠の中にQRコードをかざしてください',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 30),
            Container(
              // 横幅いっぱいに広げる
              // width: double.infinity,
              height: 50,
              width: 100,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: () async {
                  // final date =
                  // DateTime.now().toLocal().toIso8601String(); // 現在の日時
                  // Firebaseにデータを追加し、"pop"で前の画面に戻る
                  await FirebaseFirestore.instance
                      .collection('QR') // コレクションID
                      .doc() // ドキュメントID
                      .set({
                    "current_user": Authentication.currentFirebaseUser!.uid,
                    "created_day": Timestamp.now(),
                    'text': _text
                  });
                  Navigator.of(context).pop();
                },
                child: Text('追加',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // デバイスの幅や高さを確認し、それに応じてscanAreaとoverlayを変更
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    // Scannerビューが回転した後、適切にサイズ変更されるようにするために
    //  Flutter SizeChanged 通知をリスニングし、コントローラを更新する必要があります。
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _text = scanData.code.toString();
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
