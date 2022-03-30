// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Activity_List on _Activity_List, Store {
  final _$ActivitiesAtom = Atom(name: '_Activity_List.Activities');

  @override
  ObservableList<Activity>? get Activities {
    _$ActivitiesAtom.reportRead();
    return super.Activities;
  }

  @override
  set Activities(ObservableList<Activity>? value) {
    _$ActivitiesAtom.reportWrite(value, super.Activities, () {
      super.Activities = value;
    });
  }

  final _$addActivityAsyncAction = AsyncAction('_Activity_List.addActivity');

  @override
  Future<bool> addActivity(String activityTypes, BuildContext context,
      String token, String token_type) {
    return _$addActivityAsyncAction.run(
        () => super.addActivity(activityTypes, context, token, token_type));
  }

  final _$_Activity_ListActionController =
      ActionController(name: '_Activity_List');

  @override
  void initActivities(List<Activity_Json>? Activities_Json) {
    final _$actionInfo = _$_Activity_ListActionController.startAction(
        name: '_Activity_List.initActivities');
    try {
      return super.initActivities(Activities_Json);
    } finally {
      _$_Activity_ListActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
Activities: ${Activities}
    ''';
  }
}
