import 'package:flutter/material.dart';
import 'package:loginflutter/data/graphql/graphyql_provider.dart';
import 'package:loginflutter/constants/colors.dart';
import 'package:loginflutter/ui/login_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfig.client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login',
        theme: ThemeData(
            primaryColor: fPrimaryColor, scaffoldBackgroundColor: Colors.white),
        home: const LoginScreen(),
      ),
    );
  }
}
