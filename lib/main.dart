import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:apps2/adminPage.dart';
import 'package:apps2/memberPage.dart';
import 'package:apps2/homePage.dart';
import 'package:apps2/trackLocationPage.dart';
void main() {
  runApp(const MyApp());
}
String username = '';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes:<String,WidgetBuilder> {
        '/AdminPage' : (BuildContext context) => new AdminPage(
          username: username,
        ),
        '/MemberPage' : (BuildContext context) => new MemberPage(),
        '/HomePage' : (BuildContext context) => new HomePage(
          username: username,
        ),
        '/TrackLocationPage' : (BuildContext context) => new TrackLocationPage(
          username: username,
        ),
        '/MyHomePage' : (BuildContext context) =>new MyHomePage(title: 'Home'),

      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isHidePassword = true;
  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  Future<List> _login() async {
    final response =
    await http.post(Uri.parse("http://146.196.106.165/gpstrack/login2.php"), body: {
      "username": user.text,
      "password": pass.text,
    });
    var datauser = json.decode(response.body);
    print(datauser);
    if (datauser.length == 0) {
      setState(() {
        tampil();
      });
    } else {
      Navigator.pushReplacementNamed(context, '/HomePage');
      if (datauser[0]['fld_userlvl'] == '1') {
       // Navigator.pushReplacementNamed(context, '/AdminPage');
      } else if (datauser[0]['fld_userlvl'] == '2') {
      //  Navigator.pushReplacementNamed(context, '/MemberPage');
      }

      setState(() {
        username = datauser[0]['fld_usernm'];
      });
    }
    return datauser;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: TextField(
                  controller: user,
                  decoration: InputDecoration(
                    //hintText: 'Username'

                    fillColor: Colors.lightGreen[40],
                    filled: true,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    prefixStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                    labelText: "Username",
                    hintText: 'Username anda',
                    hintStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w200),
                    labelStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: TextField(
                  controller: pass,
                  obscureText: _isHidePassword,
                  decoration: InputDecoration(
                    //hintText: 'Password'

                    fillColor: Colors.lightGreen[40],
                    filled: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    prefixStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                    labelText: "Password",
                    hintText: 'Pawssord anda',
                    hintStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w200),
                    labelStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _togglePassword();
                      },
                      child: Icon(
                        _isHidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isHidePassword ? Colors.grey : Colors.blue,
                      ),
                    ),
                    isDense: true,

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: RaisedButton(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                  padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                  textColor: Colors.white,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    _login();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void tampil() {
    Fluttertoast.showToast(
        msg: "LOGIN GAGAL",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
