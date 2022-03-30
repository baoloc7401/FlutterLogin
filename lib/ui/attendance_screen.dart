// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loginflutter/constants/colors.dart';
import 'package:loginflutter/models/login_info_json.dart';
import 'package:loginflutter/ui/personalInfo_screen.dart';
import 'package:loginflutter/widgets/drawer_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:loginflutter/store/activity_list.dart';
import 'package:after_layout/after_layout.dart';

class AttendanceScreen extends StatefulWidget {
  final Login_Info_Json login_info;
  @observable
  Activity_List? activity_list;
  AttendanceScreen(this.login_info, this.activity_list, {Key? key})
      : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String text = "haven't checked in";

  TextDecoration textDecoCI = TextDecoration.none;
  TextDecoration textDecoCO = TextDecoration.none;
  TextDecoration textDecoGO = TextDecoration.none;
  TextDecoration textDecoCB = TextDecoration.none;

  bool isButtonCIDisabled = false;
  bool isButtonCODisabled = true;
  bool isButtonGODisabled = true;
  bool isButtonCBDisabled = true;

  IconData iconCI = Icons.work_outline;
  IconData iconCO = Icons.work_off_outlined;
  IconData iconGO = Icons.pause_circle_outline;
  IconData iconCB = Icons.play_circle_outline;

  @override
  Widget build(BuildContext context) {
    AdjustUIBasedOnActivity(
        widget.activity_list?.Activities?.last.activityTypes);
    return LoaderOverlay(
        overlayColor: Colors.blue, child: Scaffold(body: bodyBuilder()));
  }

  Future<void> checkIn() async {
    context.loaderOverlay.show();
    if (await widget.activity_list!.addActivity("CHECK_IN", context,
        widget.login_info.token, widget.login_info.token_type)) {
      setState(() {});
      context.loaderOverlay.hide();
    }
  }

  Future<void> checkOut() async {
    context.loaderOverlay.show();
    if (await widget.activity_list!.addActivity("CHECK_OUT", context,
        widget.login_info.token, widget.login_info.token_type)) {
      setState(() {});
      context.loaderOverlay.hide();
    }
  }

  Future<void> goOut() async {
    context.loaderOverlay.show();

    if (await widget.activity_list!.addActivity("GO_OUT", context,
        widget.login_info.token, widget.login_info.token_type)) {
      setState(() {});
      context.loaderOverlay.hide();
    }
  }

  Future<void> comeBack() async {
    context.loaderOverlay.show();

    if (await widget.activity_list!.addActivity("COME_BACK", context,
        widget.login_info.token, widget.login_info.token_type)) {
      setState(() {});
      context.loaderOverlay.hide();
    }
  }

