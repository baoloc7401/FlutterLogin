// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loginflutter/data/graphql/graphyql_provider.dart';
import 'package:loginflutter/constants/colors.dart';
import 'package:loginflutter/data/queryMutation/login_fetch.dart';
import 'package:loginflutter/data/storage/secure_storage.dart';
import 'package:loginflutter/ui/home_screen.dart';
import 'package:loginflutter/ui/listviewTodo_screen.dart';
import 'package:loginflutter/models/store/login_info.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loginflutter/widgets/checkbox_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SecureStorage secureStorage = SecureStorage();

  final userTextController = TextEditingController();

  final passTextController = TextEditingController();

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
              color: Colors.white,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    child: CircularProgressIndicator(),
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

  Future<dynamic> LoginFunc(
      String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Error!',
            style: TextStyle(color: Colors.redAccent),
          ),
          content: const Text('Please fill all required text fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    try {
      ValueNotifier<GraphQLClient> _client = GraphQLConfig.clientToQuery();
      QueryResult result = await _client.value.mutate(
        MutationOptions(
            document: gql(
              LoginFetch.loginMutation(),
            ),
            variables: LoginFetch.loginMutation_variable(email, password)),
      );
      if (result.isLoading) {
        context.loaderOverlay.show();
      } else if (result.hasException) {
        context.loaderOverlay.hide();
        if (kDebugMode) {
          print(result.exception?.graphqlErrors[0].message);
        }
      } else if (result.data != null) {
        var loginConfig = Login_Info.fromJson(result.data!["login"]);
        context.loaderOverlay.hide();
        return Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeScreen(loginConfig)));
      }
      context.loaderOverlay.hide();
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Error!',
            style: TextStyle(color: Colors.redAccent),
          ),
          content: const Text('Wrong email or password! Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return;
    }
  }

  Widget bodyBuilder(BuildContext context,
      {String email = "", String password = "", bool isChecked = false}) {
    userTextController.text = email;
    passTextController.text = password;
    isChecked = email.isNotEmpty;
    return LoaderOverlay(
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
          onPressed: () => {
            if (isChecked)
              {
                secureStorage.writeSecureData("email", userTextController.text),
                secureStorage.writeSecureData(
                    "password", passTextController.text),
              }
            else
              {
                secureStorage.deleteSecureData("email"),
                secureStorage.deleteSecureData("password")
              },
            LoginFunc(
                userTextController.text, passTextController.text, context),
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
