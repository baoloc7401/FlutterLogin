// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Activity on _Activity, Store {
  final _$activityTypesAtom = Atom(name: '_Activity.activityTypes');

  @override
  String get activityTypes {
    _$activityTypesAtom.reportRead();
    return super.activityTypes;
  }

  @override
  set activityTypes(String value) {
    _$activityTypesAtom.reportWrite(value, super.activityTypes, () {
      super.activityTypes = value;
    });
  }

  final _$activityDescriptionAtom = Atom(name: '_Activity.activityDescription');

  @override
  String get activityDescription {
    _$activityDescriptionAtom.reportRead();
    return super.activityDescription;
  }

  @override
  set activityDescription(String value) {
    _$activityDescriptionAtom.reportWrite(value, super.activityDescription, () {
      super.activityDescription = value;
    });
  }

  final _$createdAtAtom = Atom(name: '_Activity.createdAt');

  @override
  String get createdAt {
    _$createdAtAtom.reportRead();
    return super.createdAt;
  }

  @override
  set createdAt(String value) {
    _$createdAtAtom.reportWrite(value, super.createdAt, () {
      super.createdAt = value;
    });
  }

  @override
  String toString() {
    return '''
activityTypes: ${activityTypes},
activityDescription: ${activityDescription},
createdAt: ${createdAt}
    ''';
  }
}
