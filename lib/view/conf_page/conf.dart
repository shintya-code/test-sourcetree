
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_read/utils/authentication.dart';
import 'package:qr_code_read/view/start_up/login_page.dart';
import 'package:qr_code_read/view/conf_page/test.dart';

class Conf extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("情報",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 40,),
              Card(
                child: ListTile(
                  leading: Icon(Icons.app_registration),
                  title: Center(child: Text("このアプリについて")),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.book_outlined),
                  title: Text("bbbb"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.book_outlined),
                  title: Text("cccc"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.book_outlined),
                  title: Text("dddd"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
                  },
                ),
              ),
              SizedBox(height: 80,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text("確認"),
                      content: Text("サインアウトしますか"),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text("戻る"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoDialogAction(
                          child: Text("実行"),
                          isDestructiveAction: true,
                          onPressed: () {
                            Authentication.signOut();
                            while(Navigator.canPop(context)){
                              Navigator.pop(context);
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                  child: Text("サインアウト",
                    style: TextStyle(fontSize: 15),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
