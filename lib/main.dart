import 'package:flutter/material.dart';
import 'package:loginflutter/GraphQL/graphyql_provider.dart';
import 'package:loginflutter/constants.dart';
import 'package:loginflutter/login_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLClass.clientNonAuth,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login',
        theme: ThemeData(
            primaryColor: fPrimaryColor, scaffoldBackgroundColor: Colors.white),
        home: LoginScreen(),
      ),
    );
  }
}
