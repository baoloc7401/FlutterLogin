// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loginflutter/GraphQL/graphyql_provider.dart';
import 'package:loginflutter/constants.dart';
import 'package:loginflutter/home_screen.dart';
import 'package:loginflutter/listviewTodo.dart';
import 'package:loginflutter/model/loginConfig.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: bodyBuilder(context));
  }

  Future<dynamic> LoginFunc(
      String email, String password, BuildContext context) async {
    try {
      GraphQLClient _client = GraphQLClass.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
            document: gql(
              GraphQLClass.LoginMutation(),
            ),
            variables: GraphQLClass.LoginVariable(email, password)),
      );
      if (result.isLoading) {
        context.loaderOverlay.show();
      } else if (result.hasException) {
        context.loaderOverlay.hide();
        if (kDebugMode) {
          print(result.exception?.graphqlErrors[0].message);
        }
      } else if (result.data != null) {
        var loginConfig = LoginConfig.fromJson(result.data!["login"]);
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

  Widget bodyBuilder(BuildContext context) {
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
                child: TextField(
                  controller: userTextController,
                  decoration: const InputDecoration(
                    labelText: "Please Enter User's Email",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      controller: passTextController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Please Enter User's Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                    child: InkWell(
                      onTap: () => {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                              'It\'s okay to forget...',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            content: const Text(
                                'The username is bbb@bbb.bbb and the password is 12345678.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                        userTextController.text = 'bbb@bbb.bbb',
                        passTextController.text = '12345678'
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.deepOrange,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => {
                      LoginFunc(userTextController.text,
                          passTextController.text, context)
                    },
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(fButtonColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ))),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
