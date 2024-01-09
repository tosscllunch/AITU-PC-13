import 'package:flutter_application_1/alarm/helpers/clock_helper.dart';
import 'package:flutter_application_1/alarm/models/data_models/alarm_data_model.dart';
import 'package:flutter_application_1/alarm/providers/alarm_provider.dart';
import 'package:flutter_application_1/alarm/providers/clock_type_provider.dart';
import 'package:flutter_application_1/alarm/screens/components/body.dart';
import 'package:flutter_application_1/alarm/screens/components/spinner_widget.dart';
import 'package:flutter_application_1/alarm/screens/modify_alarm_screen.dart';
import 'package:flutter_application_1/alarm/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // we have to call this on our starting page
    SizeConfig().init(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: AppBar(
            centerTitle: false,
            title: Text(
              'Будильник',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.teal,
                  ),
            ),
            actions: [
              Consumer<ClockTypeModel>(builder: (context, model, child) {
                // ClockType.analog == true, ClockType.digial == false

                final textStyle = TextStyle(
                  fontSize: 16,
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                );

                return GestureDetector(
                  onTap: () {
                    model.changeType(
                      model.clockType == ClockType.analog
                          ? ClockType.digital
                          : ClockType.analog,
                    );
                  },
                  child: SpinnerWidget(
                    withShader: false,
                    child: model.clockType == ClockType.analog
                        ? SizedBox(
                            key: const ValueKey('Analog'),
                            width: 200,
                            child: Center(
                              child: TextIcon(
                                svgPath: 'assets/icons/analog-clock.svg',
                                child: Text(
                                  'Аналоговые часы',
                                  style: textStyle,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            key: const ValueKey('Digital'),
                            width: 200,
                            child: Center(
                              child: TextIcon(
                                svgPath: 'assets/icons/digital-clock.svg',
                                child: Text(
                                  'Цифровые часы',
                                  style: textStyle,
                                ),
                              ),
                            ),
                          ),
                  ),
                );
              }),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Body(),
        ),
        bottomSheet: const AlarmScheet(),
      ),
    );
  }
}

class AlarmScheet extends StatefulWidget {
  const AlarmScheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AlarmScheet> createState() => _AlarmScheetState();
}

class _AlarmScheetState extends State<AlarmScheet>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  late AnimationController _controller;
  Animation<double>? animation;
  bool expanded = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      )..addListener(() {
          setState(() {});
        });

      animation = Tween(
        begin: getSmallSize(),
        end: getBigSize(),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ));
    });

    super.initState();
  }

  double getBigSize() => MediaQuery.of(context).size.height * .8;

  double getSmallSize() {
    return MediaQuery.of(context).size.height * .8 -
        MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SizedBox(
        height: animation?.value ?? getSmallSize(),
        child: Selector<AlarmModel, AlarmModel>(
          shouldRebuild: (previous, next) {
            if (next.state is AlarmCreated) {
              final state = next.state as AlarmCreated;
              _listKey.currentState?.insertItem(state.index);
            } else if (next.state is AlarmUpdated) {
              final state = next.state as AlarmUpdated;
              if (state.index != state.newIndex) {
                _listKey.currentState?.insertItem(state.newIndex);
                _listKey.currentState?.removeItem(
                  state.index,
                  (context, animation) => CardAlarmItem(
                    alarm: state.alarm,
                    animation: animation,
                  ),
                );
              }
            }
            return true;
          },
          selector: (_, model) => model,
          builder: (context, model, child) {
            return Column(
              children: [
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if ((details.primaryDelta ?? 0) < 0 && !expanded) {
                      // dragging up, expand
                      _controller.forward();
                    } else if ((details.primaryDelta ?? 0) > 0 && expanded) {
                      // dragging up, expand
                      _controller.reverse();
                    }
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          child: Center(
                            child: Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () => Navigator.of(context).pushNamed(
                              ModifyAlarmScreen.routeName,
                            ),
                            icon: const Icon(
                              Icons.alarm_add,
                            ),
                            label: const Text('Добавить будильник'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (model.alarms != null)
                  Expanded(
                    child: AnimatedList(
                      key: _listKey,
                      // not recommended for a list with large number of items
                      shrinkWrap: true,
                      initialItemCount: model.alarms!.length,

                      itemBuilder: (context, index, animation) {
                        if (index >= model.alarms!.length) return Container();
                        final alarm = model.alarms![index];

                        return CardAlarmItem(
                          alarm: alarm,
                          animation: animation,
                          onDelete: () async {
                            _listKey.currentState?.removeItem(
                              index,
                              (context, animation) => CardAlarmItem(
                                alarm: alarm,
                                animation: animation,
                              ),
                            );
                            await model.deleteAlarm(alarm, index);
                          },
                          onTap: () => Navigator.of(context).pushNamed(
                            ModifyAlarmScreen.routeName,
                            arguments: ModifyAlarmScreenArg(alarm, index),
                          ),
                        );
                      },
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}

class CardAlarmItem extends StatelessWidget {
  const CardAlarmItem({
    Key? key,
    required this.alarm,
    required this.animation,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  final AlarmDataModel alarm;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).chain(CurveTween(curve: Curves.elasticInOut)),
      ),
      child: Card(
        child: ListTile(
          title: Text(
            fromTimeToString(alarm.time),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          subtitle: Text(
            '${alarm.alarmName} : ${alarm.period > 0 ? fromPeriodToString(alarm.period) : alarm.weekdays.isEmpty ? 'Один раз' : alarm.weekdays.length == 7 ? 'Каждый день' : alarm.weekdays.map((weekday) => fromWeekdayToStringShort(weekday)).join(', ')}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.cancel),
            color: Colors.red,
            onPressed: () async {
              if (onDelete != null) onDelete!();
            },
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class TextIcon extends StatelessWidget {
  final Widget child;
  final String svgPath;

  const TextIcon({
    Key? key,
    required this.child,
    required this.svgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          svgPath,
          width: 20,
          height: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        child,
      ],
    );
  }
}
