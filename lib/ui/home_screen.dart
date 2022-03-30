// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loginflutter/models/activity_json.dart';
import 'package:loginflutter/services/activityServices.dart';
import 'package:loginflutter/store/activity_list.dart';
import 'package:loginflutter/ui/attendance_screen.dart';
import 'package:loginflutter/constants/colors.dart';
import 'package:loginflutter/ui/listviewTodo_screen.dart';
import 'package:loginflutter/models/login_info_json.dart';
import 'package:loginflutter/ui/myActivityList_screen.dart';
import 'package:loginflutter/widgets/drawer_widget.dart';
import 'package:mobx/mobx.dart';

class HomeScreen extends StatefulWidget {
  final Login_Info_Json login_info;
  Activity_List? activity_list;
  HomeScreen(this.login_info, this.activity_list, {Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @observable
  int curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return bodyBuilder();
  }

  Widget bodyBuilder() {
    var screens = [
      AttendanceScreen(widget.login_info, widget.activity_list),
      listViewTodo_screen(widget.login_info),
      MyActivityList(widget.login_info, widget.activity_list)
    ];
    return LoaderOverlay(
      child: Scaffold(
        drawer: CustomDrawer(widget.login_info.user.userFullName,
            widget.login_info.user.vfaEmail),
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
            Icon(
              Icons.list_alt,
              color: Colors.white,
            )
          ],
          onTap: (index) {
            setState(() {
              curIndex = index;
            });
          },
        ),
      ),
    );
  }
}
