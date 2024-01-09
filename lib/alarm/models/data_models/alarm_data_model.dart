// import 'dart:ffi';
import 'dart:math';

import 'package:hive/hive.dart';

part 'alarm_data_model.g.dart';

@HiveType(typeId: 0)
class AlarmDataModel {
  @HiveField(0)
  late final int id;
  @HiveField(1)
  final DateTime time;
  @HiveField(2)
  final List<int> weekdays;
  @HiveField(3)
  int period;
  @HiveField(4)
  final String alarmName;
  @HiveField(5)
  final int howlong;

  AlarmDataModel(
      {int? id,
      required this.time,
      required this.weekdays,
      required this.period,
      required this.alarmName,
      required this.howlong}) {
    this.id = id ?? Random.secure().nextInt(10000 - 1000) + 1000;
  }

  AlarmDataModel copyWith(
          {int? id,
          DateTime? time,
          List<int>? weekdays,
          int? period,
          String? alarmName,
          int? howlong}) =>
      AlarmDataModel(
          id: id ?? this.id,
          time: time ?? this.time,
          weekdays: weekdays != null ? List.from(weekdays) : this.weekdays,
          period: period ?? this.period,
          alarmName: alarmName ?? this.alarmName,
          howlong: howlong ?? this.howlong);
}
