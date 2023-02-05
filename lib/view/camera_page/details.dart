import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  @override
  DetailsPage(this.name);
  String name;

  void _opneUrl(String _url,) async {
    final url = Uri.parse(_url);

    // URLが有効な場合は、「launchUrl」メソッドを実行
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        // デフォルトだとアプリ内WebViewになっておりブラウザを起動させたい場合はこの引数が必要
        // mode: LaunchMode.externalApplication,
      );
      // URLが無効の場合はエラーをスロー
    }  else {
      throw 'このURLにはアクセスできません';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QR Details',style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Card(
                child: ListTile(
                    leading: Icon(Icons.label_important),
                    title: Text(name),
                    onTap: () {
                      _opneUrl(name);
                    }),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  QrImage(
                    data: name,
                    size: 200,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}