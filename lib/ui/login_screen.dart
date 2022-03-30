// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loginflutter/constants/colors.dart';
import 'package:loginflutter/data/storage/secure_storage.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:loginflutter/models/activity_json.dart';
import 'package:loginflutter/models/login_info_json.dart';
import 'package:loginflutter/services/activityServices.dart';
import 'package:loginflutter/services/auth.dart';
import 'package:loginflutter/store/activity_list.dart';
import 'package:loginflutter/ui/home_screen.dart';
import 'package:loginflutter/widgets/checkbox_widget.dart';
import 'package:mobx/mobx.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SecureStorage secureStorage = SecureStorage();

  final userTextController = TextEditingController();

  final passTextController = TextEditingController();

  @observable
  Activity_List? activity_list;

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return (result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          secureStorage.readSecureData("email"),
          secureStorage.readSecureData("password"),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: bodyBuilder(context,
                    email: snapshot.data![0] ?? "",
                    password: snapshot.data![1] ?? ""));
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ],
              )),
            );
          } else {
            return Container(
              color: Colors.lightBlue.withOpacity(0.1),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                    width: 60,
                    height: 60,
                  ),
                ],
              )),
            );
          }
        });
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    super.dispose();
  }

  Widget bodyBuilder(BuildContext context,
      {String email = "", String password = "", bool isChecked = false}) {
    userTextController.text = email;
    passTextController.text = password;
    isChecked = email.isNotEmpty;
    return LoaderOverlay(
      overlayColor: Colors.blue,
      child: Container(
          constraints: const BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 250,
                  height: 150,
                  padding: const EdgeInsets.all(0),
                  child: const Image(
                      image: AssetImage('assets/logo/vitalify.jpg'))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: textFieldBuilder(
                      title: "Please Enter User's Email",
                      iconData: Icons.person,
                      controller: userTextController)),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: textFieldBuilder(
                      isPassword: true,
                      title: "Please Enter User's Password",
                      iconData: Icons.lock,
                      controller: passTextController)),
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                        child: forgotPassFieldBuilder()),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: CustomCheckBox(
                        title: "Save password",
                        value: isChecked,
                        onChanged: (value) => setState(() {
                          isChecked = value!;
                        }),
                      ))
                ],
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: signInButtonBuilder(isChecked)),
            ],
          )),
    );
  }

  Widget forgotPassFieldBuilder() => InkWell(
        onTap: () => {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'It\'s okay to forget...',
                style: TextStyle(color: Colors.blueAccent),
              ),
              content: const Text(
                  'The username is lll@lll.lll and the password is 12345678.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
          userTextController.text = 'lll@lll.lll',
          passTextController.text = '12345678'
        },
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
          textAlign: TextAlign.right,
        ),
      );

  Widget textFieldBuilder(
          {bool isPassword = false,
          required String title,
          required IconData iconData,
          required TextEditingController controller}) =>
      TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: title,
          prefixIcon: Icon(iconData),
        ),
      );

  Widget signInButtonBuilder(bool isChecked) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            context.loaderOverlay.show();
            if (await checkInternet()) {
              if (isChecked) {
                secureStorage.writeSecureData("email", userTextController.text);
                secureStorage.writeSecureData(
                    "password", passTextController.text);
              } else {
                secureStorage.deleteSecureData("email");
                secureStorage.deleteSecureData("password");
              }
              Login_Info_Json? login_info = await Authorization.LoginFunc(
                  userTextController.text, passTextController.text, context);
              if (login_info != null) {
                activity_list = Activity_List();
                List<Activity_Json>? activites =
                    await ActivityServices.GetListActivityFunc(
                        context,
                        login_info.token,
                        login_info.token_type,
                        "2022-03-27",
                        DateFormat('yyyy-MM-dd').format(DateTime.now()));
                activity_list?.initActivities(activites);
                context.loaderOverlay.hide();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen(login_info, activity_list)));
              }
            } else {
              context.loaderOverlay.hide();
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Error!',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  content: const Text('No internet connection!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(fButtonColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ))),
          child: const Text(
            "Sign In",
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
}
