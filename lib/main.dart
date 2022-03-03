import 'package:flutter/material.dart';
import 'package:loginflutter/constants.dart';
import 'package:loginflutter/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
          primaryColor: fPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: LoginScreen(),
    );
  }
}
