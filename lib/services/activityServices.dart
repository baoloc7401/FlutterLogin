import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loginflutter/data/graphql/graphyql_provider.dart';
import 'package:loginflutter/data/queryMutation/activity.dart';
import 'package:loginflutter/models/activity_json.dart';
import 'package:loginflutter/ui/attendance_screen.dart';
import 'package:intl/intl.dart';

class ActivityServices {
  static Future<bool> CreateActivityFunc(String activityType,
      BuildContext context, String token, String token_type) async {
    try {
      ValueNotifier<GraphQLClient> _client =
          GraphQLConfig.clientToQuery(token: token, tokenType: token_type);
      QueryResult result = await _client.value.mutate(MutationOptions(
        document: gql(
          vfaActivity.createActivityMutation(),
        ),
        variables: vfaActivity.createActivityMutation_variable(activityType),
      ));
      if (result.isLoading) {
        context.loaderOverlay.show();
      } else if (result.hasException) {
        context.loaderOverlay.hide();
        if (kDebugMode) {
          print(result.exception?.graphqlErrors[0].message);
        }
        return false;
      } else if (result.data != null) {
        if (result.data!["createActivity"]["requestResolved"] as bool) {
          context.loaderOverlay.hide();
          return true;
        }
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Error!',
              style: TextStyle(color: Colors.redAccent),
            ),
            content: Text(result.data!["createActivity"]["message"] as String),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return false;
      }
      context.loaderOverlay.hide();
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  static Future<List<Activity_Json>?> GetListActivityFunc(BuildContext context,
      String token, String token_type, String startDate, String endDate) async {
    //String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      ValueNotifier<GraphQLClient> _client =
          GraphQLConfig.clientToQuery(token: token, tokenType: token_type);
      QueryResult result = await _client.value.query(QueryOptions(
        document: gql(
          vfaActivity.myActivityQuery(),
        ),
        variables: vfaActivity.myActivityQuery_variable(startDate, endDate),
      ));
      if (result.isLoading) {
        context.loaderOverlay.show();
      } else if (result.hasException) {
        context.loaderOverlay.hide();
        if (kDebugMode) {
          print(result.exception?.graphqlErrors[0].message);
        }
        return null;
      } else if (result.data != null) {
        if (result.data!["myActivities"]["response"] != null) {
          context.loaderOverlay.hide();
          return (result.data!["myActivities"]["response"] as List)
              .map((i) => Activity_Json.fromJson(i))
              .toList();
        } else {
          return null;
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
