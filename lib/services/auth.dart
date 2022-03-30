import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loginflutter/data/graphql/graphyql_provider.dart';
import 'package:loginflutter/data/queryMutation/login_fetch.dart';
import 'package:loginflutter/ui/home_screen.dart';
import 'package:loginflutter/models/login_info_json.dart';

class Authorization {
  static Future<Login_Info_Json?> LoginFunc(
      String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      showDialog<String>(
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
      return null;
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
        var loginConfig = Login_Info_Json.fromJson(result.data!["login"]);
        context.loaderOverlay.hide();
        return loginConfig;
      }
      context.loaderOverlay.hide();
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
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
