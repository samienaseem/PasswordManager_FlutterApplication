import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/model/passowrd.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passwordmanager/DbHelper/dbhelper.dart';
import 'package:passwordmanager/screens/Passwordetails.dart';


class Test extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>teststate();

}
class teststate extends State {
  SharedPreferences sh;
  AlertDialog alertDialog;
  String user = "samie";
  bool flag;
  TextEditingController password = TextEditingController();

  int _counter = 0;

  // String user="";


  _incrementCounter() async {
    sh = await SharedPreferences.getInstance();
    sh.setString('password', user);
    String a = sh.getString('password');
    debugPrint("Hello1213134" + a);
    user = a;
  }


  @override
  void initState() {
    _incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    print("object");
    /*if(user==null){
      Future.delayed(Duration.zero,()=>showAlert(context));
    }*/
      return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Future.delayed(Duration.zero,()=>showAlert(context));

            ],
          ),
        ),
      );





    }

   showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
  }
