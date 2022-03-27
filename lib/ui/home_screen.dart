// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:loginflutter/ui/attendance_screen.dart';
import 'package:loginflutter/constants/colors.dart';
import 'package:loginflutter/ui/listviewTodo_screen.dart';
import 'package:loginflutter/store/login_info.dart';
import 'package:mobx/mobx.dart';

class HomeScreen extends StatefulWidget {
  final Login_Info login_info;
  const HomeScreen(this.login_info, {Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @observable
  int curIndex = 0;
  late var screens = [
    AttendanceScreen(widget.login_info),
    listViewTodo_screen(widget.login_info),
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
