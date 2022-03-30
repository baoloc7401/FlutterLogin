// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:loginflutter/models/activity_json.dart';
import 'package:loginflutter/services/activityServices.dart';
import 'package:loginflutter/store/activity.dart';
import 'package:mobx/mobx.dart';
part 'activity_list.g.dart';

class Activity_List = _Activity_List with _$Activity_List;

abstract class _Activity_List with Store {
  @observable
  ObservableList<Activity>? Activities = ObservableList<Activity>();
  @action
  void initActivities(List<Activity_Json>? Activities_Json) {
    if (Activities_Json != null) {
      for (var activity in Activities_Json) {
        Activities!.add(Activity(
          activity.activityTypes,
          activity.activityDescription,
          activity.createdAt,
        ));
      }
    } else {
      if (kDebugMode) print("Empty");
    }
  }

  @action
  Future<bool> addActivity(String activityTypes, BuildContext context,
      String token, String token_type) async {
    if (await ActivityServices.CreateActivityFunc(
        activityTypes, context, token, token_type)) {
      Activities!.add(Activity(
          activityTypes,
          /* "${activityTypes[0]}${activityTypes.substring(1).toLowerCase()} at: ${DateFormat('M/d/yyyy, hh:mm:ss a').format(DateTime.now())}"
              .replaceAll(RegExp('[\\W_]+'), ' ') */
          (await ActivityServices.GetListActivityFunc(
                  context,
                  token,
                  token_type,
                  DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  DateFormat('yyyy-MM-dd').format(DateTime.now())))!
              .last
              .activityDescription,
          DateTime.now().toIso8601String()));
      return true;
    }
    return false;
  }
}
