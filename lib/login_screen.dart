import 'package:flutter/material.dart';
import 'package:loginflutter/constants.dart';
import 'package:loginflutter/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  bool signIn(String user, String pass) {
    return user == "admin" && pass == "123";
  }

  void _navigateToNextScreen(BuildContext context) {
    if (signIn(userTextController.text, passTextController.text)) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      showDialog<String>(
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
    }
  }

  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

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
                                  'The username is admin and the password is 123.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                          userTextController.text = 'admin',
                          passTextController.text = '123'
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
                      onPressed: () => {_navigateToNextScreen(context)},
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(fPrimaryColor),
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
            )));
  }
}
