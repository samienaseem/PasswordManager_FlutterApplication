import 'package:flutter/material.dart';
import 'package:passwordmanager/model/passowrd.dart';
import 'package:passwordmanager/screens/testScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passwordmanager/DbHelper/dbhelper.dart';
import 'package:passwordmanager/DbHelper/dbshelper.dart';
import 'package:passwordmanager/screens/Passwordetails.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*DbsHelper helper=new DbsHelper();
    helper.initDatabase();
    PasswordManger passwordManger=new PasswordManger("samie", "saaaaaaa", "qweeeeeee");
    helper.insertEntry(passwordManger);*/




    return MaterialApp(
      title: 'Password Manager',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  //MyHomePage({Key ke=y, this.title}) : super(key: key);
  final String title="";


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _appbartitle=new Text("Pocket Passwords");
  Icon _searchIcon = new Icon(Icons.search);
  TextEditingController Ipass=TextEditingController();
  TextEditingController ICpass=TextEditingController();

  DbsHelper dbHelper=new DbsHelper();
  List<PasswordManger> lists;
  int count=0;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    initPrefrence();

  }
  Future<void> initPrefrence() async {
    final sh=await SharedPreferences.getInstance();
    String paswrd= await getPasswordFromShared();

    await sh.setString('passwordApp',paswrd);

    if(paswrd==""){
      Future.delayed(Duration.zero,()=>ShowAlertBox(context));
    }


  }

  Future<String> getPasswordFromShared()async {
    final sh=await SharedPreferences.getInstance();
    final str=sh.getString('passwordApp');

    if(str==null){
      return "";
    }
    return str;

  }


  @override
  Widget build(BuildContext context) {



    if(lists==null){
        lists=List<PasswordManger>();
        getData();
    }
    return Scaffold(

      appBar: AppBar(
        //leading: Icon(Icons.search),
        title: _appbartitle,
        actions: <Widget>[
          IconButton(
            onPressed: ()=>_searchPressed(),
            icon: Icon(_searchIcon.icon,color: Colors.white,),
          )
        ],
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
          NavigateToDetails(new PasswordManger("","",""));
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
                  //debugPrint("Tapped on"+position.toString());
                  NavigateToDetails(lists[position]);
                  //debugPrint(lists[position].password);
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

  void NavigateToDetails(PasswordManger pm)async {
      bool result=await Navigator.push(context,
      MaterialPageRoute(builder: (context)=>PasswordDetails(pm))
      );
      if(result==true){
        getData();
      }


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

  void _searchPressed() {
    setState(() {
      if(this._searchIcon.icon==Icons.search){
        this._searchIcon=new Icon(Icons.close);
        //debugPrint("$_searchIcon");
        this._appbartitle=new TextFormField(
          style: TextStyle(
            color: Colors.white,
            ),
          decoration: InputDecoration(
            border:InputBorder.none,

            prefixIcon: Icon(Icons.search,color: Colors.white,),
            hintText: "Search...",
            hintStyle: TextStyle(
              color: Colors.white
            )
          ),
        );
      }
      else{
        this._searchIcon=new Icon(Icons.search);
        this._appbartitle=Text("Pocket Passwords");
      }
    });
  }

  void ShowAlertBox(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.black,
      ),
    );

    Alert(
        context: context,
        style: alertStyle,
        title: "Create new password",
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 13.0,top: 12.0),
                  child:TextFormField(
                    controller: Ipass,
                    validator: (value){
                      if(value.isEmpty){
                        return 'password cannot be empty';
                      }
                      return null;
                    },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Password",
                ),
              )),
              TextFormField(
                controller: ICpass,
                validator: (value){
                  if(value.isEmpty){
                    return 'confirm password cannot be empty';
                  }
                  else if(value!=Ipass.text){
                    return "password does not match";
                  }

                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Confirm Password",
                ),
              ),

            ],
          ),
        ),
        buttons: [
          DialogButton(
            child: Text("Save",style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w700
            ),),
            onPressed: () {
              if(_formKey.currentState.validate()){
                savePrefrence();
              Navigator.pop(context);
              }
            },
          )
        ]
    ).show();

  }

  void savePrefrence() async {
    final sh= await SharedPreferences.getInstance();
    await sh.setString('passwordApp', Ipass.text);

  }





/*@override
  void initState() {
      _incrementCounter();
  }*/
     }




