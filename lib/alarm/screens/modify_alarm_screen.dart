// ignore_for_file: use_build_context_synchronously

import 'package:flutter_application_1/alarm/helpers/clock_helper.dart';
import 'package:flutter_application_1/alarm/models/data_models/alarm_data_model.dart';
import 'package:flutter_application_1/alarm/providers/alarm_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifyAlarmScreenArg {
  final AlarmDataModel alarm;
  final int index;

  ModifyAlarmScreenArg(this.alarm, this.index);
}

class ModifyAlarmScreen extends StatefulWidget {
  static const routeName = '/modifyAlarm';

  final ModifyAlarmScreenArg? arg;

  const ModifyAlarmScreen({
    Key? key,
    this.arg,
  }) : super(key: key);

  @override
  State<ModifyAlarmScreen> createState() => _ModifyAlarmScreenState();
}

class _ModifyAlarmScreenState extends State<ModifyAlarmScreen> {
  late AlarmDataModel alarm = widget.arg?.alarm ??
      AlarmDataModel(
          time: DateTime.now(),
          weekdays: [],
          period: 0,
          alarmName: 'Без названия',
          howlong: 0);

  bool get _editing => widget.arg?.alarm != null;

  final nameTextFieldController = TextEditingController();
  final howLongDaysTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameTextFieldController.text =
        (alarm.alarmName != 'Без названия') ? alarm.alarmName : '';
    howLongDaysTextFieldController.text =
        (alarm.howlong != 0) ? alarm.howlong.toString() : "";
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: TextButton(
              child: const Text('Отмена'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            leadingWidth: 100,
            actions: [
              TextButton(
                child: const Text('Сохранить'),
                onPressed: () async {
                  final model = context.read<AlarmModel>();
                  _editing
                      ? await model.updateAlarm(alarm, widget.arg!.index)
                      : await model.addAlarm(alarm);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        brightness: Theme.of(context).brightness,
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (value) {
                          setState(() {
                            alarm = alarm.copyWith(time: value);
                          });
                        },
                        initialDateTime: alarm.time,
                      ),
                    ),
                  ),
                  //___________________________
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 60, right: 60, bottom: 10, top: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.teal[80],
                      ),
                      child: TextField(
                        // keyboardType: TextInputType.number,

                        controller: nameTextFieldController,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5),
                          labelText: 'Название будильника',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        enableSuggestions: false,
                        autocorrect: false,
                        onChanged: (value) {
                          setState(() {
                            alarm = alarm.copyWith(alarmName: value);
                          });
                        },
                      ),
                    ),
                  ),

                  (alarm.period == 0)
                      ? ExpansionTile(
                          title: Text(
                            'Повтор по дням недели',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          trailing: Text(
                            alarm.weekdays.isEmpty
                                ? ''
                                : alarm.weekdays.length == 7
                                    ? 'Каждый день'
                                    : alarm.weekdays
                                        .map((weekday) =>
                                            fromWeekdayToStringShort(weekday))
                                        .join(', '),
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          children: List.generate(7, (index) => index + 1)
                              .map((weekday) {
                            final checked = alarm.weekdays.contains(weekday);
                            return CheckboxListTile(
                                title: Text(
                                  fromWeekdayToString(weekday),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                                value: checked,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                onChanged: (value) {
                                  setState(() {
                                    (value ?? false)
                                        ? alarm.weekdays.add(weekday)
                                        : alarm.weekdays.remove(weekday);
                                  });
                                });
                          }).toList(),
                        )
                      : const SizedBox(
                          width: 1,
                        ),

                  // =============Повтор по количеству дням
                  (alarm.weekdays.isEmpty)
                      ? ExpansionTile(
                          title: Text(
                            'Повтор по количеству дней',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          trailing: Text(
                            fromPeriodToString(alarm.period),
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          children: List.generate(10, (index) => index + 1)
                              .map((period1) {
                            final checked = period1 == alarm.period;
                            return CheckboxListTile(
                                title: Text(
                                  fromPeriodToString(period1),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                                value: checked,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                onChanged: (value) {
                                  setState(() {
                                    alarm.period = period1;
                                  });
                                });
                          }).toList(),
                        )
                      : const SizedBox(
                          width: 1,
                        ),
                  (alarm.period > 0)
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.teal[80],
                          ),
                          child: TextField(
                            // keyboardType: TextInputType.number,
                            controller: howLongDaysTextFieldController,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 0),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Colors.black,
                              ),
                              labelText:
                                  "Длительность полного курса лечения в днях",
                            ),
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.number,

                            onChanged: (value) {
                              try {
                                var howl = int.parse(value) / (alarm.period);
                                alarm = alarm.copyWith(howlong: howl.round());
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        )
                      : const SizedBox(
                          width: 1,
                        ),
                ],
              ),
            ),
          )),
    );
  }
}
