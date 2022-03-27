// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:loginflutter/constants/colors.dart';
import 'package:loginflutter/store/login_info.dart';

class AttendanceScreen extends StatefulWidget {
  Login_Info login_info;
  AttendanceScreen(this.login_info, {Key? key}) : super(key: key);

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

  void checkIn() {
    setState(() {
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
    });
  }

  void checkOut() {
    setState(() {
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
    });
  }

  void goOut() {
    setState(() {
      textDecoCI = TextDecoration.none;
      textDecoCO = TextDecoration.none;
      textDecoGO = TextDecoration.underline;
      textDecoCB = TextDecoration.none;

      text = "have gone out";

      isButtonGODisabled = true;
      isButtonCBDisabled = false;

      iconCI = Icons.work_outline;
      iconCO = Icons.work_off_outlined;
      iconGO = Icons.pause_circle;
      iconCB = Icons.play_circle_outline;
    });
  }

  void comeBack() {
    setState(() {
      text = "have come back";

      textDecoCI = TextDecoration.none;
      textDecoCO = TextDecoration.none;
      textDecoGO = TextDecoration.none;
      textDecoCB = TextDecoration.underline;

      isButtonCBDisabled = true;
      isButtonGODisabled = false;

      iconCI = Icons.work_outline;
      iconCO = Icons.work_off_outlined;
      iconGO = Icons.pause_circle_outline;
      iconCB = Icons.play_circle;
    });
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.2 - 27,
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
                    const TextSpan(
                      text: ' xyz minutes ago.',
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      );

  Widget bigButtonsPaneBuilder() => Positioned.fill(
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
                        onPressed:
                            isButtonCIDisabled ? null : (() => checkIn()),
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
                        onPressed:
                            isButtonCODisabled ? null : (() => checkOut()),
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
                        onPressed:
                            isButtonCBDisabled ? null : (() => comeBack()),
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