  ButtonStyle bigButtonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: const Size(0, double.infinity),
      elevation: 10,
      primary: Colors.white,
      onSurface: Colors.blue,
      onPrimary: Colors.blue,
    );
  }

  TextStyle bigButtonTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blue,
      fontSize: 25,
    );
  }

  void AdjustUIBasedOnActivity(String? ActivityTypes) {
    switch (ActivityTypes) {
      case "CHECK_IN":
        text = "have checked in";
        textDecoCI = TextDecoration.underline;
        textDecoCO = TextDecoration.none;

        isButtonCIDisabled = true;
        isButtonCODisabled = false;
        isButtonGODisabled = false;
        isButtonCBDisabled = true;

        iconCI = Icons.work;
        iconCO = Icons.work_off_outlined;
        iconGO = Icons.pause_circle_outline;
        iconCB = Icons.play_circle_outline;
        break;
      case "CHECK_OUT":
        text = "have checked out";

        textDecoCI = TextDecoration.none;
        textDecoCO = TextDecoration.underline;
        textDecoGO = TextDecoration.none;
        textDecoCB = TextDecoration.none;

        isButtonCIDisabled = false;
        isButtonCODisabled = true;
        isButtonGODisabled = true;
        isButtonCBDisabled = true;

        iconCI = Icons.work_outline;
        iconCO = Icons.work_off;
        iconGO = Icons.pause_circle_outline;
        iconCB = Icons.play_circle_outline;
        break;
      case "GO_OUT":
        textDecoCI = TextDecoration.none;
        textDecoCO = TextDecoration.none;
        textDecoGO = TextDecoration.underline;
        textDecoCB = TextDecoration.none;

        text = "have gone out";

        isButtonCIDisabled = true;
        isButtonGODisabled = true;
        isButtonCBDisabled = false;
        isButtonCODisabled = true;

        iconCI = Icons.work_outline;
        iconCO = Icons.work_off_outlined;
        iconGO = Icons.pause_circle;
        iconCB = Icons.play_circle_outline;
        break;
      case "COME_BACK":
        text = "have come back";

        textDecoCI = TextDecoration.none;
        textDecoCO = TextDecoration.none;
        textDecoGO = TextDecoration.none;
        textDecoCB = TextDecoration.underline;

        isButtonCIDisabled = true;
        isButtonCODisabled = false;
        isButtonCBDisabled = true;
        isButtonGODisabled = false;

        iconCI = Icons.work_outline;
        iconCO = Icons.work_off_outlined;
        iconGO = Icons.pause_circle_outline;
        iconCB = Icons.play_circle;
        break;
      default:
        text = "haven't checked in";

        textDecoCI = TextDecoration.none;
        textDecoCO = TextDecoration.none;
        textDecoGO = TextDecoration.none;
        textDecoCB = TextDecoration.none;

        isButtonCIDisabled = false;
        isButtonCODisabled = true;
        isButtonGODisabled = true;
        isButtonCBDisabled = true;

        iconCI = Icons.work_outline;
        iconCO = Icons.work_off_outlined;
        iconGO = Icons.pause_circle_outline;
        iconCB = Icons.play_circle_outline;
        break;
    }
  }

  Widget bodyBuilder() {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: CustomDrawer(
        widget.login_info.user.userFullName,
        widget.login_info.user.vfaEmail,
      ),
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.1 + 10,
                  decoration: const BoxDecoration(
                      color: fPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36))),
                ),
                titlePaneBuilder(),
                bigButtonsPaneBuilder()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titlePaneBuilder() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Column>[
          Column(
            children: <Widget>[
              const Text(
                "Attendance Screen",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'You ',
                    ),
                    TextSpan(
                      text: text,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      );

  Widget bigButtonsPaneBuilder() {
    return Positioned.fill(
      left: 20,
      right: 20,
      top: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: isButtonCIDisabled ? null : (() => checkIn()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(iconCI, size: 100, color: Colors.blue),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Check In",
                                  style: TextStyle(
                                    decoration: textDecoCI,
                                  ),
                                )
                              ],
                              style: bigButtonTextStyle(),
                            ),
                          ),
                        ],
                      ),
                      style: bigButtonStyle()),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: isButtonCODisabled ? null : (() => checkOut()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            iconCO,
                            color: Colors.blue,
                            size: 100,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Check Out",
                                  style: TextStyle(
                                    decoration: textDecoCO,
                                  ),
                                )
                              ],
                              style: bigButtonTextStyle(),
                            ),
                          ),
                        ],
                      ),
                      style: bigButtonStyle()),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: isButtonGODisabled ? null : (() => goOut()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(iconGO, color: Colors.blue, size: 100),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Go Out",
                                  style: TextStyle(
                                    decoration: textDecoGO,
                                  ),
                                )
                              ],
                              style: bigButtonTextStyle(),
                            ),
                          ),
                        ],
                      ),
                      style: bigButtonStyle()),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: isButtonCBDisabled ? null : (() => comeBack()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(iconCB, color: Colors.blue, size: 100),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Come Back",
                                  style: TextStyle(
                                    decoration: textDecoCB,
                                  ),
                                )
                              ],
                              style: bigButtonTextStyle(),
                            ),
                          ),
                        ],
                      ),
                      style: bigButtonStyle()),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
