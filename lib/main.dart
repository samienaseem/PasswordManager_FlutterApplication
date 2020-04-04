import 'package:flutter/material.dart';
import 'package:passwordmanager/model/passowrd.dart';
import 'package:passwordmanager/screens/testScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passwordmanager/DbHelper/dbhelper.dart';
import 'package:passwordmanager/screens/Passwordetails.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Password Manager',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Pocket Passwords'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DbHelper dbHelper=new DbHelper();
  List<PasswordManger> lists;
  int count=0;
  int _counter = 0;


    _incrementCounter() async  {
     SharedPreferences sh= await SharedPreferences.getInstance();
    sh.setInt('counter', _counter);
      if(sh.getInt('counter')==0){
        /*sh.setInt('counter', _counter);
        _counter++;*/
        _counter++;
        //DialogClass();
        debugPrint("Null $_counter");
      }
      else{
        /*int a = sh.getInt('counter');
        debugPrint(a.toString());
        _counter=a;
        _counter++;*/
        debugPrint("not Null"+_counter.toString());
        //DialogClass();
      }


      //sh.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {



    if(lists==null){
        lists=List<PasswordManger>();
        getData();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Container(
        padding: EdgeInsets.all(5.0),
        child: PasswordListitems(),
        //PasswordListitems(), // //DialogClass()//
      ),
      /*Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          NavigateToDetails();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ListView PasswordListitems() {

    return ListView.builder(
        itemCount: count,
        itemBuilder:(context,position){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text((position+1).toString(),
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              title: Text(this.lists[position].title,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
              subtitle: Text(lists[position].email),
              onTap: (){
                  debugPrint("Tapped on"+position.toString());
              },
            ),
          );

        },
    );
  }

  void getData() {
    final dbfuture=dbHelper.initDatabase();
    dbfuture.then((result){
        final Passfuture=dbHelper.getPasswords();
        Passfuture.then((result){
          List<PasswordManger> pm=List<PasswordManger>();
           count=result.length;
          for(int i=0;i<count;i++){
            pm.add(PasswordManger.FromObject(result[i]));
          }
          setState(() {
            lists=pm;
            count=count;

          });
        });
    });
  }

  void NavigateToDetails()async {
      bool result=await Navigator.push(context,
      MaterialPageRoute(builder: (context)=>PasswordDetails())
      );
  }

  void showAlert(BuildContext context) {
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

  /*@override
  void initState() {
      _incrementCounter();
  }*/
     }



}
