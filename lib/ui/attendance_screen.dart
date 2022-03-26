// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:loginflutter/constants/colors.dart';
import 'package:loginflutter/models/loginInfo.dart';

class AttendanceScreen extends StatefulWidget {
  LoginInfo login_info;
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

  void CheckIn() {
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

  void CheckOut() {
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

  void GoOut() {
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

  void ComeBack() {
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

  ButtonStyle BigButtonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: const Size(0, double.infinity),
      elevation: 10,
      primary: Colors.white,
      onSurface: Colors.blue,
      onPrimary: Colors.blue,
    );
  }

  TextStyle BigButtonTextStyle() {
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
                Row(
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
                ),
                Positioned.fill(
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
                                  onPressed: isButtonCIDisabled
                                      ? null
                                      : (() => CheckIn()),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(iconCI,
                                          size: 100, color: Colors.blue),
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
                                          style: BigButtonTextStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: BigButtonStyle()),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: isButtonCODisabled
                                      ? null
                                      : (() => CheckOut()),
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
                                          style: BigButtonTextStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: BigButtonStyle()),
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
                                  onPressed: isButtonGODisabled
                                      ? null
                                      : (() => GoOut()),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(iconGO,
                                          color: Colors.blue, size: 100),
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
                                          style: BigButtonTextStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: BigButtonStyle()),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: isButtonCBDisabled
                                      ? null
                                      : (() => ComeBack()),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(iconCB,
                                          color: Colors.blue, size: 100),
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
                                          style: BigButtonTextStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: BigButtonStyle()),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
