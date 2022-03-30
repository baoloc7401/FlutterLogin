import 'package:mobx/mobx.dart';

part 'activity.g.dart';

class Activity = _Activity with _$Activity;

abstract class _Activity with Store {
  _Activity(this.activityTypes, this.activityDescription, this.createdAt);
  @observable
  String activityTypes;
  @observable
  String activityDescription;
  @observable
  String createdAt;
}
