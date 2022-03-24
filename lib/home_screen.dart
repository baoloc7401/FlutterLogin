// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:loginflutter/attendance_screen.dart';
import 'package:loginflutter/constants.dart';
import 'package:loginflutter/listviewTodo.dart';
import 'package:loginflutter/model/loginConfig.dart';
import 'package:mobx/mobx.dart';

class HomeScreen extends StatefulWidget {
  final LoginConfig login_config;
  const HomeScreen(this.login_config, {Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @observable
  int curIndex = 0;
  late var screens = [
    AttendanceScreen(widget.login_config),
    listViewTodo(widget.login_config),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: screens,
        index: curIndex,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: fPrimaryColor,
        buttonBackgroundColor: fSecondaryColor,
        backgroundColor: Colors.transparent,
        height: 60,
        items: const <Widget>[
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            curIndex = index;
          });
        },
      ),
    );
  }
}
