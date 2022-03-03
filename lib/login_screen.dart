import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginflutter/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(0),
                    child: const Image(
                        image: AssetImage('assets/logo/vitalify.jpg'))),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Please Enter User's Email",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                )
              ],
            )));
  }
}
