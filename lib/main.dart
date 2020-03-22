
import 'package:flutter/material.dart';
import 'package:bee_tracker/account_login/login_page.dart';




void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Huchi Hive',
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      home: new LoginPage(),
      // home: DetailPage(),
    );
  }
}


